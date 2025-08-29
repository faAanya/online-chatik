import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscure,
    required this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline, // Use theme color
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant, // Use theme color
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.primary, // Use theme primary color
            ),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.outline,
          ), // Theme-based hint style
        ),
        style: Theme.of(context).textTheme.bodyMedium, // Theme-based text style
      ),
    );
  }
}
