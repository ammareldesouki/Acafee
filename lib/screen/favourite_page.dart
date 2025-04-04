import 'package:ammarcafe/contest/colors.dart';
import 'package:ammarcafe/widget/botton_bar.dart';
import 'package:ammarcafe/widget/item_card.dart';
import 'package:ammarcafe/widget/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class FavouritePage extends StatelessWidget{
  const FavouritePage({super.key});





  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: NavBar(),

    appBar: AppBar(
      title: const Center(child: Text(" you favourie drinks")),

    backgroundColor: AppColors.primaryVariant,
    actions: const [
    Icon(CupertinoIcons.bell_solid, color: Colors.white),
    ],
    ),
      body: SafeArea(child: ListView(

        children: const [





        ],


      )),

      bottomNavigationBar: const BottomNavBar(),
    );
  }


}