import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/analyze-screen/analyze_sugar_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/analyze-screen/widgets_1.dart';
import 'package:health_guardian/widgets/analyze-screen/widgets_2.dart';
import 'package:health_guardian/widgets/analyze-screen/widgets_3.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:lottie/lottie.dart';

class AnalyzeSugarScreen extends StatelessWidget {
  final AnalyzeSugarControllers controller = Get.put(AnalyzeSugarControllers());

  Color getBackgroundColor(bool condition) =>
      condition ? Colours.buttonColorRed : Color.fromARGB(255, 246, 240, 241);

  Color getTextColor(bool condition) => condition ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 241, 241),
        appBar: appBAnalyze(() {
          Get.back();
        }, () {}, Images.DiabetesIcon),
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
                descTextAnalyze(
                    "Complete the Health Form Below,Get\nYour Diabetes Stage Risk Instantly!",
                    2.50 * SizeConfig.heightMultiplier),

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
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* family diabetes and high BP cards
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Double_Parameter_Card(
                          "Family Diabetes",
                          controller.FD_State.value,
                          () => controller.FD_SetState("Yes"),
                          () => controller.FD_SetState("No"),
                          "Yes",
                          "No",
                          controller.FD_State.value == "Yes",
                          controller.FD_State.value == "No",
                          47.10 * SizeConfig.widthMultiplier,
                          Icons.bloodtype),
                      Double_Parameter_Card(
                          "High BP",
                          controller.HB_State.value,
                          () => controller.HB_SetState("Yes"),
                          () => controller.HB_SetState("No"),
                          "Yes",
                          "No",
                          controller.HB_State.value == "Yes",
                          controller.HB_State.value == "No",
                          21.3 * SizeConfig.heightMultiplier,
                          Icons.bloodtype),
                    ],
                  );
                }),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* personal diabetes and physical activity cards
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Double_Parameter_Card(
                          "P Diabetes",
                          controller.P_D_State.value,
                          () => controller.P_D_State_SetState("Yes"),
                          () => controller.P_D_State_SetState("No"),
                          "Yes",
                          "No",
                          controller.P_D_State.value == "Yes",
                          controller.P_D_State.value == "No",
                          42.75 * SizeConfig.widthMultiplier,
                          Icons.bloodtype),
                      Four_Parameter_Card(
                          "Physically Active",
                          controller.PA_State.value,
                          () => controller.PA_SetState('One Hr or more'),
                          () => controller.PA_SetState('More than half an hr'),
                          () => controller.PA_SetState('Less than half an hr'),
                          () => controller.PA_SetState('None'),
                          'One Hr or more',
                          'More than half an hr',
                          'Less than half an hr',
                          'None',
                          48.7 * SizeConfig.widthMultiplier,
                          Icons.star_border_outlined),
                    ],
                  );
                }),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* smoking and alcohol cards
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Double_Parameter_Card(
                          "Smoking",
                          controller.Smoking_State.value,
                          () => controller.Smoking_SetState("Yes"),
                          () => controller.Smoking_SetState("No"),
                          "Yes",
                          "No",
                          controller.Smoking_State.value == "Yes",
                          controller.Smoking_State.value == "No",
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.smoke_free_outlined),
                      Double_Parameter_Card(
                          "Alcohol",
                          controller.Alchohol_State.value,
                          () => controller.Alchohol_SetState("Yes"),
                          () => controller.Alchohol_SetState("No"),
                          "Yes",
                          "No",
                          controller.Alchohol_State.value == "Yes",
                          controller.Alchohol_State.value == "No",
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.no_drinks_outlined),
                    ],
                  );
                }),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* BMI and Sleep cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BMICardDiabetesReport("BMI", Icons.person, "28.3",
                        45.75 * SizeConfig.widthMultiplier, controller),
                    SleepCard("Sleep", Icons.night_shelter_outlined, "10 Hours",
                        45.75 * SizeConfig.widthMultiplier, controller),
                  ],
                ),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* Sound sleep and pregnancies cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Double_Parameter_Card(
                          "Sound Sleep",
                          controller.SoundSleep_State.value,
                          () => controller.SoundSleep_SetState("Yes"),
                          () => controller.SoundSleep_SetState("No"),
                          "Yes",
                          "No",
                          controller.SoundSleep_State.value == "Yes",
                          controller.SoundSleep_State.value == "No",
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.night_shelter_rounded),
                    ),
                    PregnancyCard("Pregnancies", Icons.pregnant_woman, "2",
                        45.75 * SizeConfig.widthMultiplier, controller),
                  ],
                ),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* Junk food and stress cards
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Four_Parameter_Card(
                          "Junk Food",
                          controller.JF_State.value,
                          () => controller.JF_SetState("Occasionally"),
                          () => controller.JF_SetState("Often"),
                          () => controller.JF_SetState("Very Often"),
                          () => controller.JF_SetState("Always"),
                          "Occasionally",
                          "Often",
                          "Very Often",
                          "Always",
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.fastfood),
                      Four_Parameter_Card(
                          "Stress",
                          controller.Stress_State.value,
                          () => controller.Stress_SetState('Not at all'),
                          () => controller.Stress_SetState('Sometimes'),
                          () => controller.Stress_SetState('Very Often'),
                          () => controller.Stress_SetState('Always'),
                          'Not at all',
                          'Sometimes',
                          'Very Often',
                          'Always',
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.self_improvement),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),

                //* BP Level And Urination freq
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      triple_Parameter_Card(
                          "BP Level",
                          controller.BP_level_State.value,
                          () => controller.BP_level_SetState("Low"),
                          () => controller.BP_level_SetState("Normal"),
                          () => controller.BP_level_SetState("High"),
                          "Low",
                          "Normal",
                          "High",
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.bloodtype_outlined),
                      Double_Parameter_Card(
                          "Urination Freq",
                          controller.UF_State.value,
                          () => controller.UF_SetState('Not Much'),
                          () => controller.UF_SetState('Quite Often'),
                          'Not Much',
                          'Quite Often',
                          controller.UF_State.value == 'Not Much',
                          controller.UF_State.value == 'Quite Often',
                          45.75 * SizeConfig.widthMultiplier,
                          Icons.star_border_outlined),
                    ],
                  ),
                ),

                //* Regular Medicine
                SizedBox(
                  height: 1.58 * SizeConfig.heightMultiplier,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(
                    () => Double_Parameter_Card(
                        "Regular Medicine",
                        controller.RM_State.value,
                        () => controller.RM_SetState("Yes"),
                        () => controller.RM_SetState("No"),
                        "Yes",
                        "No",
                        controller.RM_State.value == "Yes",
                        controller.RM_State.value == "No",
                        52 * SizeConfig.widthMultiplier,
                        Icons.medication),
                  ),
                ),

                //* Analyze button
                SizedBox(
                  height: 5.79 * SizeConfig.heightMultiplier,
                ),
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
      ),
    );
  }
}
