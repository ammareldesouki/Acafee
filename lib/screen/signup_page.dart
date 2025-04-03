import 'dart:io';

import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ammarcafe/contest/colors.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
    File? _profileImage; // To store the selected image
  final ImagePicker _picker = ImagePicker();
  GlobalKey <FormState> formState= GlobalKey<FormState>();
  TextEditingController Email =TextEditingController();
  TextEditingController Password=TextEditingController();
Future<String?> _uploadProfileImage(File imageFile) async {
  try {
    String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/$fileName');
    
    await storageReference.putFile(imageFile);
    return await storageReference.getDownloadURL();
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<void> _pickImage() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    setState(() {
      _profileImage = File(image.path);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(

            child: Form(
              key: formState,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, \nCreate a new account",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 40,
                      ),
                    ),
                    
                   
                      
                      
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
                // Profile Image Upload Container
Center(
  child: GestureDetector(
    onTap: () async {
      await _pickImage();
    },
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryColor, width: 2),
        image: _profileImage != null
            ? DecorationImage(
                image: FileImage(_profileImage!),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: AssetImage('assets/images/default_profile.png'),
                fit: BoxFit.cover,
              ),
      ),
      child: _profileImage == null
          ? Icon(Icons.camera_alt, color: Colors.white, size: 40)
          : null, // No icon if image is selected
    ),
  ),
),
SizedBox(height: 20),

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
                              SizedBox(height: 20,),



                    MaterialButton(

                      height: 60,
                 onPressed: () async {
  if (formState.currentState!.validate()) {
    try {
      // Upload the profile image to Firebase Storage
      String? imageUrl;
      if (_profileImage != null) {
        imageUrl = await _uploadProfileImage(_profileImage!);
      }

      // Create user in Firebase Auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email.text,
        password: Password.text,
      );

      // Save user data in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set({
            "firstName": "User's First Name",
            "lastName": "User's Last Name",
            "email": Email.text,
            "profileImage": imageUrl ?? "",
          });

      // Navigate to Login
      Navigator.of(context).pushReplacementNamed("Login");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: "Error",
            desc: "Weak password",
            animType: AnimType.rightSlide,
            borderSide: BorderSide(color: Colors.red, width: 2),
        ).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: "Error",
            desc: "The account already exists for that email",
            animType: AnimType.rightSlide,
            borderSide: BorderSide(color: Colors.red, width: 2),
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }
},

                      elevation: 0,
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
            ),
          ),
        ),
      ),
    );
  }
}

// Add this LoginPage class (or replace it with your existing LoginPage)
