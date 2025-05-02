import 'package:ammarcafe/contest/colors.dart';

import 'package:ammarcafe/screen/Home.dart';
import 'package:flutter/material.dart';



class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100,bottom: 100),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(image: AssetImage("assets/images/bg.png")),

        ),

  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
    children: [
    const Text("Coffe Shop",style: TextStyle(color: Colors.white,fontSize: 50),),
      
      Column(
        children: [
          const Text("Feeling Low ?Take a Sip of Coffee",
            style: TextStyle(color: Colors.white,
             fontSize: 18,
             fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),),

            const SizedBox(height: 80,),
          InkWell(

            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
            },
            child: Ink(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal:50 ),
                 decoration: BoxDecoration(
                   color: AppColors.buttonBackground,
                   borderRadius: BorderRadius.circular(10),

                 ),
                child: Container(child: const Text("Get Start",
                  style: TextStyle(color: Colors.white,fontSize: 22,letterSpacing: 1,fontWeight: FontWeight.bold),),),




              ),
            ),

          )

        ],
      )

      ],



  ),
      ),

    );//

  }




}

