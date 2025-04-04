import 'package:ammarcafe/admin/category/add_category.dart';
import 'package:ammarcafe/admin/category/admin_panel.dart';
import 'package:ammarcafe/models/cart.dart';
import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:ammarcafe/screen/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Supabase
  await supabase.Supabase.initialize(
    url: 'https://rlqnmxkjduemprbejkkh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJscW5teGtqZHVlbXByYmVqa2toIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3Mzc2OTksImV4cCI6MjA1OTMxMzY5OX0.Ya5rlaI7TUoyWEZwbq-MMok_ydG69hsZ0jzGVqG6CQQ', // Replace with your actual anon key
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

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
