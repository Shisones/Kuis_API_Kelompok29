import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';
import 'package:kuis_api_kel29/provider/bayar_api.dart';
import 'package:kuis_api_kel29/provider/cart_api.dart';

import 'package:kuis_api_kel29/page/bayar_page.dart';

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

class _CartPageState extends State<CartPage> {
  List<dynamic> listCart = [];
  List<dynamic> listItem = [];

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchItems() async {
    final userId = widget.userID;
    final accessToken = widget.accessToken;
    final itemResponse = await Provider.of<ItemList>(context, listen: false)
        .fetchData('Bearer $accessToken');
    setState(() {
      listItem = itemResponse;
    });
  }

  Future<void> _fetchCart() async {
    final userId = widget.userID;
    final accessToken = widget.accessToken;
    final cartResponse = await Provider.of<CartList>(context, listen: false)
        .fetchCart(userId.toString(), 'Bearer $accessToken');
    setState(() {
      listCart = cartResponse;
    });
  }

  Future<void> _payAction(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Lanjut pembayaran?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BayarPage(
                      userID: widget.userID,
                      accessToken: widget.accessToken,
                    ),
                  ),
                );

                try {
                  final pembayaranProvider = Provider.of<Pembayaran>(context, listen: false);
                  await pembayaranProvider.setStatusHarapBayar(widget.userID.toString(), 'Bearer ${widget.accessToken}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment initiated successfully!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } catch (error) {
                      print(error);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to initiate payment: $error'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
            _fetchCart();
          },
        ),
        centerTitle: true,
        title: const Text(
          "Your Carts",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleting from cart...'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        await Provider.of<CartList>(context, listen: false).deleteFromCart(cartItem.id.toString(), 'Bearer ${widget.accessToken}');
                        _fetchCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item deleted from cart successfully!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } catch (error) {
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
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleting All from cart...'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      await Provider.of<CartList>(context, listen: false).purgeCart(widget.userID.toString(), 'Bearer ${widget.accessToken}');
                      _fetchCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('All Item deleted from cart successfully!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } catch (error) {
                      print('Error deleting all item from cart: $error');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to deleting all item from cart: $error'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: Text('Delete All'),
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                  onPressed: () => _payAction(context),
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
