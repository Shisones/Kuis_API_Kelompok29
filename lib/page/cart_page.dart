import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';
import 'package:kuis_api_kel29/provider/cart_api.dart';

class CartPage extends StatefulWidget {
  final int userID;
  final String accessToken;

  const CartPage({
    Key? key,
    required this.userID,
    required this.accessToken,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> 
{
  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  List<dynamic> listCart = [];

  Future<void> _fetchCart() async {
    final userId = widget.userID;
    final accessToken = widget.accessToken;
    final cartResponse = await Provider.of<CartList>(context, listen: false)
        .fetchCart(userId.toString(), 'Bearer $accessToken');
    setState(() {
      listCart = cartResponse;
    });
  }
  // List<dynamic> listCarts = widget.listCart;
  // Future<void> _fetchCart() async {
  //   final userId = widget.userID;
  //   final accessToken = widget.accessToken;
  //   final cartResponse = await Provider.of<CartList>(context, listen: false)
  //       .fetchCart(userId.toString(), 'Bearer $accessToken');
  //   setState(() {
  //     listCart = cartResponse;
  //   });
  // }
  // final listCart = widget.listCart

  // Future<void> _deleteCartItem(String cart_id) async
  // {
  //   final userId = widget.userID;
  //   final accessToken = widget.accessToken;
  //   var wholeCarts = widget.listCart;
  //   await Provider.of<CartList>(context, listen: false).deleteFromCart(cart_id, 'Bearer $accessToken');
    
  //   // setState(() {
  //   //   wholeCarts = cartResponse;
  //   // });
  // }

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: Scaffold
      (
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 36, 36, 36),
          elevation: 0,
          leading: IconButton
          ( // Tambahkan leading untuk menampilkan ikon kembali
            icon: const Icon(Icons.arrow_back_ios_new_rounded), // Gunakan ikon kembali
            color: Colors.white,
            onPressed: () 
            {
              Navigator.of(context).pop(); // Panggil metode pop untuk kembali ke halaman sebelumnya
            },
          ),

          centerTitle: true,
          title: const Text(
            "Your Carts",
            style: const TextStyle(color: Colors.white),
          ),

        ),
        body: ListView.builder(
          itemCount: listCart.length,
          itemBuilder: (context, index) {
            final cartItem = listCart[index];
            return ListTile(
              title: Text("Item ID: ${cartItem.item_id}"),
              subtitle: Text("Quantity: ${cartItem.quantity}"),
              trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {

                try {
                  // Tampilkan indikator aktivitas selama proses berlangsung
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Deleting from cart...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  // Tambahkan item ke keranjang secara asinkron
                  await Provider.of<CartList>(context, listen: false).deleteFromCart(cartItem.id.toString(), 'Bearer ${widget.accessToken}');
                  // Fetch updated cart data
                  _fetchCart();
                  // Tampilkan notifikasi item berhasil ditambahkan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item deleted from cart successfully!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } catch (error) {
                  // Tangani error jika ada
                  print('Error deleting item from cart: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to deleting item from cart: $error'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
            );
          },
        ),


      ),
    );
  }
}