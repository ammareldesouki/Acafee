import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/forget_password_page.dart';
import 'package:ammarcafe/screen/signup_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null){
      return ;

    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("Home");

  }



  GlobalKey <FormState> formState= GlobalKey<FormState>();
  TextEditingController Email= TextEditingController();
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
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: size.height * 0.2, top: size.height * 0.05),
                  child: Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello, \nWelcome Back", style:TextStyle(color:AppColors.primaryColor,fontSize: 40)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    width: 30,
                                    image: AssetImage('assets/icons/socialmedia/google.png')
                                ),
                                SizedBox(width: 40),
                                Image(
                                    width: 30,
                                    image: AssetImage('assets/icons/socialmedia/facebook.png')
                                )
                              ],
                            ),
                            SizedBox(height: 50,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryVariant,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number"
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
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color:AppColors.primaryVariant,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password"
                                ),
                                controller: Password,
                                validator: (value){
                                 if(value==null|| value.isEmpty)
                                  return "must be non Empty";


                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                                
                              },
                              
                            
                            child:   Text("Forgot Password?", style:TextStyle(color: Colors.orange),),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                if(formState.currentState!.validate()){


                                  try {
                                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: Email.text,
                                      password: Password.text,
                                    );
                                    if(credential.user!.emailVerified){


                                    Navigator.of(context).pushReplacementNamed("Home");
                                    }else{

                                      FirebaseAuth.instance.currentUser!.sendEmailVerification();
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

                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      print('No user found for that email.');
                                    } else if (e.code == 'wrong-password') {
                                      print('Wrong password provided for that user.');
                                    }
                                  }


                                }else{
                                  print("that not vaild");
                                }

                    
                              },
                              elevation: 0,
                              padding: EdgeInsets.all(18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              color: AppColors.primaryColor,
                              child: Center(child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold),)),
                            ),
                            SizedBox(height: 30,),
                    
                            MaterialButton(onPressed: (){
                              signInWithGoogle();

                            },
                              padding: EdgeInsets.all(18),
                    
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign in as Google "),
                                  SizedBox(width: 20,),
                                  Image(image: AssetImage("assets/icons/socialmedia/google.png"),height: 20,)
                    
                                ],
                    
                    
                              ),
                    
                    
                    
                            ),
                    
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed('SignUp');
                    
                    
                              },
                    
                           child:  Text("Create account", style: TextStyle(color: AppColors.primaryVariant))
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
