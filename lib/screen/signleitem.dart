import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/models/drink_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SingleItemScreen extends StatelessWidget {
  final String name ;
  final String photo;
  final String catagory;

  SingleItemScreen(this.name, this.photo, this.catagory); // const SingleItemScreen({required this.drink});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.textLight,

    appBar: AppBar(
      backgroundColor: AppColors.primaryVariant,
      leading: Icon(Icons.menu, color: Colors.white),
      actions: [
        Icon(CupertinoIcons.bell_solid, color: Colors.white),
      ],
    ),
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image(image: AssetImage(this.photo),width: MediaQuery.of(context).size.width/1.2),
            ),
            
            Text("Best Coffee",
              style:TextStyle(color:AppColors.accentLight,letterSpacing: 3) ,),
            Text(this.name,
              style:TextStyle(fontSize: 30,color: AppColors.accentColor)),
            SizedBox(
              height: 20,
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.backgroundLight,
                      ), // Border.all
                      borderRadius: BorderRadius.circular(20),
                    ), // BoxDecoration
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.minus,
                          size: 18,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 15,),
                        Text("2"),// Icon
                        SizedBox(width: 15,),
                        Icon(
                          CupertinoIcons.plus,
                          size: 18,
                          color: Colors.blue,
                        ),

                      ],
                    ), // Row
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50),


                 child: Text("\$600",style: TextStyle(color:AppColors.accentColor ,),)
                  ),// Add other widgets here if needed
                ],

              ), // Row
            ),
            Text("Cup of Amircan Coffe WIth double Shot "),

            SizedBox(height: 100,),

            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 50,
                    ), // EdgeInsets.symmetric
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 50, 54, 56),
                      borderRadius: BorderRadius.circular(18),
                    ), // BoxDecoration
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ), // TextStyle
                    ), // Text
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFE57734),
                      borderRadius: BorderRadius.circular(18),
                    ), // BoxDecoration
                    child: Icon(
                      Icons.favorite_outline,
                      size: 24, // You can adjust the size as needed
                      color: Colors.white, // You can adjust the color as needed
                    ), // Icon
                  ), // Container// Container
                ],
              ), // Row
            ),
            // Container



          ],

        ),
      ),
    ),
  );
}
}