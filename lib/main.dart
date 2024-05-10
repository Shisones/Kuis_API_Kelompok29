import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/page/login_page.dart';
import 'package:kuis_api_kel29/page/home_page.dart';
import 'package:kuis_api_kel29/provider/auth_api.dart';
import 'package:kuis_api_kel29/provider/item_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthAPI()),
          ChangeNotifierProvider(create: (_) => ItemList()),
          // Add other providers if needed
        ],
        child: const MaterialApp(
          title: 'Kto to LoginPage pidar rahhhhh',
          // home: LoginPage(),
          home: HomePage(userID: 26, accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ik5hZ3JvIiwiZXhwIjoxNzE1NDIxMjcyfQ.1IjEKJsM8AgiJKv1NI1CH9UpSGwYu9ye5hbocfoP2CA",),
        ),
      ),
    );
  }
}
