import 'dart:convert';
import 'package:ammarcafe/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammarcafe/models/item_class.dart'; // Import your Item class
import 'package:ammarcafe/widget/botton_bar.dart'; // Your bottom bar widget
import 'package:ammarcafe/widget/nav_bar.dart'; // Your navigation bar widget
import 'package:ammarcafe/contest/colors.dart'; // Your color constants
import 'package:ammarcafe/widget/item_card.dart';
import 'package:provider/provider.dart'; // Your item card widget

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<List<Item>> loadItems() async {
    // Load the JSON file
    final String jsonString =
        await rootBundle.loadString('assets/json/DD.json');
    // Decode the JSON string into a List of dynamic objects
    final List<dynamic> jsonList = json.decode(jsonString);
    // Convert the List of dynamic objects into a List of Item objects
    return jsonList.map((json) => Item.fromJson(json)).toList();
  }

  late Future<List<Item>> itemsFuture; // Future to load items
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    itemsFuture = loadItems(); // Load items from JSON
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter items by category
  List<Item> _filterItems(List<Item> items, String category) {
    return items.where((item) => item.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), // Your navigation drawer
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
              child: FutureBuilder<List<Item>>(
                future: itemsFuture, // Load items from JSON
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No items found."));
                  } else {
                    final items = snapshot.data!;
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDrinkGrid(_filterItems(items, "Hot Coffee")),
                        _buildDrinkGrid(_filterItems(items, "Ice Coffee")),
                        _buildDrinkGrid(
                            _filterItems(items, "Speciality Coffee")),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(), // Your bottom navigation bar
    );
  }

  // Build a grid of drinks
  Widget _buildDrinkGrid(List<Item> items) {
    if (items.isEmpty) {
      return Center(
        child: Text("No drinks found in this category."),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      
        mainAxisExtent: 300,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemCard(
          item: items[index],
          onAddToCart: () {
    Provider.of<CartModel>(context, listen: false).addToCart(items[index]);

    // Show a SnackBar notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to Cart'),
        duration: Duration(seconds: 2),
      ),
    );          },
        );
      },
    );
  }
}
