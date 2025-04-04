import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/screen/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:ammarcafe/screen/cart_page.dart';
import 'package:ammarcafe/screen/favourite_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    FavouritePage(),
    CartScreen(),
     const UserProfilePage(),
  ];
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_rounded),
      label: "Cart",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Account",
    ),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _children[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryVariant,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.white,
      currentIndex: _currentIndex,
      onTap: onTappedBar,
      items: _items,
    );
  }
}