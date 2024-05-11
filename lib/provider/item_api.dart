// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kuis_api_kel29/provider/model/item_model.dart';

class ItemList with ChangeNotifier {
  final String url = 'http://146.190.109.66:8000'; 
  List<dynamic> _itemList = [];
  List<dynamic> get itemList => _itemList;

  List<dynamic> setFromJson(List<dynamic> json) {
    _itemList = json
        .map((e) => Item(
              id: e['id'].toString(),
              title: e['title'],
              description: e['description'],
              price: e['price'],
              img_name: e['img_name'],
            ))
        .toList();
    notifyListeners();

    return _itemList;
  }

  Future<List> fetchData(String token) async {
    final response = await http.get(
      Uri.parse('$url/items/?skip=0&limit=100'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<http.Response> fetchImage(String token, String item_id) async {
    final response = await http.get(
      Uri.parse('$url/items_image/$item_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
