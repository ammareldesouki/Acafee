import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/contest/xo.dart';
import 'package:ammarcafe/widget/botton_bar.dart';
import 'package:ammarcafe/widget/nav_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {

 @override
Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return SafeArea(
    child: Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        actions: const [
          Icon(CupertinoIcons.bell_solid, color: Colors.white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/amricano.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 100.0,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      "assets/images/coffee2.png",
                      width: 150.0,
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: -180.0,
                  child: Image.asset("assets/images/square.png"),
                ),
                Positioned(
                  left: -70.0,
                  bottom: -40.0,
                  child: Image.asset("assets/images/drum.png"),
                ),
                Container(
                  height: 300.0,
                  padding: EdgeInsets.symmetric(
                    vertical: kToolbarHeight,
                    horizontal: 16.0,
                  ),
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Iced and chilled coffee",
                        style: TextStyle(color: kTextColor1),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Latte with Almond Milk",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Almond milk is mostly water, so mixed with coffee, the almond flavor is totally overpowered by strong coffee. A good almond lattee needs to be made with a thick homemade vanilla almond milk creamer.",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: kTextColor1, height: 1.8),
                      ),
                      SizedBox(height: 20.0),
                      Divider(),
                      doubleColText("Quantity", "4"),
                      Divider(),
                      doubleColText("Amount Payable", "\$10.44 USD"),
                      SizedBox(height: 30.0),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          color: kTextColor1,
                          onPressed: () {},
                          child: Text(
                            "Add to my cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    ),
  );
}

}

Widget doubleColText(String textOne, String textTwo) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 12.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textOne,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        Text(
          textTwo,
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ],
    ),
  );
}