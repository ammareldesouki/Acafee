import 'package:ammarcafe/admin/category/add_category.dart';
import 'package:ammarcafe/admin/category/admin_panel.dart';
import 'package:ammarcafe/admin/item/add_item.dart';
import 'package:ammarcafe/models/cart.dart';
import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:ammarcafe/screen/signup_page.dart';
import 'package:ammarcafe/screen/forget_password_page.dart';
import 'package:ammarcafe/widget/card_cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('=============================User is currently signed out!===========================');
      } else {
        print('==========================User is signed in!================================');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _getHomeScreen(user),
      routes: {
        "SignUp": (context) => SignupPage(),
        "Login": (context) => LoginPage(),
        "Home": (context) => HomeScreen(),
        "AdminPanel": (context) => AdminPanelScreen(),
        "AddCategory": (context) => AddCategoryScreen(),

      },
    );
  }

  
  Widget _getHomeScreen(User? user) {
    if (user == null) {
      return LoginPage(); 
    } else if (user.email == "ammareldesouki82@gmail.com") {
      return AdminPanelScreen(); 
    } else {
      return HomeScreen(); 
    }
  }
}
