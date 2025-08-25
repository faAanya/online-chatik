import 'package:flutter/material.dart';
import 'package:flutter_frontend/pages/home_page.dart';
import 'package:flutter_frontend/pages/login_or_register_page.dart';
import 'package:flutter_frontend/servives/auth_service.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool?>(
        stream: AuthService.onUserChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
