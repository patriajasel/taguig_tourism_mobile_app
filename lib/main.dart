import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/app_navigation.dart';
import 'package:taguig_tourism_mobile_app/login_page.dart';
import 'package:taguig_tourism_mobile_app/signup_page.dart';
import 'package:taguig_tourism_mobile_app/user_page.dart';
import 'package:taguig_tourism_mobile_app/util/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: TaguigAppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          '/login_page': (context) => const LoginPage(),
          '/signup_page': (context) => const SignUpPage(),
          '/app_navigation_page': (context) => const AppNavigation(),
        },
        home: const SignUpPage());
  }
}
