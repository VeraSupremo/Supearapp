import 'dart:ffi';

import 'package:flutter/material.dart';

class SplashPref extends StatefulWidget {
  const SplashPref({super.key, required this.title});
  final String title;

  @override
  State<SplashPref> createState() => _SplashPref();
}


class _SplashPref extends State<SplashPref> {

  @override


  Widget build(BuildContext context) {
 
    return Scaffold(

      body: Center(
       
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/pictures/IconoApp.png'),width: 100 , height: 100,),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




