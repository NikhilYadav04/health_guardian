import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/heart-attack/heart_widgets.dart';
import 'package:lottie/lottie.dart';

class MeasureScreenHeart extends StatefulWidget {
  MeasureScreenHeart({super.key});

  @override
  State<MeasureScreenHeart> createState() => _MeasureScreenHeartState();
}

class _MeasureScreenHeartState extends State<MeasureScreenHeart> with SingleTickerProviderStateMixin{
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.2321*SizeConfig.widthMultiplier),
        child: Column(
          children: [
            SizedBox(
              height: 1.0533*SizeConfig.heightMultiplier,
            ),
            Center(
                child: Image.asset(
              "assets/dashboard/heart_2.png",
              height: 8.4269*SizeConfig.heightMultiplier,
              width: 17.8571*SizeConfig.widthMultiplier,
            )),
            SizedBox(
              height: 1.0533*SizeConfig.heightMultiplier,
            ),
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: 100),
              onEnd: () {
                setState(() {
                  check = !check;
                });
              },
              duration: Duration(seconds: 8),
              builder: (context, value, child) {
                return measureTextWidget(value,value == 100 ? "Measured..${value}%"  :"Measuring..${value}%"); // Pass counter value
              },
            ),
            SizedBox(
              height: 0.842699*SizeConfig.heightMultiplier,
            ),
            measureTextWidget2(),
            SizedBox(
              height: 0,
            ),
            SizedBox(
              height: 35.8147*SizeConfig.heightMultiplier,
              child:
                  LottieBuilder.asset("assets/animations/heart_animation.json"),
            ),
            check
                ? heartRate()
                : SizedBox(
                    height: 14.7472*SizeConfig.heightMultiplier,
                    width: 89.2857*SizeConfig.widthMultiplier,
                    child: LottieBuilder.asset(
                        "assets/animations/heart_rate_animation.json"),
                  ),
            check
                ? SizedBox(
                    height: 10.007*SizeConfig.heightMultiplier,
                  )
                : SizedBox(
                    height: 4.213497*SizeConfig.heightMultiplier,
                  ),
            Row(
              children: [
                Expanded(flex: 1,child: authButton("Measure", () {}),),
                SizedBox(width: 2.6785*SizeConfig.widthMultiplier),
                Expanded(flex: 1,child: authButton("Add Record", () {}),),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

PreferredSizeWidget appBar() {
  return AppBar(
    toolbarHeight: 9.48034*SizeConfig.heightMultiplier,
    backgroundColor: Color.fromARGB(255, 247, 241, 241),
    centerTitle: true,
    title: Text(
      "Heart Rate",
      style: TextStyle(
          color: Colors.black, fontFamily: "CoreSansBold", fontSize: 4.21349*SizeConfig.heightMultiplier),
    ),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 4.74018*SizeConfig.heightMultiplier,
        )),
    actions: [
      Image.asset(
        Images.heartPNG,
        scale: 1.00070*SizeConfig.heightMultiplier,
      ),
      SizedBox(
        width: 3.34821*SizeConfig.widthMultiplier,
      )
    ],
  );
}
