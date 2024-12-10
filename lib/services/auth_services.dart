// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taguig_tourism_mobile_app/app_navigation.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';

class AuthenticationServices {
  //  Method for signing up users for the first time.
  Future<void> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required int age,
      required String gender,
      required String touristType,
      required BuildContext context}) async {
    try {
      // Creating user authentication with email and password
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //  Storing user ID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      //  Adding user information to Firestore Database
      FirestoreServices()
          .addUsers(uid, firstName, lastName, email, age, gender, touristType);

      //  Sending Verification email to user after the account creation
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      //  Showing a loading screen for aesthetics
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      await Future.delayed(const Duration(seconds: 1));

      //  Signing out user after creating an account because firebase authentication will sign in the user automatically after the account was created
      //  This is important to make sure that the user is verified first before the user gets access to the app.
      await FirebaseAuth.instance.signOut();

      //  Redirecting the user to the login page after creating an account.
      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (Route<dynamic> route) => false);

      //  For Error Handling
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        //  If created password is weak this message will appear
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        //  If the email user is already registered
        message = 'An account already exist with the email provided';
      }

      //  Widget for displaying the message based on the error
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      print(e);
    }
  }

  //  For logging the user in the app
  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      //  Signing the user in with email and password
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //  Storing user ID
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String userEmail = FirebaseAuth.instance.currentUser!.email!;

      //  Variable for storing if the user's email is verified or not.
      bool isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

      //  If user's email is verified, the user will be redirected to the home page
      //  Showing a loading screen for aesthetics
      if (isVerified) {
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent.shade700,
                ),
              );
            });
        await Future.delayed(const Duration(seconds: 1));

        //  Redirecting to home page
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AppNavigation(
                  userID: uid,
                  email: userEmail,
                )));
      } else {
        //  If user's email is not verified, a popup will appear to remind the user to check their email.

        //  Showing the popup window
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Reminder"),
                  icon: Icon(
                    Icons.report,
                    size: 50,
                  ),
                  iconColor: Colors.yellowAccent.shade700,
                  content: Text(
                    "Please check your email to verify your account before logging in.",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () async {
                          //  Signing out the user because Firebase authentication will sign in the user already
                          await FirebaseAuth.instance.signOut();

                          //  Removing the popup window
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Okay",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
      }
      //  Error handling
    } on FirebaseAuthException catch (e) {
      String message = '';
      print(e.code);
      if (e.code == 'invalid-credential') {
        //  If user's credential does not match the database this message will appear

        message = 'Invalid Email or Password';
      }

      //  Showing the message
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      print(e);
    }
  }

  //  For signing out the user
  Future<void> signOut({required BuildContext context}) async {
    //  Signing out the user
    await FirebaseAuth.instance.signOut();

    //  Loading screen for aesthetics
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent.shade700,
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 1));

    //  Removing all widgets until the log in page.
    Navigator.pushNamedAndRemoveUntil(
        context, '/login_page', (Route<dynamic> route) => false);
  }

  // For Google sign in
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);
    print('idToken: ${googleSignInAuthentication?.idToken}');
    print('accessToken: ${googleSignInAuthentication?.accessToken}');

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    await FirestoreServices()
        .addUsers(
            userDetails!.uid, "", "", userDetails.email.toString(), 0, '', "")
        .then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppNavigation(
                            userID: userDetails.uid,
                            email: userDetails.email.toString(),
                          )))
            });
  }
}
