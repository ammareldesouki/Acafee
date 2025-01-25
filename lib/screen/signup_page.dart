import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ammarcafe/contest/colors.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey <FormState> formState= GlobalKey<FormState>();
  TextEditingController Email =TextEditingController();
  TextEditingController Password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: size.height * 0.2,
              top: size.height * 0.05,
            ),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, \nCreate a new account",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 40,
                    ),
                  ),
                  Expanded(
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              width: 30,
                              image: AssetImage(
                                  'assets/icons/socialmedia/google.png'),
                            ),
                            SizedBox(width: 40),
                            Image(
                              width: 30,
                              image: AssetImage(
                                  'assets/icons/socialmedia/facebook.png'),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),

                        // First Name Field
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryVariant,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              if (value.length < 3) {
                                return 'Name must be at least 3 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),

                        // Last Name Field
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryVariant,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Last name';
                              }
                              if (value.length < 3) {
                                return 'Name must be at least 3 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),

                        // Password Field
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryVariant,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Your Email",
                            ),
                            controller: Email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20),

                        // Password Field
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryVariant,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                            controller: Password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
                                  return 'Password must contain at least one uppercase letter, one lowercase letter, and one digit';
                                }
                                return null;
                              }
                          ),
                        ),
                        SizedBox(height: 20),

                        // Re-enter Password Field
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryVariant,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Re-enter Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please re-enter your password';
                              }
                              if (value != Password.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),



                  SizedBox(height: 30),


                     MaterialButton(
                       onPressed: () async {
                       if(formState.currentState!.validate()){


                         try {
                           final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                             email: Email.text,
                             password: Password.text,
                           );
                           Navigator.of(context).pushReplacementNamed("Login");
                         } on FirebaseAuthException catch (e) {
                           if (e.code == 'weak-password') {
                             AwesomeDialog(
                                 context: context,
                                 dialogType:DialogType.error ,
                                 title: "Erorr",
                                 desc: "weak-password",
                                 animType: AnimType.rightSlide,
                                 borderSide:  BorderSide(
                                   color: Colors.red,
                                   width: 2,
                                 )
                             ).show();
                           } else if (e.code == 'email-already-in-use') {
                             AwesomeDialog(
                                 context: context,
                                 dialogType:DialogType.error ,
                                 title: "Erorr",
                                 desc: "The account already exists for that email",
                                 animType: AnimType.rightSlide,
                                 borderSide:  BorderSide(
                                   color: Colors.red,
                                   width: 2,
                                 )
                             ).show();
                           }
                         } catch (e) {
                           print(e);
                         }


                       }


                       },
                       elevation: 0,
                       padding: EdgeInsets.all(18),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20),
                       ),
                       color: AppColors.primaryColor,

                       child: Center(
                         child: Text(
                           "Sign Up",
                           style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                       ),
                     ),
                     SizedBox(height: 10),
                     GestureDetector(
                       onTap: () {
                         // Navigate to LoginPage
                         Navigator.of(context).pushNamed("Login");

                       },
                       child: Text(
                         "Already have an account? Login",
                         style: TextStyle(color: AppColors.primaryVariant),
                       ),
                     ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Add this LoginPage class (or replace it with your existing LoginPage)
