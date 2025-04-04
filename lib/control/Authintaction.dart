import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register User
  Future<void> SignUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? profileImage,
    required BuildContext context,
  }) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserData(
        uid: credential.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
      );

      // Navigate to Login
      Navigator.of(context).pushReplacementNamed("Login");
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e, context);
    }
  }

  // Save User Data in Firestore
  Future<void> _saveUserData({
    required String uid,
    required String email,
    required String firstName,
    required String lastName,
    String? profileImage,
  }) async {
    await _firestore.collection("users").doc(uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "profileImage": profileImage ?? "",
    });
  }

  // Handle Authentication Errors
  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage = "";
    if (e.code == 'weak-password') {
      errorMessage = "Weak password";
    } else if (e.code == 'email-already-in-use') {
      errorMessage = "The account already exists for that email";
    } else {
      errorMessage = "An unexpected error occurred";
    }

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: "Error",
      desc: errorMessage,
      animType: AnimType.rightSlide,
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ).show();
  }
}
