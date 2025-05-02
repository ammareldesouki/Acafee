import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with Email & Password
  Future<void> SignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _navigateToHome(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e, context);
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return; // User canceled sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Check if user is new and save to Firestore
        final doc = await _firestore.collection("users").doc(user.uid).get();
        if (!doc.exists) {
          await _saveUserData(
            uid: user.uid,
            email: user.email ?? "",
            firstName: user.displayName?.split(" ").first ?? "User",
            lastName: user.displayName?.split(" ").last ?? "",
            profileImage: user.photoURL,
          );
        }

        _navigateToHome(context);
      }
    } catch (e) {
      _showErrorDialog(context, "Google Sign-In Failed", e.toString());
    }
  }

  // Sign up (Register)
  Future<void> signUp({
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

      _navigateToHome(context);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e, context);
    }
  }

  // Navigate to Home or AdminPanel
  void _navigateToHome(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user != null) {
      if (user.email == "ammareldesouki82@gmail.com") {
        Navigator.of(context).pushReplacementNamed("AdminPanel");
      } else {
        Navigator.of(context).pushReplacementNamed("Home");
      }
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
    } else if (e.code == 'user-not-found') {
      errorMessage = "No user found with this email";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Incorrect password";
    } else {
      errorMessage = "An unexpected error occurred";
    }

    _showErrorDialog(context, "Authentication Error", errorMessage);
  }

  // Show Error Dialog
  void _showErrorDialog(BuildContext context, String title, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: title,
      desc: message,
      animType: AnimType.rightSlide,
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ).show();
  }
}
