import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/screen/signleitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String image;
  final String category;
    ItemCard({required this.name, required this.image,required this.category});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:AppColors.cardAccent,
          boxShadow: [
            BoxShadow(
              color: AppColors.cardBackground,
              spreadRadius: 1,
              blurRadius: 8,
            ), // BoxShadow
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleItemScreen(this.name,this.image,this.category)));


            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Image(
                image: AssetImage(this.image),
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                  children: [

                Text(
                  this.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.cardText),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "best Coffe",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$30",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
