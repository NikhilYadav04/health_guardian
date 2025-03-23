import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/analyze-screen/hypertension_controllers.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_3.dart';

Widget CigsCard(String title, IconData icon, String value, double width,
    HypertensionControllers controller) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    width: width,
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
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                height: 26.34 * SizeConfig.heightMultiplier,
                color: Colors.white,
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: controller.Cigs_Count.value.toInt(),
                  ),
                  onSelectedItemChanged: (int index) {
                    int selectedNum = index; // Calculate the selected hour
                    controller.change(selectedNum); // Update the value
                  },
                  children: List<Widget>.generate(15, (int index) {
                    int value = index; // Generate values from 1 to 12
                    return Center(
                      child: Text(
                        "$value",
                        style: TextStyle(
                          fontFamily: "CoreSansBold",
                          fontSize: 2.73 * SizeConfig.heightMultiplier,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
          child: Obx(
            () => Text(
              "${controller.Cigs_Count.value}",
              style: TextStyle(
                  fontFamily: "CoreSansBold",
                  fontSize: 2.63 * SizeConfig.heightMultiplier,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget MedsCard(String title, IconData icon, String value, double width,
    HypertensionControllers controller) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(.63 * SizeConfig.heightMultiplier),
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
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                height: 26.34 * SizeConfig.heightMultiplier,
                color: Colors.white,
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: controller.Meds_Count.value.toInt(),
                  ),
                  onSelectedItemChanged: (int index) {
                    int selectedNum = index; // Calculate the selected hour
                    controller.change_Meds(selectedNum); // Update the value
                  },
                  children: List<Widget>.generate(10, (int index) {
                    int value = index; // Generate values from 1 to 12
                    return Center(
                      child: Text(
                        "$value",
                        style: TextStyle(
                          fontFamily: "CoreSansBold",
                          fontSize: 2.73 * SizeConfig.heightMultiplier,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
          child: Obx(
            () => Text(
              "${controller.Meds_Count.value}",
              style: TextStyle(
                  fontFamily: "CoreSansBold",
                  fontSize: 2.63 * SizeConfig.heightMultiplier,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget BMICard(String title, IconData icon, String value, double width,
    HypertensionControllers controller) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    width: width,
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
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                height: 26.34 * SizeConfig.heightMultiplier,
                color: Colors.white,
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem:
                        ((controller.BMI_Count.value - 10.0) * 10).toInt(),
                  ),
                  onSelectedItemChanged: (int index) {
                    double selectedBMI =
                        10.0 + (index * 0.1); // Calculate the selected BMI
                    controller.change_BMI(selectedBMI); // Update the BMI value
                  },
                  children: List<Widget>.generate(901, (int index) {
                    double value = 10.0 +
                        (index * 0.1); // Generate BMI values from 10.0 to 100.0
                    return Center(
                      child: Text(
                        value.toStringAsFixed(1),
                        style: TextStyle(
                          fontFamily: "CoreSansBold",
                          fontSize: 2.73 * SizeConfig.heightMultiplier,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
          child: Obx(
            () => Text(
              "${controller.BMI_Count.value} BMI",
              style: TextStyle(
                  fontFamily: "CoreSansBold",
                  fontSize: 2.63 * SizeConfig.heightMultiplier,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget CholesterolCard(String title, IconData icon, String value, double width,
    HypertensionControllers controller) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    width: width,
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
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                height: 26.34 * SizeConfig.heightMultiplier,
                color: Colors.white,
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: (controller.Cholesterol_Level.value).toInt(),
                  ),
                  onSelectedItemChanged: (int index) {
                    double selectedBMI =
                        index.toDouble(); // Calculate the selected BMI
                    controller.change_Cholesterol(selectedBMI); // Update the BMI value
                  },
                  children: List<Widget>.generate(301, (int index) {
                    double value = index
                        .toDouble(); // Generate BMI values from 0.0 to 300.0
                    return Center(
                      child: Text(
                        value.toStringAsFixed(1),
                        style: TextStyle(
                          fontFamily: "CoreSansBold",
                          fontSize: 2.73 * SizeConfig.heightMultiplier,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
          child: Obx(
            () => Text(
              "${controller.Cholesterol_Level.value} mg/dL",
              style: TextStyle(
                  fontFamily: "CoreSansBold",
                  fontSize: 2.63 * SizeConfig.heightMultiplier,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
