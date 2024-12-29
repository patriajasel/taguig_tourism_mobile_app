// ignore: avoid_web_libraries_in_flutter
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:taguig_tourism_mobile_app/firebase_options.dart';
import 'package:taguig_tourism_mobile_app/forgot_password.dart';
import 'package:taguig_tourism_mobile_app/login_page.dart';
import 'package:taguig_tourism_mobile_app/signup_page.dart';
import 'package:taguig_tourism_mobile_app/util/theme/theme.dart';
import 'package:taguig_tourism_mobile_app/models/profile_image_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()), // Add provider
      ],
      child: const MyApp(),
    ),
  );
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
        '/forgot_password': (context) => const ForgotPassword(),
      },
      home: const LoginPage(),
    );
  }
}
