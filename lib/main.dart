import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/page/loginpage.dart';
import 'package:kuis_api_kel29/auth/auth_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthAPI()),
        // Add other providers if needed
      ],
      child: MaterialApp(
        title: 'Kto to LoginPage pidar rahhhhh',
        home: LoginPage(),
      ),
    );
  }
}
