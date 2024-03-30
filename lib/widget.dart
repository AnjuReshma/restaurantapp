import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customwidget extends StatelessWidget {
   Customwidget({super.key, required this.rating});
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.green,
        child: Center(
          child: Row(
            children: [
              Text(rating,style: TextStyle(color: Colors.white),),
              SizedBox(width: 5,),
              Icon(Icons.star,color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}
