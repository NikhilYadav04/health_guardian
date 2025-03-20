import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/screens/detail-screens/heart-rate/add_heart_rate_screen.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/heart-attack/heart_widgets.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class MeasureScreenHeart extends StatefulWidget {
  MeasureScreenHeart({super.key});

  @override
  State<MeasureScreenHeart> createState() => _MeasureScreenHeartState();
}

class _MeasureScreenHeartState extends State<MeasureScreenHeart> {
  bool check = false;

  final HeartRateControllers heartRateControllers =
      Get.find<HeartRateControllers>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 2.2321 * SizeConfig.widthMultiplier),
        child: Column(
          children: [
            SizedBox(
              height: 1.0533 * SizeConfig.heightMultiplier,
            ),
            Center(
                child: Image.asset(
              "assets/dashboard/heart_2.png",
              height: 8.4269 * SizeConfig.heightMultiplier,
              width: 17.8571 * SizeConfig.widthMultiplier,
            )),
            SizedBox(
              height: 1.0533 * SizeConfig.heightMultiplier,
            ),
            check
                ? TweenAnimationBuilder<int>(
                    key: ValueKey(check),
                    tween: IntTween(begin: 0, end: 100),
                    duration: Duration(seconds: 8),
                    onEnd: () {
                      heartRateControllers.onEnd();
                      if (check) {
                        setState(() {
                          check = false;
                        });
                      }
                    },
                    builder: (context, value, child) {
                      return measureTextWidget(value == 100
                          ? "Measured..${value}%"
                          : "Measuring..${value}%");
                    },
                  )
                : measureTextWidget("Click To Measure"),
            SizedBox(
              height: 0.842699 * SizeConfig.heightMultiplier,
            ),
            measureTextWidget2(),
            SizedBox(
              height: 0,
            ),
            SizedBox(
              height: 35.8147 * SizeConfig.heightMultiplier,
              child:
                  LottieBuilder.asset("assets/animations/heart_animation.json"),
            ),
            Obx(() => !heartRateControllers.animationBool.value
                ? heartRate(heartRateControllers.heartRate.value)
                : SizedBox(
                    height: 14.7472 * SizeConfig.heightMultiplier,
                    width: 89.2857 * SizeConfig.widthMultiplier,
                    child: LottieBuilder.asset(
                        "assets/animations/heart_rate_animation.json"),
                  )),
            Obx(
              () => !heartRateControllers.animationBool.value
                  ? SizedBox(
                      height: 10.007 * SizeConfig.heightMultiplier,
                    )
                  : SizedBox(
                      height: 4.213497 * SizeConfig.heightMultiplier,
                    ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: authButton("Measure", () {
                    heartRateControllers.reCheck();
                    heartRateControllers.getHeartRate();
                    setState(() {
                      check = true;
                    });
                    var logger = Logger();
                    logger.d(check);
                  }),
                ),
                SizedBox(width: 2.6785 * SizeConfig.widthMultiplier),
                Expanded(
                  flex: 1,
                  child: authButton("Add Record", () {
                    Get.to(()=>AddHeartRateScreen(),transition: Transition.upToDown);
                  }),
                ),
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
    toolbarHeight: 9.48034 * SizeConfig.heightMultiplier,
    backgroundColor: Color.fromARGB(255, 247, 241, 241),
    centerTitle: true,
    title: Text(
      "Heart Rate",
      style: TextStyle(
          color: Colors.black,
          fontFamily: "CoreSansBold",
          fontSize: 4.21349 * SizeConfig.heightMultiplier),
    ),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 4.74018 * SizeConfig.heightMultiplier,
        )),
    actions: [
      Image.asset(
        Images.heartPNG,
        scale: 1.00070 * SizeConfig.heightMultiplier,
      ),
      SizedBox(
        width: 3.34821 * SizeConfig.widthMultiplier,
      )
    ],
  );
}
