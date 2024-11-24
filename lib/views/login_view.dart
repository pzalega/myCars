import 'package:flutter/material.dart';
import 'package:my_cars/services/auth/auth_exceptions.dart';
import 'package:my_cars/services/auth/auth_service.dart';
import 'package:my_cars/utils/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => __LoginPagStateState();
}

class __LoginPagStateState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Login')),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: 'Enter your email here'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your password here'),
            ),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                    } else {}
                  } on WrongCredentialsAuthException {
                    await showErrorDialog(
                      context,
                      'Invalid credentials',
                    );
                  } on InvalidEmailAuthException {
                    await showErrorDialog(
                      context,
                      'Invalid email',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context,
                      'Authenticatoin error',
                    );
                  }
                },
                child: const Text('Login')),
            TextButton(
                onPressed: () {},
                child: const Text('Not regitered yet? Register here!'))
          ],
        ));
  }
}
