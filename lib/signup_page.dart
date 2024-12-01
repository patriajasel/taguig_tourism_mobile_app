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
  final ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> obscureNotifier2 = ValueNotifier<bool>(true);
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
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: Column(
                  children: [
                    // Sign In title
                    SizedBox(height: screenHeight * 0.0658),
                    const Text(
                      'Sign Up Form',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.xl,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    SizedBox(height: screenHeight * 0.03947),

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
                            SizedBox(width: screenHeight * 0.02105),

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
                        SizedBox(height: screenHeight * 0.02105),

                        // Email form
                        GenerateWidget().generateTextField(
                            context, "E-mail", Icons.email_outlined, email),

                        // Height between Email and Password form
                        SizedBox(height: screenHeight * 0.02105),

                        // Password
                        GenerateWidget().generateTextField(
                            context, "Password", Icons.lock_outline, password,
                            isPassword: true, obscureTextNotifier: obscureNotifier),

                        // Height between Password and Confirm Password
                        SizedBox(height: screenHeight * 0.02105),

                        // Confirm Password
                        GenerateWidget().generateTextField(
                            context, "Confirm Password", Icons.lock, confirmPassword,
                            isPassword: true, obscureTextNotifier: obscureNotifier2),

                        // Height between Email and Age form
                        SizedBox(height: screenHeight * 0.02105),

                        //* Placeholder ko muna yung TextFormField para sa Age
                        GenerateWidget().generateTextField(
                            context, "Age", Icons.schedule_outlined, age),

                        // Height between Age and Gender form
                        SizedBox(height: screenHeight * 0.02105),

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
                            size: screenHeight * 0.03158,
                            color: Colors.yellowAccent,
                          ),

                          style: TextStyle(
                              color: Colors
                                  .white, // White text for the selected item
                              fontSize: screenHeight * 0.01945,
                              fontFamily: "Arvo"),
                          dropdownColor: Colors
                              .black, // Background color for the dropdown options
                          decoration: InputDecoration(
                            labelText: "Gender",
                            prefixIcon: Icon(
                              Icons.wc_outlined,
                              size: screenHeight * 0.03158,
                              color: Colors.yellowAccent,
                            ),
                            labelStyle: TextStyle(
                                fontSize: screenHeight * 0.01579,
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
                        SizedBox(height: screenHeight * 0.02369),

                        SizedBox(
                            width: screenWidth, // Set the width (adjust as needed)
                            child: GenerateWidget().generateElevatedButton(
                              context,
                              "Create an Account",
                              Colors.black,
                              Colors.white,
                              signingUp)),

                        // Height between Create Account and Google Sign in
                        SizedBox(height: screenHeight * 0.02369),

                        // or Sign-up with
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01316),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01316),
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

                        SizedBox(height: screenHeight * 0.02105),

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
                                    height: screenHeight * 0.0329),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.01316, vertical: screenHeight * 0.01974),
                                  child: Text(
                                    "Sign-In with Google",
                                    style: TextStyle(fontSize: screenHeight * 0.01842),
                                  ),
                                ),
                              ],
                            ), // Positioned properly
                          ),
                        ),

                        // Height between Google Sign in and Login button
                        SizedBox(height: screenHeight * 0.02369),

                        // Login button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.01842
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
