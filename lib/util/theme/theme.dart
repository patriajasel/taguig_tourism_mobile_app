import 'package:flutter/material.dart';

class TaguigAppTheme {
  TaguigAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Arvo',
    brightness: Brightness.light,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData();
}
