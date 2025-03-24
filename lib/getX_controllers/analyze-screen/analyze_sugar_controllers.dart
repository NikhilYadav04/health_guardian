import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:health_guardian/getX_controllers/detail-screen/blood_pressure_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:health_guardian/widgets/analyze-screen/widgets_4.dart';
import 'package:http/http.dart' as http;

class AnalyzeSugarControllers extends GetxController {
  //* variables and bools
  RxString age = "28".obs;
  RxString gender = "Male".obs;
  RxBool isLoadingPrediction = false.obs;

  //* functions to process data for model
  num processAge(num age) {
    if (age < 40) {
      return 0;
    } else if (isBetween(age, 40, 49)) {
      return 1;
    } else if (isBetween(age, 50, 59)) {
      return 2;
    } else {
      return 3;
    }
  }

  num processPhysicallyActive(String status) {
    if (status == "one hr or more") {
      return 0;
    } else if (status == "more than half an hr") {
      return 1;
    } else if (status == "less than half an hr") {
      return 2;
    } else {
      return 3;
    }
  }

  num processJunkFood(String status) {
    if (status == "occasionally") {
      return 0;
    } else if (status == "often") {
      return 1;
    } else if (status == "very often") {
      return 2;
    } else {
      return 3;
    }
  }

  num processBPLevel(String status) {
    if (status == "low") {
      return 0;
    } else if (status == "normal") {
      return 1;
    } else {
      return 2;
    }
  }

  num processUrinationFreq(String status) {
    if (status == "not much") {
      return 0;
    } else {
      return 1;
    }
  }

  num processStress(String status) {
    if (status == "not at all") {
      return 0;
    } else if (status == "sometimes") {
      return 1;
    } else if (status == "very often") {
      return 2;
    } else {
      return 3;
    }
  }

  //* Family Diabetes
  RxString FD_State = "No".obs;

  void FD_SetState(String value) {
    FD_State.value = value;
  }

  //* High BP
  RxString HB_State = "Yes".obs;

  void HB_SetState(String value) {
    HB_State.value = value;
  }

  //* Physically Active
  RxString PA_State = "one hr or more".obs;

  void PA_SetState(String value) {
    PA_State.value = value;
  }

  //* BMI
  RxString BMI_State = "Yes".obs;

  void BMI_SetState(String value) {
    BMI_State.value = value;
  }

  //* BMI Value
  RxDouble BMI_Count = 0.0.obs;

  void change_BMI(double value) {
    BMI_Count.value = value;
  }

  //* Smoking
  RxString Smoking_State = "No".obs;

  void Smoking_SetState(String value) {
    Smoking_State.value = value;
  }

  //* Alchohol
  RxString Alchohol_State = "No".obs;

  void Alchohol_SetState(String value) {
    Alchohol_State.value = value;
  }

  //* Sleep
  RxDouble Sleep_Hours = 12.0.obs;

  void changeLevel(double newLevel) {
    Sleep_Hours.value = newLevel;
  }

  //* Sound Sleep
  RxString SoundSleep_State = "No".obs;

  void SoundSleep_SetState(String value) {
    SoundSleep_State.value = value;
  }

  //* Regular Medicine
  RxString RM_State = "No".obs;

  void RM_SetState(String value) {
    RM_State.value = value;
  }

  //* JunkFood
  RxString JF_State = "Often".obs;

  void JF_SetState(String value) {
    JF_State.value = value;
  }

  //* Stress
  RxString Stress_State = "Not At All".obs;

  void Stress_SetState(String value) {
    Stress_State.value = value;
  }

  //*  BP Level
  RxString BP_level_State = "Low".obs;

  void BP_level_SetState(String value) {
    BP_level_State.value = value;
  }

  //* Pregnancies Count
  RxInt P_Count = 0.obs;

  void P_Count_SetState(int value) {
    P_Count.value = value;
  }

  //* P_Diabetes
  RxString P_D_State = "Yes".obs;

  void P_D_State_SetState(String value) {
    P_D_State.value = value;
  }

  //* Urination_Freq
  RxString UF_State = "Not Much".obs;

  void UF_SetState(String value) {
    UF_State.value = value;
  }

  //* fetch pressure and heart rate data
  Future<void> fetchData() async {
    //* profile details
    final email = await FirebaseAuth.instance.currentUser!.email!;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("profile_details");
    QuerySnapshot querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();
    DocumentSnapshot docs = await querySnapshot.docs.first;

    age.value = docs["age"];
    gender.value = docs["gender"];
  }

  // //* get prediction from model api
  Future<void> getPrediction(BuildContext context) async {
    try {
      isLoadingPrediction.value = true;

      final req_body = {
        "Age": processAge(
          int.parse(age.value),
        ),
        "Gender": gender.value == "Male" ? 1 : 0,
        "Family_Diabetes": FD_State.value == "Yes" ? 1 : 0,
        "highBP": HB_State.value == "Yes" ? 1 : 0,
        "PhysicallyActive": processPhysicallyActive(PA_State.value),
        "BMI": BMI_Count.value,
        "Smoking": Smoking_State.value == "Yes" ? 1 : 0,
        "Alcohol": Alchohol_State.value == "Yes" ? 1 : 0,
        "Sleep": Sleep_Hours.value,
        "SoundSleep": SoundSleep_State.value == "Yes" ? 1 : 0,
        "RegularMedicine": RM_State.value == "Yes" ? 1 : 0,
        "JunkFood": processJunkFood(JF_State.value),
        "Stress": processStress(Stress_State.value),
        "BPLevel": processBPLevel(BP_level_State.value),
        "Pregancies": P_Count.value,
        "Pdiabetes": P_D_State.value == "Yes" ? 1 : 0,
        "UriationFreq": processUrinationFreq(UF_State.value)
      };

      final url =
          Uri.parse("https://diabetes-model-api-3wmk.onrender.com/predict");
      final response = await http.post(url,
          body: jsonEncode(req_body),
          headers: {"Content-Type": "application/json"});

      final responseBody = jsonDecode(response.body);
      isLoadingPrediction.value = false;

      bool prediction = responseBody["prediction"] == 1 ? true : false;

      isLoadingPrediction.value = false;

      prediction
          ? Future.delayed(
              Duration(seconds: 1),
              () => Get.dialog(AlertDialog(
                    content: Container(
                      height: 200,
                      child: showPrediction(
                          Colours.buttonColorRed,
                          const Color.fromARGB(255, 240, 202, 199),
                          "Your risk for diabetes is high. Please consult a doctor as soon as possible for proper guidance.",
                          Images.riskImage,
                          200),
                    ),
                    backgroundColor: Colors.transparent,
                  )))
          : Future.delayed(
              Duration(seconds: 1),
              () => Get.dialog(AlertDialog(
                    content: Container(
                      height: 200,
                      child: showPrediction(
                          Colors.green,
                          const Color.fromARGB(255, 184, 242, 186),
                          "Your risk for diabetes is low. Keep tracking your data regularly for proper health.",
                          Images.healthyImage,
                          200),
                    ),
                    backgroundColor: Colors.transparent,
                  )));
    } catch (e) {
      isLoadingPrediction.value = false;
      toastErrorSlide(context, "Error getting prediction");
    }
  }
}
