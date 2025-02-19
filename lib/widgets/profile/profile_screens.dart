import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/profile/profile_controller.dart';
import 'package:health_guardian/screens/profile/profile_completion_screen.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/onboard/onboard_widgets.dart';


Widget profileScreenText(String title) {
  return Text(
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    title,
    style: TextStyle(
        color: Colors.black,
        fontFamily: "CoreSansBold",
        fontSize: 3.58 * SizeConfig.heightMultiplier),
  );
}

Widget screen1(ProfileCompletionController controller) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 2.67 * SizeConfig.widthMultiplier),
    child: Column(
      children: [
        SizedBox(
          height: 1.05 * SizeConfig.heightMultiplier,
        ),
        profileScreenText("Let's Know you More, Enter Your Full Name."),
        SizedBox(
          height: 8.42 * SizeConfig.heightMultiplier,
        ),
        //* field or entering name for profile
        TextField(
          style: TextStyle(
              color: const Color.fromARGB(255, 144, 138, 138),
              fontFamily: "CoreSansBold",
              fontSize: 4.21 * SizeConfig.heightMultiplier),
          controller: controller.nameController,
          decoration: InputDecoration(
            label: Center(
              child: FittedBox(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Your Name",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 144, 138, 138),
                      fontFamily: "CoreSansBold",
                      fontSize: 4.74 * SizeConfig.heightMultiplier),
                ),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.08 * SizeConfig.widthMultiplier,
                vertical: 3.16 * SizeConfig.heightMultiplier),
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(4.21 * SizeConfig.heightMultiplier),
                borderSide: BorderSide(
                    width: 1.11 * SizeConfig.heightMultiplier,
                    color: const Color.fromARGB(255, 154, 147, 147))),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(3.16 * SizeConfig.heightMultiplier),
                borderSide: BorderSide(
                    width: 0.44 * SizeConfig.widthMultiplier,
                    color: const Color.fromARGB(255, 154, 147, 147))),
          ),
        )
      ],
    ),
  );
}

Widget screen2(ProfileCompletionController controller) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 2.67 * SizeConfig.widthMultiplier),
    child: Column(
      children: [
        SizedBox(
          height: 1.58 * SizeConfig.heightMultiplier,
        ),
        profileScreenText("What's your Gender ?"),
        SizedBox(
          height: 5.26 * SizeConfig.heightMultiplier,
        ),
        // * for selecting male and female genders and changing colours
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  controller.gender.value = "Male";
                  print(controller.gender.value);
                },
                child: Column(
                  children: [
                    Container(
                      height: 13.69 * SizeConfig.heightMultiplier,
                      width: 29.01 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                          color: controller.gender.value == "Male"
                              ? Colours.buttonColorRed
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color.fromARGB(255, 120, 118, 118))),
                      child: Icon(
                        Icons.male,
                        color: controller.gender.value == "Male"
                            ? Colors.white
                            : Colors.black,
                        size: 8.42 * SizeConfig.heightMultiplier,
                      ),
                    ),
                    SizedBox(
                      height: 2.107 * SizeConfig.heightMultiplier,
                    ),
                    profileScreenText("Male")
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.gender.value = "Female";
                },
                child: Column(
                  children: [
                    Container(
                      height: 13.69 * SizeConfig.heightMultiplier,
                      width: 29.01 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                          color: controller.gender.value == "Female"
                              ? Colours.buttonColorRed
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color.fromARGB(255, 120, 118, 118))),
                      child: Icon(
                        Icons.female,
                        color: controller.gender.value == "Female"
                            ? Colors.white
                            : Colors.black,
                        size: 8.42 * SizeConfig.heightMultiplier,
                      ),
                    ),
                    SizedBox(
                      height: 2.107 * SizeConfig.heightMultiplier,
                    ),
                    profileScreenText("Female")
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 6.32 * SizeConfig.heightMultiplier,
        ),
        Center(
          child: buttonsSample("Prefer not to say", () {
            controller.gender.value = "";
          }, Color.fromARGB(255, 243, 219, 222), Colors.black, 60, 280),
        )
      ],
    ),
  );
}
