import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.grey[900]!,
      onPrimary: Colors.grey[800]!,
      secondary: Colors.grey[800]!,
      primaryContainer: Colors.grey[800]),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.white)),
);
