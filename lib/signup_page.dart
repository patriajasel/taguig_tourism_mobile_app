import 'package:flutter/material.dart';
import 'util/constants/sizes.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                            prefixIcon: const Icon(Iconsax.user),
                            
                            // Label style size
                            labelStyle: const TextStyle(
                              fontSize: Sizes.fontSizeSm,
                            ),

                            // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                            //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(192, 244, 67, 54),
                              ),
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
                              borderSide: const BorderSide(
                                color: Color.fromARGB(192, 244, 67, 54),
                              ),
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
                      prefixIcon: const Icon(Iconsax.direct),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(192, 244, 67, 54),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Height bewteen Email and Age form
                  const SizedBox(
                    height: 16.0,
                    ),
                    
                  //* Placeholder ko muna yung TextFormField para sa Age
                  TextFormField(
                    expands: false,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      prefixIcon: const Icon(Iconsax.clock),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(192, 244, 67, 54),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  // Height bewteen Age and Gender form
                  const SizedBox(
                    height: 16.0,
                    ),
                    
                  //* Placeholder ko muna yung TextFormField para sa Gender
                  TextFormField(
                    expands: false,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: const Icon(Iconsax.man),

                      // Label style size
                      labelStyle: const TextStyle(
                        fontSize: Sizes.fontSizeSm,
                      ),

                      // Border Styles: In the future, sa iisang dart file nalang yung mga styles.
                      //* As of now, isa-isahin ko muna yung style properties kada form. HAHAHA
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(192, 244, 67, 54),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  // Height bewteen Gender form and Create an Account button
                  const SizedBox(
                    height: 16.0,
                    ),

                  // Create an account button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: const Text('Create an Account')
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
