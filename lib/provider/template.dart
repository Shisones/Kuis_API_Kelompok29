import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdukList with ChangeNotifier {
  String url = "http://127.0.0.1:8000/daftar_produk";
  List<dynamic> _produkList = [];
  List<dynamic> get produkList => _produkList;

  List<dynamic> setFromJson(Map<String, dynamic> json) {
    _produkList = (json['data'] as List);
    // .map((e) => Produk(
    //     id: e['id'],
    //     name: e['name'],
    //     category: e['category'],
    //     location: e['location'],
    //     price: e['price'],
    //     condition: e['condition'],
    //     publish_date: e['publish_date'],
    //     image: e['image']))
    // .toList();
    notifyListeners();

    return produkList;
  }

  Future<List> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
