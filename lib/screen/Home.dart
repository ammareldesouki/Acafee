import 'dart:convert';
import 'package:ammarcafe/widget/botton_bar.dart';
import 'package:ammarcafe/widget/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/widget/item_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<dynamic> Drinks = [];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    ReadData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> ReadData() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString("assets/json/DD.json");
      setState(() {
        Drinks = json.decode(data);
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  List<dynamic> _filterDrinks(String category) {
    return Drinks.where((drink) => drink['category'] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(

        backgroundColor: AppColors.primaryVariant,
        actions: [
          Icon(CupertinoIcons.bell_solid, color: Colors.white),
        ],
      ),
      backgroundColor: AppColors.textLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "It's A Great Day For Coffee",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        hintText: "Find Your drink",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                    isScrollable: false,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFFE57734),
                      ),
                    ),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.local_fire_department_rounded),
                        text: "Hot Coffee",
                      ),
                      Tab(
                        icon: Icon(Icons.ac_unit),
                        text: "Ice Coffee",
                      ),
                      Tab(
                        icon: Icon(Icons.science),
                        text: "Speciality Coffee",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDrinkGrid(_filterDrinks("Hot Drinks")),
                  _buildDrinkGrid(_filterDrinks("Cold Drinks")),
                  _buildDrinkGrid(_filterDrinks("Hot Drinks")), // Adjust category as needed
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomNavBar() ,
    );
  }

  Widget _buildDrinkGrid(List<dynamic> drinks) {
    if (drinks.isEmpty) {
      return Center(
        child: Text("No drinks found in this category."),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        var drink = drinks[index];
        return ItemCard(
          name: drink['name'],
          image: drink['image'],
          category: drink['category'],
        );
      },
    );
  }
}