import 'package:flutter/material.dart';
import 'util/constants/sizes.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(),
      // * PUT YOUR CODES HERE!!
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [

              // Sign In title
              const SizedBox(height: Sizes.xl),
              const Text(
                'Sign-Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.fontSizeLg,
                ),
              ),
              const SizedBox(height: Sizes.xl),

              // Form
              Form(child: Column(
                children: [
                  Row(
                    children: [

                      // First Name form
                      Expanded(
                        child: TextFormField(
                          expands: false,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            prefixIcon: const Icon(Icons.person_outlined, size: Sizes.iconMd),
                            
                            // Label style size
                            labelStyle: const TextStyle(
                              fontSize: Sizes.fontSizeSm,
                            ),

                            // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                            //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      // Width between First and Last Name
                      const SizedBox(
                        width: Sizes.spaceBtwInputFields
                      ),
                      
                      // Last Name form
                      Expanded(
                        child: TextFormField(
                          expands: false,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            
                            // Label style size
                            labelStyle: const TextStyle(
                              fontSize: Sizes.fontSizeSm,
                            ),

                            // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                            //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Height bewteen First and Last Name to Email form
                  const SizedBox(
                    height: Sizes.spaceBtwInputFields
                  ),
                    
                  // Email form
                  TextFormField(
                    expands: false,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: const Icon(Icons.email_outlined, size: Sizes.iconMd),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Height bewteen Email and Password form
                  const SizedBox(
                    height: Sizes.spaceBtwInputFields
                    ),

                  // Password
                  TextFormField(
                    expands: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, size: Sizes.iconMd),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Height between Password and Confirm Passw
                  const SizedBox(
                    height: Sizes.spaceBtwInputFields
                  ),

                  // Confirm Password
                  TextFormField(
                    expands: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_rounded, size: Sizes.iconMd),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Height bewteen Email and Age form
                  const SizedBox(
                    height: Sizes.spaceBtwInputFields
                    ),
                    
                  //* Placeholder ko muna yung TextFormField para sa Age
                  TextFormField(
                    expands: false,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      prefixIcon: const Icon(Icons.schedule_outlined, size: Sizes.iconMd),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  // Height bewteen Age and Gender form
                  const SizedBox(
                    height: Sizes.spaceBtwInputFields
                  ),
                    
                  // Gender List (Changed: Text Form to Dropdown List)
                  DropdownButtonFormField(
                    value: genderSelectedVal,
                    items: genderList.map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (val){
                        setState(() {
                          genderSelectedVal = val as String;
                        });
                      },
                    icon: const Icon(
                      Icons.expand_circle_down_outlined,
                      size: Sizes.iconMd,
                    ),
                    decoration: InputDecoration(
                      labelText: "Gender",
                      prefixIcon: const Icon(Icons.wc_outlined, size: Sizes.iconMd),

                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  // Height bewteen Gender form and Create an Account button
                  const SizedBox(
                    height: Sizes.buttonHeight
                    ),

                  SizedBox(
                    width: 360, // Set the width (adjust as needed)
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Black background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15), // Adjust padding for height
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Create an Account",
                        style: TextStyle(color: Colors.white), // White text
                      ),
                    ),
                  ),
                  
                  // Height between Create Account and Google Signin 
                  const SizedBox(
                    height: Sizes.buttonHeight
                    ),

                  // or Sign-up with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'or Sign-up with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: Sizes.md
                    ),
                  
                  // Google Sign In button (Modified as same as Login UI)
                  
                  // ElevatedButton(
                  //   onPressed: (){}, 
                  //   child: Image.asset('lib/assets/logo/button_logo/google-icon.png',
                  //     height: Sizes.iconLg,
                  //   ),
                  SizedBox(
                    width: 65, // Set the width (adjust as needed)
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Black background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15
                        ), // Adjust padding for height
                      ),
                      onPressed: () {},
                      child: Image.asset('lib/assets/logo/button_logo/google-icon.png',
                      height: Sizes.iconLg, // White text
                      ),
                    ),
                  ),
                  
                  // Height between Google Signin and Login button
                  const SizedBox(
                    height: Sizes.buttonHeight
                    ),

                  // Login button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      InkWell(
                        child: const Text('Login Here'),
                        onTap: () {
                          Navigator.pushNamed(
                            context, '/login_page'
                          );
                        }
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
