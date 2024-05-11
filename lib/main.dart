import 'package:flutter/material.dart';
import 'package:kuis_api_kel29/provider/bayar_api.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/page/login_page.dart';
import 'package:kuis_api_kel29/page/home_page.dart';
import 'package:kuis_api_kel29/provider/auth_api.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';
import 'package:kuis_api_kel29/provider/cart_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthAPI()),
          ChangeNotifierProvider(create: (_) => ItemList()),
          ChangeNotifierProvider(create: (_) => CartList()),
          ChangeNotifierProvider(create: (_) => Pembayaran()),
          // Add other providers if needed
        ],
        child: MaterialApp(
          title: 'Jas Food',
          home: LoginPage(),
        ),
    );
  }
}
