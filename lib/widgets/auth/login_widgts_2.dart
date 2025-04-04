import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/auth/login_controllers.dart';
import 'package:health_guardian/styling/sizeConfig.dart';

Widget logoutCard(LoginAccountController controller) {
  return Container(
    height: 15.27388*SizeConfig.heightMultiplier,
    width: 62.58*SizeConfig.widthMultiplier,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade800, blurRadius: 2.5, spreadRadius: 2.5),
        ],
        borderRadius: BorderRadius.circular(1.26404*SizeConfig.heightMultiplier)),
    padding: EdgeInsets.symmetric(horizontal: 1.11607*SizeConfig.widthMultiplier, vertical: 2.1067*SizeConfig.heightMultiplier),
    child: Column(
      children: [
        FittedBox(
          child: Text(
            "Logout From App ?",
            style: TextStyle(
                fontFamily: "Poppins-Bold",
                fontSize: 2.52809*SizeConfig.heightMultiplier,
                color: Colors.grey.shade900),
          ),
        ),
        SizedBox(
          height: 1.053*SizeConfig.heightMultiplier,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: ()=>controller.logout(),
              icon: Icon(Icons.check_circle),
              color: Colors.green,
              iconSize: 4.42415*SizeConfig.heightMultiplier,
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.close),
              color: Colors.red,
              iconSize: 4.424158*SizeConfig.heightMultiplier,
            ),
          ],
        )
      ],
    ),
  );
}
