import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/screen/forget_password_page.dart';
import 'package:flutter/material.dart';
import 'package:ammarcafe/control/Authintaction.dart';
import 'package:ammarcafe/widget/buildTextFieldForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLooding = false;
  final AuthService _authService = AuthService();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
    late BuildTextFieldForm _buildTextFieldForm;
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
                            BuildTextFieldForm(
                              controller: Email,
                              label: "Email",
                            ),
                            const SizedBox(height: 20),
                            BuildTextFieldForm(
                              controller: Password,
                              label: "Password",
                              obscureText: true,
                              
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPassword()));
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
                                  _authService.SignIn(
                                    email: Email.text,
                                    password: Password.text,
                                    context: context,
                                  );
                                  setState(() {
                                    isLooding = true;
                                  });

                               
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

                                _authService.signInWithGoogle(context);
                                  setState(() {
                                    isLooding = true;
                                  });
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
