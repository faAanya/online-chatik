import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/my_text_filed.dart';
import 'package:flutter_frontend/lang/strings.dart';
import 'package:flutter_frontend/servives/auth_service.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
  final _loginFormKey = GlobalKey<FormState>();
  final _registrationFormKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController registrationLoginController =
      TextEditingController();
  final TextEditingController registrationPasswordController =
      TextEditingController();
  final TextEditingController registrationConfirmedPasswordController =
      TextEditingController();

  void togglePages() {
    showLoginPage = !showLoginPage;
    setState(() {});
  }

  void signInUser() async {
    if (_loginFormKey.currentState?.validate() == false) return;
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    await AuthService.signIn();

    Navigator.pop(context);
  }

  void signUpUser() async {
    if (_registrationFormKey.currentState?.validate() == false) return;
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    await AuthService.signIn();

    Navigator.pop(context);
  }

  // TODO: Fix Validation
  String? _phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Remove all non-digit characters except potential leading '+'
    String digitsOnly = value.replaceAll(RegExp(r'[^\d+]'), '');

    if (!RegExp(r'/^\+?[1-9][0-9]{7,14}$/').hasMatch(value)) {
      return "Invalid phonenumber format";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Image.asset('lib/assets/images/logo.png', height: 170),
                SizedBox(height: 50),
                Text(
                  showLoginPage ? appName : "Create An Account",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
                ),

                SizedBox(height: 40),
                showLoginPage ? _loginForm() : _registrationForm(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: showLoginPage ? signInUser : signUpUser,
                          child: Text(showLoginPage ? "Sign In" : "Sign Up"),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      showLoginPage ? "Not a Member? " : "Already a Member? ",
                    ),
                    GestureDetector(
                      onTap: togglePages,
                      child: Text(
                        showLoginPage ? "Register Now" : "Sign In Now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _loginFormKey,
      child: SizedBox(
        height: 360,
        child: Column(
          children: [
            MyTextField(
              controller: loginController,
              hintText: "Phonenumber",
              obscure: false,
              validator: _phoneNumberValidator,
            ),

            SizedBox(height: 25),
            MyTextField(
              controller: loginController,
              hintText: "Password",
              obscure: true,
              validator: _passwordValidator,
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _registrationForm() {
    return Form(
      key: _registrationFormKey,
      child: SizedBox(
        height: 360,
        child: Column(
          children: [
            MyTextField(
              controller: registrationLoginController,
              hintText: "Name",
              obscure: false,
              validator: (_) => null,
            ),

            SizedBox(height: 25),
            MyTextField(
              controller: registrationLoginController,
              hintText: "Phonenumber",
              obscure: false,
              validator: _phoneNumberValidator,
            ),

            SizedBox(height: 25),

            MyTextField(
              controller: registrationPasswordController,
              hintText: "Password",
              obscure: true,
              validator: _passwordValidator,
            ),

            SizedBox(height: 25),

            MyTextField(
              controller: registrationConfirmedPasswordController,
              hintText: "Confirm Password",
              obscure: true,
              validator: _passwordValidator,
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
