// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthAPI with ChangeNotifier {
  final String url = 'http://146.190.109.66:8000';

  Future<void> createUser(String username, String password) async {
    final requestBody =
        jsonEncode({'username': username, 'password': password});

    final response = await http.post(
      Uri.parse('$url/users/'),
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

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$url/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final user_id = jsonResponse['user_id'];
      final access_token = jsonResponse['access_token'];
      return {'user_id': user_id, 'access_token': access_token};
    } else {
      throw Exception('Login failed with status code ${response.statusCode}');
    }
  }

Future<Map<String, dynamic>> fetchUser(String user_id, String token) async {
  final response = await http.get(
    Uri.parse('$url/users/$user_id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final username = jsonResponse['username'];
    return {'username': username};
  } else {
    throw Exception('Login failed with status code ${response.statusCode}');
  }
}
}