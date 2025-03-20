import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/screens/detail-screens/heart-rate/heart_rate_history_screen.dart';
import 'package:health_guardian/screens/detail-screens/heart-rate/measure_screen_heart.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/heart-attack/heart_widgets.dart';
import 'package:lottie/lottie.dart';

class OpeningScreenHeart extends StatelessWidget {
  OpeningScreenHeart({super.key});

  final HeartRateControllers heartRateControllers = Get.put(HeartRateControllers());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      appBar: appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.2321*SizeConfig.widthMultiplier),
        child: Column(
          children: [
            SizedBox(height: 1.58006*SizeConfig.heightMultiplier,),

            title1Heart(),

            SizedBox(height: 1.0533*SizeConfig.heightMultiplier,),

            LottieBuilder.asset("assets/animations/heart_animation.json",height: 44.2417*SizeConfig.heightMultiplier,width: 100.446*SizeConfig.widthMultiplier,),

            SizedBox(height: 3.16012*SizeConfig.heightMultiplier,),

            title2Heart(),

            SizedBox(height: 10.0070*SizeConfig.heightMultiplier,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: authButton("Measure", (){
                    Get.to(()=>MeasureScreenHeart(),transition: Transition.downToUp);
                  }),
                ),
                SizedBox(width: 2.6785*SizeConfig.widthMultiplier,),
                 Expanded(
                  flex: 1,
                   child: authButton("History", (){
                    Get.to(()=>HeartRateHistoryScreen(),transition: Transition.downToUp);
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
    toolbarHeight:  9.48034*SizeConfig.heightMultiplier,
    backgroundColor: Color.fromARGB(255, 247, 241, 241),
    centerTitle: true,
    title: Text(
      "Measure",
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
