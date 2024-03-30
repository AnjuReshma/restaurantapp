import 'package:flutter/material.dart';
import 'package:restaurantapp/LoginPage.dart';

class Splashscreenpage extends StatelessWidget {
  const Splashscreenpage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    });
    return Scaffold(
      body: Center(
        child: Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logorest.jpg")),shape: BoxShape.circle)
        ),
        ),
    );
  }
}
