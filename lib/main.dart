import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/login_page.dart';
import 'package:taguig_tourism_mobile_app/signup_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Material App',
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/signup_page': (context) => const SignUpPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Taguig Tourism App'),
        ),
        body: const SignUpPage(
        ),
      ),
    );
  }
}
