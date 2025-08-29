import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: "Lexend",
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue.shade400,
    brightness: Brightness.dark,
  ),
);
