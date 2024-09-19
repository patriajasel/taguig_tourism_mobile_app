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
      // appBar: AppBar(),
      // * PUT YOUR CODES HERE!!
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [

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
                            prefixIcon: const Icon(Iconsax.user_copy, size: Sizes.iconMd),
                            
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
                      prefixIcon: const Icon(Iconsax.direct_copy, size: Sizes.iconMd),

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
                      prefixIcon: const Icon(Iconsax.lock_1_copy, size: Sizes.iconMd),

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
                      prefixIcon: const Icon(Iconsax.lock_circle_copy, size: Sizes.iconMd),

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
                      prefixIcon: const Icon(Iconsax.clock_copy, size: Sizes.iconMd),

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
                      Iconsax.arrow_circle_down_copy,
                      size: Sizes.iconMd,
                      color: Color.fromARGB(255, 47, 0, 255),
                    ),
                    decoration: InputDecoration(
                      labelText: "Gender",
                      prefixIcon: const Icon(Iconsax.man_copy, size: Sizes.iconMd),

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

                  // Create an account button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: const Text('Create an Account')
                    ),
                  ),
                  
                  // Height between Create Account and Google Signin
                  const SizedBox(
                    height: Sizes.buttonHeight
                    ),

                  // Google Sign In button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: const Text('or Sign In via Google')
                    ),
                  ),
                  
                  // Height between Google Signin and Login button
                  const SizedBox(
                    height: Sizes.buttonHeight
                    ),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: const Text('Already have an account? Login here!')
                    ),
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
