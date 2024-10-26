import 'package:flutter/material.dart';
import 'package:taguig_tourism_mobile_app/services/auth_services.dart';
import 'package:taguig_tourism_mobile_app/widgets/widget_generator.dart';
import 'util/constants/sizes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Part ito nang gender list
  _SignUpPageState() {
    genderSelectedVal = genderList[0];
  }

  // Gender List Variable
  final genderList = ["Male", "Female", "Rather not to say"];
  String? genderSelectedVal = "";

  // * TextEditingController Lists
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void getBuildContext() {}
    double screenWidth = MediaQuery.of(context).size.width;

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
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: Column(
                  children: [
                    // Sign In title
                    SizedBox(height: screenWidth * 0.13889),
                    const Text(
                      'Sign Up Form',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.xl,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    SizedBox(height: screenWidth * 0.08334),

                    // Form
                    Form(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            // First Name form
                            Expanded(
                                child: GenerateWidget().generateTextField(
                                  context,
                                  "First Name",
                                  Icons.person_outline,
                                  firstName)),

                            // Width between First and Last Name
                            SizedBox(width: screenWidth * 0.04445),

                            // Last Name form
                            Expanded(
                                child: GenerateWidget().generateTextField(
                                  context,
                                  "Last Name",
                                  Icons.person_outline,
                                  lastName)),
                          ],
                        ),

                        // Height between First and Last Name to Email form
                        SizedBox(height: screenWidth * 0.04445),

                        // Email form
                        GenerateWidget().generateTextField(
                            context, "E-mail", Icons.email_outlined, email),

                        // Height between Email and Password form
                        SizedBox(height: screenWidth * 0.04445),

                        // Password
                        GenerateWidget().generateTextField(
                            context, "Password", Icons.lock_outline, password,
                            obscureText: true),

                        // Height between Password and Confirm Password
                        SizedBox(height: screenWidth * 0.04445),

                        // Confirm Password
                        GenerateWidget().generateTextField(
                            context, "Confirm Password", Icons.lock, confirmPassword,
                            obscureText: true),

                        // Height between Email and Age form
                        SizedBox(height: screenWidth * 0.04445),

                        //* Placeholder ko muna yung TextFormField para sa Age
                        GenerateWidget().generateTextField(
                            context, "Age", Icons.schedule_outlined, age),

                        // Height between Age and Gender form
                        SizedBox(height: screenWidth * 0.04445),

                        // Gender List (Changed: Text Form to Dropdown List)
                        DropdownButtonFormField(
                          value: genderSelectedVal,
                          items: genderList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              genderSelectedVal = val as String;
                            });
                          },
                          icon: Icon(
                            Icons.expand_circle_down_outlined,
                            size: screenWidth * 0.06667,
                            color: Colors.yellowAccent,
                          ),

                          style: TextStyle(
                              color: Colors
                                  .white, // White text for the selected item
                              fontSize: screenWidth * 0.03889,
                              fontFamily: "Arvo"),
                          dropdownColor: Colors
                              .black, // Background color for the dropdown options
                          decoration: InputDecoration(
                            labelText: "Gender",
                            prefixIcon: Icon(
                              Icons.wc_outlined,
                              size: screenWidth * 0.06667,
                              color: Colors.yellowAccent,
                            ),
                            labelStyle: TextStyle(
                                fontSize: screenWidth * 0.03334,
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors
                                      .white), // White border for enabled state
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors
                                      .white), // White border for focused state
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white), // Default border color
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        // Height between Gender form and Create an Account button
                        SizedBox(height: screenWidth * 0.05),

                        SizedBox(
                            width: screenWidth, // Set the width (adjust as needed)
                            child: GenerateWidget().generateElevatedButton(
                              context,
                              "Create an Account",
                              Colors.black,
                              Colors.white,
                              signingUp)),

                        // Height between Create Account and Google Sign in
                        SizedBox(height: screenWidth * 0.05),

                        // or Sign-up with
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02778),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02778),
                                child: Text(
                                  'or Sign-up with',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenWidth * 0.04445),

                        // Google Sign In button (Modified as same as Login UI)

                        // ElevatedButton(
                        //   onPressed: (){},
                        //   child: Image.asset('lib/assets/logo/button_logo/google-icon.png',
                        //     height: Sizes.iconLg,
                        //   ),
                        Center(
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
                                    height: screenWidth * 0.06945),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.02778, vertical: screenWidth * 0.04167),
                                  child: Text(
                                    "Sign-In with Google",
                                    style: TextStyle(fontSize: screenWidth * 0.03889),
                                  ),
                                ),
                              ],
                            ), // Positioned properly
                          ),
                        ),

                        // Height between Google Sign in and Login button
                        SizedBox(height: screenWidth * 0.05),

                        // Login button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.03889
                              ),
                            ),
                            GenerateWidget().generateTextLink(
                                context,
                                "Login here",
                                '/login_page',
                                Colors.yellowAccent)
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signingUp() async {
    await AuthenticationServices().signUp(
      email: email.text,
      password: password.text,
      firstName: firstName.text,
      lastName: lastName.text,
      age: int.parse(age.text),
      gender: genderSelectedVal!,
      context: context,
    );
  }
}
