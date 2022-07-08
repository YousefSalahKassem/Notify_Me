import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  EdgeInsets padding,margin;
  Color color;
  String text;
  VoidCallback function;
  double radius;
  ButtonApp({Key? key,
    required this.text,required this.color,
    this.padding=const EdgeInsets.symmetric(vertical: 20),
    this.margin= const EdgeInsets.symmetric(vertical: 20),
    this.radius=10,
    required this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding:padding ,
        margin:margin ,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
        ),
      ),
    );
  }
}