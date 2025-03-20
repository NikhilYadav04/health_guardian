import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_guardian/screens/chatbot/gemini_chatbot_screen.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/dashboard_buttons.dart';

Widget aiDoctorWidget() {
  return GestureDetector(
    onTap: ()=> Get.to(()=>ChatbotScreen()),
    child: Container(
      padding:
          EdgeInsets.symmetric(horizontal: 4.46 * SizeConfig.widthMultiplier),
      height: 13.69 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 228, 210, 135),
          borderRadius:
              BorderRadius.circular(1.05 * SizeConfig.heightMultiplier)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //* for text
          Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.63 * SizeConfig.heightMultiplier,
                  ),
                  FittedBox(
                    child: Text(
                      "Your AI Doctor",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins-Bold",
                          fontSize: 2.8 * SizeConfig.heightMultiplier),
                    ),
                  ),
                  SizedBox(
                    height: 1.05 * SizeConfig.heightMultiplier,
                  ),
                  FittedBox(
                    child: Text(
                      "Chat with AI Assistant",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 80, 78, 78),
                          fontFamily: "Poppins-Bold",
                          fontSize: 1.9 * SizeConfig.heightMultiplier),
                    ),
                  ),
                  SizedBox(height: 2.63 * SizeConfig.heightMultiplier),
                ],
              )),
          //* for vector image
          Flexible(flex: 3, child: Image.asset(Images.AiDoctorIcon))
        ],
      ),
    ),
  );
}

Widget descTextAnalyze(String title, double fontSize) {
  return FittedBox(
    child: Text(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      title,
      style: TextStyle(
          color: Color.fromARGB(255, 99, 92, 92),
          fontFamily: "CoreSansLight",
          fontWeight: FontWeight.bold,
          fontSize: fontSize),
    ),
  );
}

Widget historyText() {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 1.2 * SizeConfig.widthMultiplier),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            "Ask With AI Doctor",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 3 * SizeConfig.heightMultiplier,
                fontFamily: "Poppins-Bold"),
          ),
        ),
      ],
    ),
  );
}

Widget analyzeDiseaseCard(
    String Disease,
    Color color,
    Color buttonColor,
    String Image,
    RxBool buttonValue,
    void Function(bool) OnTap1,
    void Function() OnTap) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 1.26 * SizeConfig.heightMultiplier,
        horizontal: 2.23 * SizeConfig.widthMultiplier),
    height: 23.17 * SizeConfig.heightMultiplier,
    width: 45.11 * SizeConfig.widthMultiplier,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.84 * SizeConfig.heightMultiplier),
        color: color),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 0.52 * SizeConfig.heightMultiplier,
        ),
        FittedBox(
          child: Text(
            Disease,
            style: TextStyle(
                fontFamily: "Poppins-Bold",
                fontSize: 2.63 * SizeConfig.heightMultiplier,
                color: Colors.grey.shade900),
          ),
        ),
        SizedBox(
          height: 1.58 * SizeConfig.heightMultiplier,
        ),
        analyzeButton(
            "Analyze",
            OnTap,
            buttonColor,
            Colors.white,
            4.74 * SizeConfig.heightMultiplier,
            24.55 * SizeConfig.widthMultiplier,
            3.16 * SizeConfig.heightMultiplier,
            2.00 * SizeConfig.heightMultiplier,
            buttonValue,
            OnTap1),
        SizedBox(
          height: 2.10 * SizeConfig.heightMultiplier,
        ),
        Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              Image,
              height: 7.37 * SizeConfig.heightMultiplier,
              width: 15.625 * SizeConfig.widthMultiplier,
            ))
      ],
    ),
  );
}

Widget reportCard(
    String image, String disease, Color bgColor, Color buttonColor) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: bgColor,
          boxShadow: [
            BoxShadow(color: buttonColor, blurRadius: 7, spreadRadius: 3)
          ]),
      height: 140,
      padding: EdgeInsets.symmetric(
          vertical: 1.5 * SizeConfig.heightMultiplier,
          horizontal: 1.4 * SizeConfig.widthMultiplier),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(
                image,
                scale: 6,
              )),
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disease,
                    style: TextStyle(
                        fontFamily: "Poppins-Bold",
                        fontSize: 3.6 * SizeConfig.heightMultiplier,
                        color: Colors.grey.shade900),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ReportButton("Check Report", () {}, buttonColor, Colors.white,
                      50, 180, 18, 20)
                ],
              )),
        ],
      ));
}

Widget ReportButton(
  String title,
  void Function() onTap,
  Color color,
  Color textColor,
  double height,
  double width,
  double radius,
  double textSize,
) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 100),
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(radius)),
    height: height,
    width: width,
    child: Center(
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontFamily: "CoreSansMed",
          fontWeight: FontWeight.bold,
        ).copyWith(fontSize: textSize),
      ),
    ),
  );
}
