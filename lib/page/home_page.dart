import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int userID;
  final String accessToken;

  const HomePage({
    Key? key,
    required this.userID,
    required this.accessToken,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> listMakanan = [
    {
      "id": 1,
      "nama": "Nasi Goreng",
      "deskripsi":
          "Nasi goreng adalah makanan yang terbuat dari nasi yang digoreng dalam minyak goreng, biasanya ditambahkan kecap manis, bawang merah, bawang putih, telur, dan bahan lainnya.",
      "image": "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg"
    },
    {
      "id": 2,
      "nama": "Mie Goreng",
      "deskripsi":
          "Mie goreng adalah makanan yang terbuat dari mie yang digoreng dalam minyak goreng, biasanya ditambahkan kecap manis, sayuran, telur, dan bahan lainnya.",
      "image": "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg"
    },
    {
      "id": 3,
      "nama": "Ayam Bakar",
      "deskripsi":
          "Ayam bakar adalah makanan yang terbuat dari ayam yang dibakar atau dipanggang, biasanya dibumbui dengan rempah-rempah dan saus khusus.",
      "image": "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg"
    },
  ];

  String namaUser = "Jason";

  String _searchQuery = '';

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
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: listMakanan.length,
                  itemBuilder: (BuildContext context, int index) {
                    final makanan = listMakanan[index];
                    if (_searchQuery.isNotEmpty &&
                        !makanan['nama'].toLowerCase().contains(_searchQuery.toLowerCase())) {
                      return SizedBox.shrink();
                    }
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          makanan['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(makanan['nama']),
                        subtitle: Text(makanan['deskripsi']),
                        onTap: () {
                          // Tambahkan tindakan yang sesuai ketika item dipilih
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
