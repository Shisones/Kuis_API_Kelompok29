

// class HomePageState extends State<HomePage> {
//   final _searchQueryController = TextEditingController();
//   String namaUser = '';
//   List<dynamic> listItem = [];
//   List<Map<String, dynamic>> wholeCarts = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchUsername();
//     _fetchItems();
//   }

//   Future<void> _fetchUsername() async {
//     final userId = widget.userID;
//     final accessToken = widget.accessToken;
//     final usernameResponse =
//         await Provider.of<AuthAPI>(context, listen: false).fetchUser(userId.toString(), 'Bearer $accessToken');
//     setState(() {
//       namaUser = usernameResponse['username'];
//     });
//   }

//   Future<void> _fetchItems() async {
//     final userId = widget.userID;
//     final accessToken = widget.accessToken;
//     final itemResponse =
//         await Provider.of<ItemList>(context, listen: false).fetchData('Bearer $accessToken');
//     setState(() {
//       listItem = itemResponse;
//     });
//   }

//   void addToCart(String itemId) {
//     // Cek apakah item sudah ada di dalam keranjang
//     bool itemExists = false;
//     int existingIndex = -1;

//     for (int i = 0; i < wholeCarts.length; i++) {
//       if (wholeCarts[i]['item_id'] == itemId) {
//         itemExists = true;
//         existingIndex = i;
//         break;
//       }
//     }

//     if (itemExists) {
//       // Jika item sudah ada, tambahkan jumlahnya
//       setState(() {
//         wholeCarts[existingIndex]['quantity'] += 1;
//       });
//     } else {
//       // Jika item belum ada, tambahkan ke keranjang baru
//       setState(() {
//         wholeCarts.add({'item_id': itemId, 'quantity': 1});
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 36, 36, 36),
//           elevation: 0,
//           title: Text(
//             "Selamat datang $namaUser",
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 controller: _searchQueryController,
//                 cursorColor: Colors.white,
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//                 decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.search, color: Colors.white),
//                   hintText: "Cari di yudart food",
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white,
//                     ),
//                   ),
//                   filled: true,
//                   fillColor: Color.fromARGB(255, 36, 36, 36),
//                   contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Consumer<ItemList>(
//                     builder: (context, item, child) {
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: item.itemList.length,
//                             itemBuilder: (context, index) {
//                               final singleItem = item.itemList[index];
//                               return ListTile(
//                                 title: Text(singleItem.title),
//                                 subtitle: Text("Deskripsi: ${singleItem.description}"),
//                                 trailing: IconButton(
//                                   icon: Icon(Icons.add, color: Colors.green),
//                                   onPressed: () {
//                                     addToCart(singleItem.id);
//                                   },
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Navigasi ke halaman keranjang dengan membawa data keranjang
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => CartPage
//                 (
//                   userId: widget.userID,
//                   wholeCarts: wholeCarts
//                 ),
//               ),
//             );
//           },
//           child: Badge(label: Text('${wholeCarts.length}'), child: Icon(Icons.shopping_cart)),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       ),
//     );
//   }
// }
