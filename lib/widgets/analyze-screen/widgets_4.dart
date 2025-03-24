import 'package:flutter/material.dart';

Widget showPrediction(
    Color shadowColor, Color backgroundColor, String text, String images,num height) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    height: 200,
    width: 320,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: backgroundColor,
      boxShadow: [
        BoxShadow(color: shadowColor, spreadRadius: 3, blurRadius: 3)
      ],
    ),
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            images,
            height: 110,
            width: 110,
          ),
        ),
        SizedBox(height: 18),
        Expanded(
          flex: 1,
          child: Text(
              text,
              style: TextStyle(
                  fontFamily: "Poppins-Bold", color: Colors.black, fontSize: 15.5),
            ),
        ),
      ],
    ),
  );
}
