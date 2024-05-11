import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pembayaran with ChangeNotifier 
{
  final String url = 'http://146.190.109.66:8000';

  Future<void> setStatusHarapBayar(String user_id, String token) async {
    final response =
        await http.post(Uri.parse('$url/set_status_harap_bayar/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> bayar(String user_id, String token) async {
    final response =
        await http.post(Uri.parse('$url/pembayaran/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> setStatusPenjualTerima(String user_id, String token) async {
    final response =
        await http.post(Uri.parse('$url/set_status_penjual_terima/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> setStatusDiantar(String user_id, String token) async {
    final response =
        await http.post(Uri.parse('$url/set_status_diantar/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> setStatusDiterima(String user_id, String token) async {
    final response =
        await http.post(Uri.parse('$url/set_status_diterima/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }



  Future<String> getStatus(String user_id, String token) async {
    final response =
        await http.get(Uri.parse('$url/get_status/$user_id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}