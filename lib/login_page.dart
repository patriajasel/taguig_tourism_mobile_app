import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/services/auth_services.dart';
import 'package:taguig_tourism_mobile_app/widgets/widget_generator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.shade700,
              Colors.redAccent.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight / 50),
                      Image.asset(
                        "lib/assets/logo/app_logo/GoTaguig_Logo.png",
                        fit: BoxFit.fill,
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: screenHeight / 50),

                      // Welcome to tourism app
                      const Text(
                        'Welcome to GoTaguig App!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight / 20),

                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 15),
                          child: GenerateWidget().generateTextField(
                              context,
                              'Username or Email',
                              Icons.person,
                              usernameController)),

                      SizedBox(height: screenHeight / 50),

                      // Password textfield
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 15),
                          child: GenerateWidget().generateTextField(context,
                              'Password', Icons.lock, passwordController,
                              obscureText: true)),
                      SizedBox(height: screenHeight / 50),

                      // Forgot password
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GenerateWidget().generateTextLink(
                              context,
                              "Forgot Password?",
                              '/signup_page',
                              Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight / 40),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 15),
                        child: GenerateWidget().generateElevatedButton(
                          context,
                          "Sign in",
                          Colors.black,
                          Colors.white,
                          loggingIn,
                        ),
                      ),

                      SizedBox(height: screenHeight / 25),

                      // Or continue with
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 15),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.yellowAccent,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth / 30),
                              child: const Text(
                                'or continue with',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.yellowAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Google or Apple sign in buttons
                      SizedBox(height: screenHeight / 25),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 15),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Background color
                              foregroundColor:
                                  Colors.black, // Text and icon color
                              elevation: 3, // Shadow elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // You can leave this empty or add functionality later.
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    'lib/assets/logo/button_logo/google-icon.png',
                                    height: 30),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: Text(
                                    "Sign-In with Google",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ), // Positioned properly
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight / 25),

                      // Not a member? Register now
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth / 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Not a member? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            GenerateWidget().generateTextLink(
                                context,
                                "Register Now",
                                '/signup_page',
                                Colors.yellowAccent)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loggingIn() async {
    await AuthenticationServices().signIn(
      email: usernameController.text,
      password: passwordController.text,
      context: context,
    );
  }
}
