import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_3.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_4.dart';

Widget heartStateSelectWIdget(HeartRateControllers controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Obx(() => heartCard(controller)),
      heartCard1("Gender", Icons.male, "Male"),
      heartCard1("Age", Icons.person, "28"),
    ],
  );
}

//* card for selecting state
Widget heartCard(HeartRateControllers controller) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    width: 30 * SizeConfig.widthMultiplier,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0.632 * SizeConfig.heightMultiplier),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: 2.67 * SizeConfig.widthMultiplier,
        vertical: 1.05 * SizeConfig.heightMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header("State", Icons.star_border_outlined),
        SizedBox(
          height: 1.05 * SizeConfig.heightMultiplier,
        ),
        GestureDetector(
            //* button color and text color changing logic based on their selection
            onTap: () {
              Get.bottomSheet(
                  backgroundColor: Colors.white,
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.67 * SizeConfig.widthMultiplier,
                        vertical: 1.05 * SizeConfig.heightMultiplier),
                    height: 47.40 * SizeConfig.heightMultiplier,
                    child: Obx(
                      () => Column(
                        children: [
                          SizedBox(
                            height: 2.10 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buttonsDetail1(
                                  "Default",
                                  controller.DefaultSelect,
                                  controller.State.value == "Default"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "Default"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                              buttonsDetail1(
                                  "Fasting",
                                  controller.FastingSelect,
                                  controller.State.value == "Fasting"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "Fasting"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                              buttonsDetail1(
                                  "Before Eating",
                                  controller.BeforeEatingSelect,
                                  controller.State.value == "Before Eating"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "Before Eating"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                            ],
                          ),
                          SizedBox(
                            height: 2.10 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buttonsDetail1(
                                  "After Eating (1h)",
                                  controller.AfterEating1h,
                                  controller.State.value == "After Eating (1h)"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "After Eating (1h)"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                              buttonsDetail1(
                                  "After Eating (2h)",
                                  controller.AfterEating2h,
                                  controller.State.value == "After Eating (2h)"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "After Eating (2h)"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                            ],
                          ),
                          SizedBox(
                            height: 2.10 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buttonsDetail1(
                                  "Asleep",
                                  controller.AsleepSelect,
                                  controller.State.value == "Asleep"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "Asleep"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                              buttonsDetail1(
                                  "Before Workout",
                                  controller.BeforeWorkoutSelect,
                                  controller.State.value == "Before Workout"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "Before Workout"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                            ],
                          ),
                          SizedBox(
                            height: 2.10 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buttonsDetail1(
                                  "After Workout",
                                  controller.AfterWorkoutSelect,
                                  controller.State.value == "After Workout"
                                      ? Colours.buttonColorRed
                                      : Color.fromARGB(255, 246, 240, 241),
                                  controller.State.value == "After Workout"
                                      ? Colors.white
                                      : Colors.black,
                                  5.79 * SizeConfig.heightMultiplier,
                                  29.01 * SizeConfig.widthMultiplier,
                                  3.16 * SizeConfig.heightMultiplier,
                                  2.317 * SizeConfig.heightMultiplier),
                            ],
                          ),
                          SizedBox(
                            height: 5.79 * SizeConfig.heightMultiplier,
                          ),
                          authButton("OK", () {
                            Get.back();
                          })
                        ],
                      ),
                    ),
                  ));
            },
            child: FittedBox(
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                controller.State.value,
                style: TextStyle(
                    fontFamily: "CoreSansBold",
                    fontSize: 2.63 * SizeConfig.heightMultiplier,
                    color: Colors.black),
              ),
            )),
      ],
    ),
  );
}

Widget heartCard1(String title, IconData icon, String value) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    width: 30 * SizeConfig.widthMultiplier,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0.63 * SizeConfig.heightMultiplier),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: 2.67 * SizeConfig.widthMultiplier,
        vertical: 1.05 * SizeConfig.heightMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header(title, icon),
        SizedBox(
          height: 1.05 * SizeConfig.heightMultiplier,
        ),
        Text(
          value,
          style: TextStyle(
              fontFamily: "CoreSansBold",
              fontSize: 2.63 * SizeConfig.heightMultiplier,
              color: Colors.black),
        )
      ],
    ),
  );
}

Widget heartScaleWidget(HeartRateControllers controller) {
  return Container(
      height: 26.8 * SizeConfig.heightMultiplier,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.63 * SizeConfig.heightMultiplier),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 2.67 * SizeConfig.widthMultiplier,
          vertical: 1.1 * SizeConfig.heightMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Heart Rate Scale",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "CoreSansMed",
                fontWeight: FontWeight.bold,
                fontSize: 3.2 * SizeConfig.heightMultiplier),
          ),
          SizedBox(
            height: 1.58 * SizeConfig.heightMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              colorBarHeart(Colors.blue),
              colorBarHeart(Colors.green),
              colorBarHeart(Colors.red)
            ],
          ),
          SizedBox(
            height: 0.52668 * SizeConfig.heightMultiplier,
          ),
          Obx(
            ()=> AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.only(left: controller.arrowPosition.value),
              child: Icon(
                Icons.arrow_drop_up,
                color: controller.arrowColor.value,
                size: 4.4241728 * SizeConfig.heightMultiplier,
              ),
            ),
          ),
          SizedBox(
            height: 0.5 * SizeConfig.heightMultiplier,
          ),
          scaleText(Colors.blue, "Slow", "< 60 BPM"),
          SizedBox(
            height: 0.52 * SizeConfig.heightMultiplier,
          ),
          scaleText(Colors.green, "Normal", "60-100 BPM"),
          SizedBox(
            height: 0.52 * SizeConfig.heightMultiplier,
          ),
          scaleText(Colors.red, "Fast", "> 100 BPM"),
          SizedBox(
            height: 0.52 * SizeConfig.heightMultiplier,
          ),
        ],
      ));
}

Widget colorBarHeart(Color color) {
  return Container(
    width: 28 * SizeConfig.widthMultiplier,
    height: 1.26 * SizeConfig.heightMultiplier, // Adjust height as needed
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1.58 * SizeConfig.heightMultiplier),
      color: color,
    ),
  );
}
