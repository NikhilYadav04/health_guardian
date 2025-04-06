import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/button/button_controllers.dart';
import 'package:health_guardian/screens/report/blood_pressure/blood_pressure_report.dart';
import 'package:health_guardian/screens/report/blood_sugar/blood_sugar_report.dart';
import 'package:health_guardian/screens/report/heart_rate/heart_rate_screen.dart';
import 'package:health_guardian/screens/report/weight/weight_report.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';

class ReportScreen extends StatelessWidget {
  final ButtonControllers controllers = Get.put(ButtonControllers());
  ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1* SizeConfig.heightMultiplier,),
        //* title and description
        T1("Check Stored Report", Images.reportIcon),

        SizedBox(
          height: 1.9*SizeConfig.heightMultiplier,
        ),
        descTextAnalyze("Check your health report history and track all\nyour stored data effortlessly.",2.2 * SizeConfig.heightMultiplier),

         SizedBox(
          height: 3.68*SizeConfig.heightMultiplier,
        ),

        //* report card widgets
        reportCard(Images.heartPNG, "Heart Rate", Color.fromARGB(255, 245, 208, 204), Colours.buttonColorRed,()=>Get.to(()=>HeartRateScreen())),
        SizedBox(height: 35,),
        reportCard(Images.bloodPressurePNG, "Blood Pressure", Color.fromARGB(255, 164, 238, 183), Colors.green,()=>Get.to(()=>BloodPressureReport())),
        SizedBox(height: 35,),
        reportCard(Images.BSugarPNG, "Blood Sugar", Color.fromARGB(255, 245, 208, 204), Colours.buttonColorRed,()=>Get.to(()=>BloodSugarReport())),
        SizedBox(height: 35,),
        reportCard(Images.weightPNG, "Weight Measure", Color.fromARGB(255, 223, 237, 131),Color.fromARGB(255, 162, 150, 39),()=>Get.to(()=>WeightReport())),
      ],
    );
  }
}