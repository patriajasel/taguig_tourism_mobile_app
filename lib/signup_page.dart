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
                    const SizedBox(height: 50),
                    const Text(
                      'Sign Up Form',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.xl,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),

                    // Form
                    Form(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            // First Name form
                            Expanded(
                                child: GenerateWidget().generateTextField(
                                    "First Name",
                                    Icons.person_outline,
                                    firstName)),

                            // Width between First and Last Name
                            const SizedBox(width: Sizes.spaceBtwInputFields),

                            // Last Name form
                            Expanded(
                                child: GenerateWidget().generateTextField(
                                    "Last Name",
                                    Icons.person_outline,
                                    lastName)),
                          ],
                        ),

                        // Height between First and Last Name to Email form
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        // Email form
                        GenerateWidget().generateTextField(
                            "E-mail", Icons.email_outlined, email),

                        // Height between Email and Password form
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        // Password
                        GenerateWidget().generateTextField(
                            "Password", Icons.lock_outline, password,
                            obscureText: true),

                        // Height between Password and Confirm Password
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        // Confirm Password
                        GenerateWidget().generateTextField(
                            "Confirm Password", Icons.lock, confirmPassword,
                            obscureText: true),

                        // Height between Email and Age form
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        //* Placeholder ko muna yung TextFormField para sa Age
                        GenerateWidget().generateTextField(
                            "Age", Icons.schedule_outlined, age),

                        // Height between Age and Gender form
                        const SizedBox(height: Sizes.spaceBtwInputFields),

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
                          icon: const Icon(
                            Icons.expand_circle_down_outlined,
                            size: Sizes.iconMd,
                            color: Colors.white,
                          ),

                          style: const TextStyle(
                              color: Colors
                                  .white, // White text for the selected item
                              fontSize: Sizes.fontSizeSm,
                              fontFamily: "Arvo"),
                          dropdownColor: Colors
                              .black, // Background color for the dropdown options
                          decoration: InputDecoration(
                            labelText: "Gender",
                            prefixIcon: const Icon(
                              Icons.wc_outlined,
                              size: Sizes.iconMd,
                              color: Colors.yellowAccent,
                            ),
                            labelStyle: const TextStyle(
                                fontSize: Sizes.fontSizeSm,
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
                        const SizedBox(height: Sizes.buttonHeight),

                        SizedBox(
                            width: 360, // Set the width (adjust as needed)
                            child: GenerateWidget().generateElevatedButton(
                                "Create an Account",
                                Colors.black,
                                Colors.white,
                                signingUp)),

                        // Height between Create Account and Google Sign in
                        const SizedBox(height: Sizes.buttonHeight),

                        // or Sign-up with
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
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

                        const SizedBox(height: Sizes.md),

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

                        // Height between Google Sign in and Login button
                        const SizedBox(height: Sizes.buttonHeight),

                        // Login button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: Colors.white),
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
