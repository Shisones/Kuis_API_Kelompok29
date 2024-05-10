import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:kuis_api_kel29/auth/auth_api.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

                    // Use the userId and accessToken values here
                  } catch (e) {
                    (e is Exception) ? print(e) : print('An error occurred');
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
