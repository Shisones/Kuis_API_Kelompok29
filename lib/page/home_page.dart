// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuis_api_kel29/provider/auth_api.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';

class HomePage extends StatefulWidget {
  final int userID;
  final String accessToken;

  const HomePage({
    Key? key,
    required this.userID,
    required this.accessToken,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _searchQueryController = TextEditingController();
  String namaUser = '';
  List<dynamic> listItem = [];

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
                                title: Text(singleItem.title),
                                subtitle: Text(
                                    "Deskripsi: ${singleItem.description}"),
                                // onTap: () {
                                //   Navigator.of(context).push(
                                //       MaterialPageRoute(builder: (conteUserApixt) => DetailProdukPage(

                                // id: singleItem.id)));
                                // }
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
      ),
    );
  }
}
