import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class NavBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(

      child: ListView(
        children: [

          IconButton(onPressed: () async {
            GoogleSignIn googlesignin= GoogleSignIn();
            googlesignin.disconnect();

            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil("Login",(rout)=>false);
          }, icon:Icon( Icons.exit_to_app)),
          
          

          



        ],




      ),




    );
  }



}