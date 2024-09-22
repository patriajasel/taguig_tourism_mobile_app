// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taguig_tourism_mobile_app/services/firestore_services.dart';

class AuthenticationServices {
  Future<void> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required int age,
      required String gender,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      FirestoreServices()
          .addUsers(firstName, lastName, email, age, gender, false);

      await FirebaseAuth.instance.signOut();

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist with the email provided';
      }
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

  Future<void> singIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, '/app_navigation_page');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid Password';
      }
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

  Future<void> signOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushNamedAndRemoveUntil(
        context, '/login_page', (Route<dynamic> route) => false);
  }
}
