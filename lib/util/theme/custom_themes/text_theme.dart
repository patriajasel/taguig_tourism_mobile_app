import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineMedium: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),

    // *
    titleLarge: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w200, color: Colors.black),

    // *
    bodyMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),

    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme();
}
