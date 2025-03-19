import 'package:flutter/material.dart';
import 'package:health_guardian/styling/colors.dart';

Widget title1Heart() {
  return Text(
    "If your phone has sensors, you can capture heart rate readings, but they may be less accurate.",
    style: TextStyle(
        fontFamily: "CoreSansMed",
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade900),
  );
}

Widget title2Heart() {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Medical Disclaimer : ',
          style: TextStyle(color: Colors.red,fontFamily: "CoreSansMed" ,fontSize: 22,fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text:
              'For better accuracy, use data from smartwatches or fitness bands.',
          style: TextStyle(color: Colors.black,fontFamily: "CoreSansMed" ,fontSize: 22),
        ),
      ],
    ),
  );
}

Widget measureTextWidget(num value,String title){
  return Text(title,style: TextStyle(fontFamily: "CoreSansBold",fontSize: 33,color: Colors.grey.shade900),);
}

Widget measureTextWidget2(){
  return Text("Measuring your heart rate. Please put you fingers on the camera sensor to detect.",maxLines: 2,style: TextStyle(fontFamily: "CoreSansMed",fontSize: 20,color: Colors.grey.shade800,fontWeight: FontWeight.bold),);
}

Widget heartRate(){
  return AnimatedContainer(
   duration:   Duration(milliseconds: 2000),
    height: 80,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 238, 215, 217),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colours.buttonColorRed,spreadRadius: 3,blurRadius: 5)
              ]
            ),
            child: Center(
              child:
               RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Heart Rate Is : ',
                      style: TextStyle(color: Colors.red,fontFamily: "CoreSansMed" ,fontSize: 35,fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '72 BPM',
                      style: TextStyle(color: Colors.black,fontFamily: "CoreSansMed" ,fontSize: 35),
                    ),
                  ],
                ),
              ),
            ),
          ),
  );
}