import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 50),

              // Welcome to tourism app
              Text(
                'Welcome to Taguig On-The-Go App!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),

              // Username textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: usernameController,
                  expands: false,
                  decoration: InputDecoration( // Removed the 'const' here
                    labelText: 'Username or Email',
                    prefixIcon: const Icon(
                      Icons.person),

                    // Label style size
                    labelStyle: const TextStyle(
                      fontSize: 14.0, // Replace with your desired font size
                    ),
                  
                    // Border Styles
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // No need for 'const' here
                    ),
                  ),
                ),
              ),


            
              const SizedBox(height: 10),

              // Password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  expands: false,
                  decoration: InputDecoration( // Removed the 'const' here
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock),

                    // Label style size
                    labelStyle: const TextStyle(
                      fontSize: 14.0, // Replace with your desired font size
                    ),
                  
                    // Border Styles
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // No need for 'const' here
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

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
                  onPressed: () {
                    
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
              ),

              const SizedBox(height: 75),

              // Or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              // Google or Apple sign in buttons
              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      foregroundColor: Colors.black, // Text and icon color
                      elevation: 3, // Shadow elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // You can leave this empty or add functionality later.
                    }, 
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('lib/assets/logo/button_logo/google-icon.png', height: 30),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                            child: Text("Sign-In with Google"),
                          ),
                        ],
                      ), // Positioned properly
                    ),
                  ),
              ),

              const SizedBox(height: 60),
              
              // Not a member? Register now
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member? "),
                      InkWell(
                        child: const Text('Register Now', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          ),
                          ),
                        onTap: () {Navigator.pushNamed(context, '/signup_page');
                        }
          ),
                    ],
                  ),
                  
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
