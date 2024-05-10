import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthAPI with ChangeNotifier {
  Future<void> createUser(String username, String password) async {
    final requestBody =
        jsonEncode({'username': username, 'password': password});

    debugPrint('Request body: $requestBody');

    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/users/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> login(String username, String password) async {
    final requestBody =
        jsonEncode({'username': username, 'password': password});

    debugPrint('Request body: $requestBody');

    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
