import 'package:flutter/material.dart';

class BButtonTheme {
  BButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.red.shade100,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(
              fontFamily: "Arvo",
              color: Colors.white,
              fontWeight: FontWeight.w500),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
}
