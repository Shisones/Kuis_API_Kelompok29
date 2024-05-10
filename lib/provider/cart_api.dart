// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kuis_api_kel29/provider/model/cart_model.dart';

class CartList with ChangeNotifier {
  final String url = 'http://146.190.109.66:8000';
  List<dynamic> cartList = [];
  List<dynamic> get itemList => cartList;

  List<dynamic> setFromJson(List<dynamic> json) {
    cartList = json
        .map((e) => Cart(
              user_id: e['user_id'],
              item_id: e['item_id'],
              quantity: e['quantity'],
            ))
        .toList();
    notifyListeners();

    return cartList;
  }

  Future<List> addToCart(
      int user_id, int item_id, int quantity, String token) async {
    final response = await http.post(Uri.parse('$url/carts/'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }, body: {
      {"item_id": item_id, "user_id": user_id, "quantity": quantity}
    });
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List> fetchCart(String user_id, String token) async {
    final response = await http.get(Uri.parse('$url/carts/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List> deleteFromCart(String cart_id, String token) async {
    final response =
        await http.delete(Uri.parse('$url/carts/$cart_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List> purgeCart(String user_id, String token) async {
    final response =
        await http.delete(Uri.parse('$url/clear_whole_carts_by_userid/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
