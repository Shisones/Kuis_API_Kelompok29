import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/page/home_page.dart';
import 'package:kuis_api_kel29/auth/auth_api.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {  
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kto to LoginPage pidar rahhhhh',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final result =
                        await Provider.of<AuthAPI>(context, listen: false)
                            .login(
                      _usernameController.text,
                      _passwordController.text,
                    );
                    final userID = result['user_id'];
                    final accessToken = result['access_token'];

                    print(result);

                    // Navigasi ke halaman beranda setelah login berhasil
                    Navigator.of(context).push
                    (
                      MaterialPageRoute
                      (
                        builder: (context) => HomePage
                        (
                          userID: userID,
                          accessToken: accessToken,
                        ),
                      ),
                    );

                    // Use the userId and accessToken values here
                  } catch (e) {
                    // (e is Exception) ? print(e) : print('An error occurred');
                    print('Error during login: $e');
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await Provider.of<AuthAPI>(context, listen: false)
                        .createUser(
                      _usernameController.text,
                      _passwordController.text,
                    );
                  } catch (e) {
                    (e is Exception) ? print(e) : print('An error occurred');
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
