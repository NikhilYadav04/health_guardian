import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';

Widget title1Heart() {
  return Text(
    "If your phone has sensors, you can capture heart rate readings, but they may be less accurate.",
    style: TextStyle(
        fontFamily: "CoreSansMed",
        fontSize: 2.31742 * SizeConfig.heightMultiplier,
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
          style: TextStyle(
              color: Colors.red,
              fontFamily: "CoreSansMed",
              fontSize: 2.31742 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text:
              'For better accuracy, use data from smartwatches or fitness bands.',
          style: TextStyle(
              color: Colors.black,
              fontFamily: "CoreSansMed",
              fontSize: 2.31742 * SizeConfig.heightMultiplier),
        ),
      ],
    ),
  );
}

Widget measureTextWidget(String title) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: "CoreSansBold",
        fontSize: 3.47613 * SizeConfig.heightMultiplier,
        color: Colors.grey.shade900),
  );
}

Widget measureTextWidget2() {
  return Text(
    "Measuring your heart rate. Please put you fingers on the camera sensor to detect.",
    maxLines: 2,
    style: TextStyle(
        fontFamily: "CoreSansMed",
        fontSize: 2.10674 * SizeConfig.heightMultiplier,
        color: Colors.grey.shade800,
        fontWeight: FontWeight.bold),
  );
}

Widget heartRate(num heartRate) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 2000),
    height: 8.42699 * SizeConfig.heightMultiplier,
    padding:
        EdgeInsets.symmetric(horizontal: 2.2321 * SizeConfig.widthMultiplier),
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: 1.264049 * SizeConfig.widthMultiplier),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 238, 215, 217),
          borderRadius:
              BorderRadius.circular(1.0533 * SizeConfig.heightMultiplier),
          boxShadow: [
            BoxShadow(
                color: Colours.buttonColorRed, spreadRadius: 3, blurRadius: 5)
          ]),
      child: Center(
        child: FittedBox(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Heart Rate Is : ',
                  style: TextStyle(
                      color: Colors.red,
                      fontFamily: "CoreSansMed",
                      fontSize: 3.68679 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${heartRate} BPM',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "CoreSansMed",
                      fontSize: 3.68679 * SizeConfig.heightMultiplier),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget heartRateInputWidget(HeartRateControllers controller) {
  return Container(
    height: 17.90 * SizeConfig.heightMultiplier,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0.63 * SizeConfig.heightMultiplier),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: 3.34 * SizeConfig.widthMultiplier,
        vertical: 2.10 * SizeConfig.heightMultiplier),
    child: Column(
      children: [
        Center(
          child: buttonsDetail1(
            "Enter your Heart Rate in bpm",
            () {},
            Colours.buttonColorRed,
            Colors.white,
            5.26 * SizeConfig.heightMultiplier,
            87.05 * SizeConfig.widthMultiplier,
            0.63 * SizeConfig.heightMultiplier,
            2.31 * SizeConfig.heightMultiplier,
          ),
        ),
        SizedBox(
          height: 2.10 * SizeConfig.heightMultiplier,
        ),
        //* Heart Rate Value Display
        GestureDetector(
          onTap: () {
            Get.bottomSheet(Container(
              height: 26.34 * SizeConfig.heightMultiplier,
              color: Colors.white,
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(
                  initialItem:
                      ((controller.heartBPMRate.value - 40) * 2).toInt(),
                ),
                onSelectedItemChanged: (int index) {
                  double selectedBPM = 40 + (index * 0.5);
                  controller.changeLevel(selectedBPM);
                },
                children: List<Widget>.generate(281, (int index) {
                  double value = 40 + (index * 0.5);
                  return Center(
                    child: Text(
                      "${value.toStringAsFixed(1)} bpm",
                      style: TextStyle(
                        fontFamily: "CoreSansBold",
                        fontSize: 2.73 * SizeConfig.heightMultiplier,
                      ),
                    ),
                  );
                }),
              ),
            ));
          },
          child: Obx(() => Text(
                "${controller.heartBPMRate.value} bpm",
                style: TextStyle(
                  fontFamily: "CoreSansBold",
                  fontSize: 4.00 * SizeConfig.heightMultiplier,
                  color: Colors.black,
                ),
              )),
        ),
      ],
    ),
  );
}
