import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:ammarcafe/screen/signup_page.dart';
import 'package:ammarcafe/screen/forget_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main  () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('=============================User is currently signed out!===========================');
      } else {
        print('==========================User is signed in!================================');
      }
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: FirebaseAuth.instance.currentUser==null? LoginPage():HomeScreen(),
      routes: {
    "SignUp": (context)=> SignupPage(),
        "Login": (context)=>LoginPage(),
        "Home" :(context)=>HomeScreen()


    },
    );
  }
}



