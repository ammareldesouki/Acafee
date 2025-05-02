import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ammarcafe/contest/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ammarcafe/control/Authintaction.dart';
import 'package:ammarcafe/widget/buildTextFieldForm.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? _profileImage; // To store the selected image
  final ImagePicker _picker = ImagePicker();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  late BuildTextFieldForm _buildTextFieldForm;

  Future<String?> _uploadProfileImage(File imageFile) async {
    try {
      String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');

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
                    const Text(
                      "Hello, \nCreate a new account",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 40,
                      ),
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          width: 30,
                          image:
                              AssetImage('assets/icons/socialmedia/google.png'),
                        ),
                        SizedBox(width: 40),
                        Image(
                          width: 30,
                          image: AssetImage(
                              'assets/icons/socialmedia/facebook.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
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
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            image: _profileImage != null
                                ? DecorationImage(
                                    image: FileImage(_profileImage!),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/default_profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          child: _profileImage == null
                              ? const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 40)
                              : null, // No icon if image is selected
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // First Name Field
                    BuildTextFieldForm(
                      controller: firstName,
                      label: "First Name",
                    ),
                    BuildTextFieldForm(
                      controller: lastName,
                      label: "Last Name",
                    ),
                    BuildTextFieldForm(
                      controller: Email,
                      label: "Email",
                    ),
                    BuildTextFieldForm(
                      controller: Password,
                      label: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),

                    // Last Name Field
             
                    const SizedBox(height: 20),

                    // Password Field

                    MaterialButton(
                      height: 60,
                      onPressed: () async {
                        if (formState.currentState!.validate()) {
                          final AuthService authService = AuthService();

                          // Upload the profile image to Firebase Storage
                          authService.signUp(
                              email: Email.text,
                              password: Password.text,
                              firstName: firstName.text,
                              lastName: lastName.text,
                              context: context);
                        }
                      },
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: AppColors.primaryColor,
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to LoginPage
                          Navigator.of(context).pushNamed("Login");
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(color: AppColors.primaryVariant,fontSize: 20),
                        ),
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
