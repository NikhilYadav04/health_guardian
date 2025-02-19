import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/profile/profile_controller.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/profile/profile_screens.dart';

final ProfileCompletionController profileController = Get.put(ProfileCompletionController());

Widget screen4(ProfileCompletionController controller) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 2.67 * SizeConfig.widthMultiplier),
    child: Column(
      children: [
        SizedBox(height: 1.58 * SizeConfig.heightMultiplier),
        FittedBox(
          child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            'Are You Currently Diagnosed\nwith Any of These Diseases?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "CoreSansBold",
                fontSize: 29.5),
          ),
        ),
        SizedBox(
          height: 5.26 * SizeConfig.heightMultiplier,
        ),
        //* for selecting diseases

        //* heart and blood sugar
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                diseaseCard(
                    "Heart",
                    profileController.heart_disease.value == true,
                    Icons.favorite, () {
                  profileController.heart_disease.value =
                      !profileController.heart_disease.value;
                }),
                diseaseCard(
                    "Sugar",
                    profileController.blood_sugar.value == true,
                    Icons.bloodtype, () {
                  profileController.blood_sugar.value =
                      !profileController.blood_sugar.value;
                }),
              ],
            )),

        SizedBox(height: 2.107 * SizeConfig.heightMultiplier),

        //* pressure and weight
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                diseaseCard(
                    "B.P",
                    profileController.blood_pressure.value == true,
                    Icons.health_and_safety, () {
                  profileController.blood_pressure.value =
                      !profileController.blood_pressure.value;
                }),
                diseaseCard("Weight", profileController.weight_bmi.value,
                    Icons.monitor_weight_outlined, () {
                  profileController.weight_bmi.value =
                      !profileController.weight_bmi.value;
                })
              ],
            ))
      ],
    ),
  );
}

Widget diseaseCard(
    String text, bool value, IconData icon, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: 13.69 * SizeConfig.heightMultiplier,
          width: 29.01 * SizeConfig.widthMultiplier,
          decoration: BoxDecoration(
              color: value ? Colours.buttonColorRed : Colors.white,
              shape: BoxShape.circle,
              border:
                  Border.all(color: const Color.fromARGB(255, 120, 118, 118))),
          child: Icon(
            icon,
            color: value ? Colors.white : Colors.black,
            size: 8.42 * SizeConfig.heightMultiplier,
          ),
        ),
        SizedBox(
          height: 2.10 * SizeConfig.heightMultiplier,
        ),
        profileScreenText(text)
      ],
    ),
  );
}
