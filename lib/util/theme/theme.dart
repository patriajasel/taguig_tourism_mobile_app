import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/util/theme/custom_themes/button_theme.dart';
import 'package:taguig_tourism_mobile_app/util/theme/custom_themes/text_theme.dart';

class TaguigAppTheme {
  TaguigAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Arvo',
      brightness: Brightness.light,
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.red,
        indicatorColor: Colors.red.shade300,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
              color: Colors.white, fontFamily: "Arvo", fontSize: 12.0),
        ),
        iconTheme: MaterialStateProperty.all(
          const IconThemeData(color: Colors.white),
        ),
      ),
      appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.red),
      elevatedButtonTheme: BButtonTheme.lightElevatedButtonTheme);

  static ThemeData darkTheme = ThemeData();
}
