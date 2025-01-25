import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/screen/Home.dart';
import 'package:ammarcafe/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final int _currentIndex = 0;

  final List<Widget> _children = [
   HomeScreen(),
  HomeScreen(),
   HomeScreen(),
    LoginPage(),
  ];

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home"

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite"

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: "Notifications"

    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Account"

    ),
  ];

  void onTappedBar(int index) {
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
      backgroundColor: AppColors.tabText,
      selectedItemColor: AppColors.tabIndicator,
      unselectedItemColor: Colors.white,
      currentIndex: _currentIndex,
      onTap: onTappedBar,
      items: _items,
    );
  }
}
