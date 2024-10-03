// ignore: avoid_web_libraries_in_flutter
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/app_navigation.dart';
import 'package:taguig_tourism_mobile_app/firebase_options.dart';
import 'package:taguig_tourism_mobile_app/login_page.dart';
import 'package:taguig_tourism_mobile_app/signup_page.dart';
import 'package:taguig_tourism_mobile_app/util/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

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
        home: const AppNavigation());
  }
}
