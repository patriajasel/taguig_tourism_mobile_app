import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async'; // Import for delay

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _confirmNewEmailController =
      TextEditingController();
  final TextEditingController _currentEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // The function that updates the email in Firebase
  void _saveEmail() async {
    FocusScope.of(context).unfocus(); // Dismiss the keyboard

    if (_currentEmailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _newEmailController.text.isEmpty ||
        _confirmNewEmailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (_newEmailController.text != _confirmNewEmailController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Emails do not match')),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reauthenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: _currentEmailController.text,
          password: _passwordController.text,
        );
        await user.reauthenticateWithCredential(credential);

        // Update email with verification
        await user.verifyBeforeUpdateEmail(_newEmailController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please check your verification email')),
        );

        // Add a 5-second delay before signing out and navigating
        await Future.delayed(Duration(seconds: 5));

        // Sign out and navigate to login page
        await FirebaseAuth.instance.signOut();
        Navigator.pushNamedAndRemoveUntil(
            context, '/login_page', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user is signed in')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else if (e.code == 'requires-recent-login') {
        errorMessage = 'Please log in again to proceed.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The new email address is already in use.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating email: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Email",
          style: TextStyle(color: Colors.white), // Title color set to white
        ),
        backgroundColor:
            Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
        flexibleSpace: Container(
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
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Back button color set to white
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Current email input field
              TextField(
                controller: _currentEmailController,
                decoration: InputDecoration(
                  labelText: "Current Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              // Password input field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide password text
              ),
              SizedBox(height: 20),

              // New email field
              TextField(
                controller: _newEmailController,
                decoration: InputDecoration(
                  labelText: "New Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              // Confirm new email field
              TextField(
                controller: _confirmNewEmailController,
                decoration: InputDecoration(
                  labelText: "Confirm New Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              // Save button
              Center(
                child: ElevatedButton(
                  onPressed: _saveEmail, // Call _saveEmail when pressed
                  child: Text("Save Email"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
