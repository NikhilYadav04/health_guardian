import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/button/button_controllers.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/getX_controllers/notification/notification-controllers.dart';
import 'package:health_guardian/getX_controllers/profile/profile_controller.dart';
import 'package:health_guardian/screens/detail-screens/blood-pressure/blood_pressure_detail.dart';
import 'package:health_guardian/screens/detail-screens/blood-sugar/blood_sugar_detail.dart';
import 'package:health_guardian/screens/detail-screens/heart-rate/opening_screen_heart.dart';
import 'package:health_guardian/screens/detail-screens/weight_measure/weight_measure_detail.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_1.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';

class Home_D_Screen extends StatelessWidget {
  Home_D_Screen({
    super.key,
  });

  final ButtonControllers controller = Get.put(ButtonControllers());
  final ProfileCompletionController profileCompletionController =
      Get.find<ProfileCompletionController>();
  final EditHeartRateDataController editController =
      Get.put(EditHeartRateDataController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //* Title Widget
      Obx(() => titleWidget(profileCompletionController.Name.value)),
      SizedBox(
        height: 3.16 * SizeConfig.heightMultiplier,
      ),

      //* Disease Cards
      heartMeasureCard(() {
        Get.to(() => OpeningScreenHeart());
      }, editController),
      SizedBox(
        height: 3.16 * SizeConfig.heightMultiplier,
      ),
      diseaseCard("Blood Pressure", Images.BloodPressureMeasureIcon,
          Color.fromARGB(255, 169, 207, 239), Colors.blue, () {
        Get.to(() => BloodPressureDetail());
      }, controller.bloodPressure, controller.setBloodPressure),
      SizedBox(
        height: 1.58 * SizeConfig.heightMultiplier,
      ),
      diseaseCard("Blood Sugar", Images.BloodSugarMeasureIcon,
          Color.fromARGB(255, 164, 238, 183), Colors.green, () {
        Get.to(() => BloodSugarDetail());
      }, controller.bloodSugarDetail, controller.setBloodSugar),
      SizedBox(
        height: 1.58 * SizeConfig.heightMultiplier,
      ),
      diseaseCard(
          "Weight Measure",
          Images.WeightMeasureIcon,
          Color.fromARGB(255, 235, 245, 174),
          Color.fromARGB(255, 226, 207, 41), () {
        Get.to(() => WeightMeasureDetail());
      }, controller.weightDetail, controller.setWeightDetail),

      SizedBox(
        height: 2.8 * SizeConfig.heightMultiplier,
      ),

      historyText(),

      SizedBox(
        height: 2.1 * SizeConfig.heightMultiplier,
      ),

      //* AI Doctor
      aiDoctorWidget(),
      SizedBox(
        height: 3.16 * SizeConfig.heightMultiplier,
      ),
    ]);
  }
}
