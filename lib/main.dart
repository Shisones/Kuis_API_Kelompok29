import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/auth/loginpage.dart';
import 'package:kuis_api_kel29/provider/template.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProdukList()),
        // ChangeNotifierProvider(create: (_) => ProdukDetail()),
      ],
      child: const LoginPage(),
    ),
  );
}
