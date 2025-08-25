import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/my_text_filed.dart';
import 'package:flutter_frontend/components/sign_in_button.dart';
import 'package:flutter_frontend/components/square_tile.dart';
import 'package:flutter_frontend/servives/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});

  final void Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void signInUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    await AuthService.signIn();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Icon(Icons.lock, size: 100),
                SizedBox(height: 50),
                Text(
                  "Welcome back",
                  style: TextStyle(color: Colors.grey[700], fontSize: 24),
                ),

                SizedBox(height: 25),

                MyTextField(
                  controller: loginController,
                  hintText: "Login",
                  obscure: false,
                ),

                SizedBox(height: 25),

                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscure: true,
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SignInButton(text: "Sign In", onTap: signInUser),
                    ),
                  ],
                ),

                SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),

                SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: "lib/images/google_logo.png",
                      onTap: () {
                        AuthService.signIn();
                      },
                    ),
                    SizedBox(width: 25),
                    SquareTile(
                      imagePath: "lib/images/apple_logo.png",
                      onTap: () {},
                    ),
                  ],
                ),

                SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Not a Member? "),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
