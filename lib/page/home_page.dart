import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuis_api_kel29/provider/auth_api.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';
import 'package:kuis_api_kel29/page/cart_page.dart';

class HomePage extends StatefulWidget {
  final int userID;
  final String accessToken;

  const HomePage({
    super.key,
    required this.userID,
    required this.accessToken,
  });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _searchQueryController = TextEditingController();
  String namaUser = '';
  List<dynamic> listItem = [];
  List<Map<String, dynamic>> wholeCarts = [];

  @override
  void initState() {
    super.initState();
    _fetchUsername();
    _fetchItems();
  }

  Future<void> _fetchUsername() async {
    final userId = widget.userID;
    final accessToken = widget.accessToken;
    final usernameResponse = await Provider.of<AuthAPI>(context, listen: false)
        .fetchUser(userId.toString(), 'Bearer $accessToken');
    setState(() {
      namaUser = usernameResponse['username'];
    });
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

  void createCart(String itemId) {
    Map<String, dynamic> newCart = {
      'user_id': widget.userID, // UserID
      'item_id': itemId, // ItemID
      'quantity': 1, // Quantity
    };

    // Tambahkan keranjang baru ke wholeCarts
    setState(() {
      wholeCarts.add(newCart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 36, 36, 36),
          elevation: 0,
          title: Text(
            "Selamat datang $namaUser",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchQueryController,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: "Cari di yudart food",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 36, 36, 36),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ItemList>(
                    builder: (context, item, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: item.itemList.length,
                            itemBuilder: (context, index) {
                              final singleItem = item.itemList[index];
                              return ListTile(
                                leading: FutureBuilder<dynamic>(
                                  future: item.fetchImage(
                                      'Bearer ${widget.accessToken}',
                                      singleItem.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Icon(Icons.error);
                                    } else if (snapshot.hasData) {
                                      return Image.memory(
                                        snapshot.data!.bodyBytes,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      // Show a placeholder if no data is available
                                      return const Placeholder();
                                    }
                                  },
                                ),
                                title: Text(singleItem.title),
                                subtitle: Text(
                                    "Deskripsi: ${singleItem.description}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.green),
                                  onPressed: () {
                                    // Tambahkan keranjang baru saat tombol "+" ditekan
                                    createCart(singleItem.id);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigasi ke halaman keranjang dengan membawa data keranjang
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    CartPage(userId: widget.userID, wholeCarts: wholeCarts),
              ),
            );
          },
          child: Badge(
              label: Text('${wholeCarts.length}'),
              child: const Icon(Icons.shopping_cart)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
