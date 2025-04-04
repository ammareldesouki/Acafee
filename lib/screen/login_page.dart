import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/forget_password_page.dart';
import 'package:ammarcafe/screen/signup_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLooding = false;

  Future signInWithGoogle() async {
    setState(() {
      isLooding = true;
    });

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() {
          isLooding = false;
        });
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      _navigateToHome();
    } catch (e) {
      print("Google Sign-In Error: $e");
      setState(() {
        isLooding = false;
      });
    }
  }

  void _navigateToHome() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.email == "ammareldesouki82@gmail.com") {
        Navigator.of(context).pushReplacementNamed("AdminPanel");
      } else {
        Navigator.of(context).pushReplacementNamed("Home");
      }
    }
    setState(() {
      isLooding = false;
    });
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLooding
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: size.height * 0.2,
                      top: size.height * 0.05),
                  child: Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hello, \nWelcome Back",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 40)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    width: 30,
                                    image: AssetImage(
                                        'assets/icons/socialmedia/google.png')),
                                SizedBox(width: 40),
                                Image(
                                    width: 30,
                                    image: AssetImage(
                                        'assets/icons/socialmedia/facebook.png'))
                              ],
                            ),
                            const SizedBox(height: 50),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryVariant,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number"),
                                controller: Email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryVariant,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password"),
                                controller: Password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "must be non Empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPassword()));
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.orange),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                if (formState.currentState!.validate()) {
                                  setState(() {
                                    isLooding = true;
                                  });

                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                      email: Email.text,
                                      password: Password.text,
                                    );

                                    if (credential.user!.emailVerified) {
                                      _navigateToHome();
                                    } else {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification();
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.error,
                                          title: "Error",
                                          desc:
                                              "The account already exists for that email",
                                          animType: AnimType.rightSlide,
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          )).show();
                                      setState(() {
                                        isLooding = false;
                                      });
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      isLooding = false;
                                    });
                                    if (e.code == 'user-not-found') {
                                      print('No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      print(
                                          'Wrong password provided for that user.');
                                    }
                                  }
                                }
                              },
                              elevation: 0,
                              padding: const EdgeInsets.all(18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: AppColors.primaryColor,
                              child: const Center(
                                  child: Text(
                                "Login",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                            const SizedBox(height: 30),
                            MaterialButton(
                              onPressed: () {
                                signInWithGoogle();
                              },
                              padding: const EdgeInsets.all(18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Colors.red,
                              textColor: Colors.white,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign in with Google"),
                                  SizedBox(width: 20),
                                  Image(
                                    image: AssetImage(
                                        "assets/icons/socialmedia/google.png"),
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('SignUp');
                              },
                              child: const Text(
                                "Create account",
                                style: TextStyle(
                                    color: AppColors.primaryVariant),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
