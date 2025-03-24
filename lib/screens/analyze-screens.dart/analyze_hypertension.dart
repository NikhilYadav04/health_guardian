import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/analyze-screen/hypertension_controllers.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/analyze-hypertension/widgets_1.dart';
import 'package:health_guardian/widgets/analyze-screen/widgets_1.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:lottie/lottie.dart';

class AnalyzeHypertension extends StatelessWidget {
  final HypertensionControllers controller = Get.put(HypertensionControllers());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //* bottom text
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.84269 * SizeConfig.heightMultiplier,
                horizontal: 1.5 * SizeConfig.widthMultiplier),
            child: Text(
              "If any pressure or heart data is zero that means your stored data is empty, you have to input your health data.",
              style: TextStyle(
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontFamily: "Poppins-Med"),
            )),
      ],

      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      appBar: appBAnalyze(() {
        Get.back();
      }, () {}, Images.BloodPressureMeasureIcon2),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.67 * SizeConfig.widthMultiplier,
              vertical: 1.05 * SizeConfig.heightMultiplier),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 1.58 * SizeConfig.heightMultiplier,
              ),

              //* title text
              descTextAnalyze("Complete the Health Form Below, Get",
                  2.6 * SizeConfig.heightMultiplier),
              descTextAnalyze("Your Hypertension Risk Instantly!",
                  2.6 * SizeConfig.heightMultiplier),

              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),

              //* form fields
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnalyzeCard("Age", Icons.person, controller.age.value,
                        45.75 * SizeConfig.widthMultiplier),
                    AnalyzeCard("Gender", Icons.male, controller.gender.value,
                        45.75 * SizeConfig.widthMultiplier),
                  ],
                ),
              ),
              SizedBox(
                height: 2.10 * SizeConfig.heightMultiplier,
              ),

              //* cigsPerDay and BPMeds
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CigsCard("Cigarette Count", Icons.smoke_free, "10",
                      49.10 * SizeConfig.widthMultiplier, controller),
                  MedsCard("BP Meds", Icons.medication, "10",
                      42.41 * SizeConfig.widthMultiplier, controller)
                ],
              ),

              SizedBox(
                height: 2.10 * SizeConfig.heightMultiplier,
              ),

              //* Systolic BP and Diastolic BP
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnalyzeCard(
                      "Systolic BP",
                      Icons.bloodtype,
                      "${controller.pressureLevelSystolic.value.toString()} pa",
                      45.75 * SizeConfig.widthMultiplier,
                    ),
                    AnalyzeCard(
                        "Diastolic BP",
                        Icons.bloodtype,
                        "${controller.pressureLevelDiastolic.value.toString()} pa",
                        45.75 * SizeConfig.widthMultiplier),
                  ],
                ),
              ),
              SizedBox(
                height: 2.10 * SizeConfig.heightMultiplier,
              ),

              //* BMI and Heart Rate
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BMICard("BMI Index", Icons.bloodtype, "12.5 BMI",
                      45.75 * SizeConfig.widthMultiplier, controller),
                  Obx(() => AnalyzeCard(
                      "Heart Rate",
                      Icons.monitor_heart_sharp,
                      "${controller.heartLevel.value} bpm",
                      45.75 * SizeConfig.widthMultiplier)),
                ],
              ),
              SizedBox(
                height: 2.10 * SizeConfig.heightMultiplier,
              ),

              //* Total Cholesterol
              Align(
                alignment: Alignment.bottomCenter,
                child: CholesterolCard(
                    "Cholesterol Level",
                    Icons.health_and_safety_outlined,
                    "120 mg/dL",
                    52.45 * SizeConfig.widthMultiplier,
                    controller),
              ),

              SizedBox(
                height: 4.21 * SizeConfig.heightMultiplier,
              ),

              //* Analyze Button
              authButton("Predict", () async {
                Get.dialog(AlertDialog(
                  backgroundColor: Colors.transparent,
                  actions: [
                    Center(
                      child: Lottie.asset("assets/animations/ai_loader.json"),
                    )
                  ],
                ));

                await controller.getPrediction(context);

                if (Get.isDialogOpen == true) {
                  Navigator.of(context).pop();
                }
              }),
              SizedBox(
                height: 1.58 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
