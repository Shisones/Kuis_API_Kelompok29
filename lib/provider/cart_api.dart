// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kuis_api_kel29/provider/model/cart_model.dart';

class CartList with ChangeNotifier {
  final String url = 'http://146.190.109.66:8000';
  List<dynamic> cartList = [];
  List<dynamic> get itemList => cartList;

  List<dynamic> setFromJson(dynamic json) {
  if (json is List) {
    cartList = json
        .map((e) => Cart(
              user_id: e['user_id'],
              item_id: e['item_id'],
              quantity: e['quantity'],
              id: e['id'],
            ))
        .toList();
  } 
  else if (json is Map) {
    // If it's a single object, create a list with a single item
    cartList = [
      Cart(
        user_id: json['user_id'],
        item_id: json['item_id'],
        quantity: json['quantity'],
        id: json['id'],
      )
    ];
  } 
  else {
    throw Exception('Invalid JSON format');
  }
  notifyListeners();

  return cartList;
}


  Future<List> addToCart(int user_id, int item_id, int quantity, String token) async {
    print("yes1");
    final response = await http.post(Uri.parse('$url/carts/'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }, 
    body: jsonEncode({
      "item_id": item_id, 
      "user_id": user_id, 
      "quantity": quantity
    })
    // body: {
    //   {"item_id": item_id, "user_id": user_id, "quantity": quantity}
    // }
    );
    print("yes2");
    if (response.statusCode == 200) {
      print('Item added successfully');
      return setFromJson(jsonDecode(response.body));
    } else {
      print('Failed to add item: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List> fetchCart(String user_id, String token) async {
  // Future<List> fetchCart(int user_id, String token) async {
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

  Future<void> deleteFromCart(String cart_id, String token) async {
  // Future<List> deleteFromCart(int cart_id, String token) async {
    final response =
        await http.delete(Uri.parse('$url/carts/$cart_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      print("K $cart_id");
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> purgeCart(String user_id, String token) async {
    final response =
        await http.delete(Uri.parse('$url/clear_whole_carts_by_userid/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
