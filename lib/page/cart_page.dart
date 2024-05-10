import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final int userId;
  final List<Map<String, dynamic>> wholeCarts;

  const CartPage({
    Key? key,
    required this.userId,
    required this.wholeCarts,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> 
{
  // List<Map<String, dynamic>> listCarts = [];

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
        itemCount: widget.wholeCarts.length,
        itemBuilder: (context, index) {
          final cartItem = widget.wholeCarts[index];
          return ListTile(
            title: Text("Item ID: ${cartItem['item_id']}"),
            subtitle: Text("Quantity: ${cartItem['quantity']}"),
            // trailing: IconButton(),
          );
        },
      ),

      ),
    );
  }
}
