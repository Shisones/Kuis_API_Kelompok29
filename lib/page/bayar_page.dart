import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';
import 'package:kuis_api_kel29/provider/cart_api.dart';
import 'package:kuis_api_kel29/provider/bayar_api.dart';

import 'package:kuis_api_kel29/page/home_page.dart';

class BayarPage extends StatefulWidget {
  final int userID;
  final String accessToken;

  const BayarPage({
    Key? key,
    required this.userID,
    required this.accessToken,
  }) : super(key: key);

  @override
  _BayarPageState createState() => _BayarPageState();
}

class _BayarPageState extends State<BayarPage> {
  String status = 'Loading'; // Variabel untuk menyimpan status pembayaran
  bool _isProcessing = false; // Menyimpan status apakah proses sedang berlangsung
  bool _isOrderReceived = false; // Menyimpan status apakah pesanan sudah diterima atau belum


  @override
  void initState() {
    super.initState();
    // _getStatus(); // Panggil metode untuk mendapatkan status pembayaran saat halaman dimuat
  }

  Future<void> _getStatus() async {
    try {
      final pembayaranProvider = Provider.of<Pembayaran>(context, listen: false);
      final statusResponse = await pembayaranProvider.getStatus(widget.userID.toString(), 'Bearer ${widget.accessToken}');
      setState(() {
        status = statusResponse;
      });
    } catch (error) {
      status = 'Failed to get status: $error'; // Assign error message to status
    }
  }

  Future<void> _processOrder() async {
  final pembayaranProvider = Provider.of<Pembayaran>(context, listen: false);
  try {
    setState(() {
      _isProcessing = true; // Menandai bahwa proses sedang berlangsung
    });

    setState(() {
      status = 'Pesananmu sedang dibuat'; // Mengubah status saat pesanan sedang diantar
    });
    // Penjual menerima
    await pembayaranProvider.setStatusPenjualTerima(widget.userID.toString(), 'Bearer ${widget.accessToken}');
    // Tunggu pesanan sedang dimasak
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      status = 'Pesananmu sedang diantar'; // Mengubah status saat pesanan sedang diantar
    });
    // Pesanan sedang diantar
    await pembayaranProvider.setStatusDiantar(widget.userID.toString(), 'Bearer ${widget.accessToken}');
    // Tunggu pesanan diantar
    await Future.delayed(Duration(seconds: 5));


    // Pesanan diterima
    setState(() {
      status = 'Pesanan diterima'; // Mengubah status saat pesanan diterima
      _isOrderReceived = true;
    });
    await pembayaranProvider.setStatusDiterima(widget.userID.toString(), 'Bearer ${widget.accessToken}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pesanan diterima!'),
        duration: Duration(seconds: 1),
      ),
    );

    _getStatus(); // Perbarui status setelah pesanan diterima
  } catch (error) {
    print(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pembayaran gagal: $error'),
        duration: Duration(seconds: 1),
      ),
    );
  } finally {
    setState(() {
      _isProcessing = false; // Menandai bahwa proses telah selesai
    });
  }
}


  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isProcessing
                  ? Column(
                      children: [
                        CircularProgressIndicator(), // Tampilkan CircularProgressIndicator jika proses sedang berlangsung
                        SizedBox(height: 20),
                        Text(
                          status, // Tampilkan status pembayaran
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  : _isOrderReceived
                      ? Column(
                        children: [
                          Text("Pesananmu sudah selesai"),
                          SizedBox(height: 10,),
                          ElevatedButton(
                              onPressed: () {
                                // Tombol untuk kembali ke halaman Home
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      userID: widget.userID,
                                      accessToken: widget.accessToken,
                                    ),
                                  ),
                                );
                              },
                              child: Text('Kembali ke Home'),
                            ),
                        ],
                      )
                      : ElevatedButton(
                          onPressed: _processOrder,
                          child: Text('Bayar'),
                        ),
            ],
          ),
        ),
      );
    }
  }
