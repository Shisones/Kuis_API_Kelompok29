import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/page/loginpage.dart';
import 'package:kuis_api_kel29/auth/auth_api.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthAPI()),
        // ChangeNotifierProvider(create: (_) => ProdukDetail()),
      ],
      child: LoginPage(),
    ),
  );
}
