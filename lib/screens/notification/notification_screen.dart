import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
       backgroundColor: Color.fromARGB(255, 247, 241, 241),
         //* AppBar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 241, 241),
        toolbarHeight: 8.427 * SizeConfig.heightMultiplier,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 4.424 * SizeConfig.heightMultiplier,
            )),
        title: FittedBox(
          child: Text(
            "Notifications",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "CoreSansBold",
                fontSize: 3.581 * SizeConfig.heightMultiplier),
          ),
        ),
        actions: [
          Image.asset(
            Images.notificationPNG,
            height: 4.740185 * SizeConfig.heightMultiplier,
            width: 10.04464*SizeConfig.widthMultiplier,
          ),
          SizedBox(
            width: 2.678 * SizeConfig.widthMultiplier,
          )
        ],
      ),
    ));
  }
}