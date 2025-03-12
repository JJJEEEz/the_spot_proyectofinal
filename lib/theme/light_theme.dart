import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
  ),
  colorScheme: ColorScheme.light(
      surface: Colors.grey[300]!,
      primary: Colors.grey[200]!,
      onPrimary: Colors.black,
      secondary: Colors.grey[300]!,
      primaryContainer: Colors.grey[400]),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.black)),
);
