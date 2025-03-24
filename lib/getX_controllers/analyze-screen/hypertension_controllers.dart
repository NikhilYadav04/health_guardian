import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:health_guardian/widgets/analyze-screen/widgets_4.dart';
import 'package:http/http.dart' as http;

class HypertensionControllers extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Controller Initialized");
    // fetchData()
  }

  //* variables and bools
  RxString age = "28".obs;
  RxString gender = "Male".obs;
  RxDouble pressureLevelSystolic = 0.0.obs;
  RxDouble pressureLevelDiastolic = 0.0.obs;
  RxDouble pulseLevel = 0.0.obs;
  RxDouble heartLevel = 0.0.obs;

  RxBool isLoadingPrediction = false.obs;

  //* Cigs Per Day
  RxInt Cigs_Count = 0.obs;

  void change(int value) {
    Cigs_Count.value = value;
  }

  //* BP Meds Count
  RxInt Meds_Count = 0.obs;

  void change_Meds(int value) {
    Meds_Count.value = value;
  }

  //* BMI Count
  RxDouble BMI_Count = 0.0.obs;

  void change_BMI(double value) {
    BMI_Count.value = value;
  }

  //* Cholesterol Level
  RxDouble Cholesterol_Level = 0.0.obs;

  void change_Cholesterol(double value) {
    Cholesterol_Level.value = value;
  }

  //* calculate average values
  Future<void> calculateAverage(List<dynamic> data) async {
    double totalSystolic =
        data.fold(0, (sum, entry) => sum + entry['systolic']);
    double totalDiastolic =
        data.fold(0, (sum, entry) => sum + entry['diastolic']);
    double totalPulse = data.fold(0, (sum, entry) => sum + entry['pulse']);

    final count = data.length;
    pressureLevelSystolic.value = totalSystolic / count;
    pressureLevelDiastolic.value = totalDiastolic / count;
    pulseLevel.value = totalPulse / count;
  }

  //*calculate average heart
  Future<void> calculateAverageHeart(List<dynamic> data) async {
    double heartRate = data.fold(0, (sum, entry) => sum + entry['heart_level']);

    final count = data.length;
    heartLevel.value = heartRate / count;
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

    //* get pressure data
    CollectionReference collectionReference1 =
        FirebaseFirestore.instance.collection("pressure_data");
    QuerySnapshot querySnapshot1 =
        await collectionReference1.where('email', isEqualTo: email).get();
    DocumentSnapshot docs1 = await querySnapshot1.docs.first;

    if (docs1.exists) {
      final List<dynamic> data = docs1['bp_data'].toList();
      calculateAverage(data);
    } else {
      pressureLevelSystolic.value = 0.0;
      pressureLevelDiastolic.value = 0.0;
    }

    //* get heart data
    CollectionReference collectionReference2 =
        FirebaseFirestore.instance.collection("heart_data");
    QuerySnapshot querySnapshot2 =
        await collectionReference2.where('email', isEqualTo: email).get();
    DocumentSnapshot docs2 = await querySnapshot2.docs.first;

    if (docs2.exists) {
      List<dynamic> list = docs2['heart_data'].toList();
      calculateAverageHeart(list);
    } else {
      heartLevel.value = 0.0;
    }
  }

  //* call to model api for risk prediction
  Future<void> getPrediction(BuildContext context) async {
    try {
      isLoadingPrediction.value = true;

      final req_body = {
        'gender': gender.value == "Male" ? 1 : 0,
        'age': age.value,
        'cigsPerDay': Cigs_Count.value,
        'BPMeds': Meds_Count.value,
        'totChol': Cholesterol_Level.value,
        'sysBP': pressureLevelSystolic.value,
        'diaBP': pressureLevelDiastolic.value,
        'BMI': BMI_Count.value,
        'heartRate': heartLevel.value
      };

      final url =
          Uri.parse("https://hypertension-model-api.onrender.com/predict");

      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(req_body));

      final responseBody = jsonDecode(response.body);
      isLoadingPrediction.value = false;

      bool prediction = responseBody["prediction"] == 1 ? true : false;

      prediction
          ? Future.delayed(
              Duration(seconds: 1),
              () => Get.dialog(AlertDialog(
                    content: Container(
                      height: 200,
                      child: showPrediction(
                          Colours.buttonColorRed,
                          const Color.fromARGB(255, 240, 202, 199),
                          "Your risk for hypertension is high. Please consult a doctor as soon as possible for proper guidance.",
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
                          "Your risk for hypertension is low. Keep tracking your data regularly for proper health.",
                          Images.healthyImage,
                          250),
                    ),
                    backgroundColor: Colors.transparent,
                  )));
    } catch (e) {
      toastErrorSlide(context, "Error getting prediction");
      isLoadingPrediction.value = false;
    }
  }
}
