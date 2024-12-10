import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/login_page.dart';
import 'package:taguig_tourism_mobile_app/util/constants/sizes.dart';
import 'package:taguig_tourism_mobile_app/widgets/widget_generator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenHeight * 0.01),
                child: Column(
                  children: [
                    
                    SizedBox(height: screenHeight * 0.0858),

                    Center(
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.xl,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    Center(
                      child: Text(
                        "Enter your registered GoTaguig E-mail",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.023,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenHeight * 0.03,
                        screenHeight * 0.07,
                        screenHeight * 0.03,
                        screenHeight * 0.01),
                      child: Form(
                        child: GenerateWidget().generateTextField(
                          context,
                          'E-mail',
                          Icons.email_outlined,
                          emailController
                          ),
                        ),
                    ),

                    SizedBox(height: screenHeight * 0.03),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                      child: SizedBox(
                        child: GenerateWidget().generateElevatedButton(
                          context, 'Send Email',
                          const Color.fromARGB(255, 25, 0, 255), 
                          Colors.white, 
                          sendEmail
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Not a member? Register now
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenHeight / 15),
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
    );
  }

  void sendEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Password Reset hase been sent. Check your email and click the link to change your password.",
          style: TextStyle(
            fontSize: 12
            )
          ),
          backgroundColor: Colors.green,
        )
      );
    } on FirebaseAuthException catch(e) {
      if(e.code=="user-not-found" || e.code=="USER-NOT-FOUND" || e.code=="unverified-email"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "The e-mail you have input did not match on any registered account.",
          style: TextStyle(
            fontSize: 12
            )
          ),
          backgroundColor: Colors.red,
        )
      );
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}