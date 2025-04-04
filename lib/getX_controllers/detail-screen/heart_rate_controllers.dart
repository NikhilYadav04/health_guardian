import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:intl/intl.dart';

bool isBetween(num value, num min, num max) {
  return value >= min && value <= max;
}

List<String> getHeartColorStatus(num heartBPMRate) {
  String color;
  String status;

  if (heartBPMRate < 60) {
    color = "Colors.blue";
    status = "Slow";
  } else if (isBetween(heartBPMRate, 60, 100)) {
    color = "Colors.green";
    status = "Normal";
  } else if (heartBPMRate > 100) {
    color = "Colors.red";
    status = "Fast";
  } else {
    color = "Colors.grey";
    status = "Not Known";
  }

  return [color, status];
}

List<dynamic> getHeartColorPosition(num heartBPMRate) {
  Color color;
  double position;

  if (heartBPMRate < 60) {
    color = Colors.blue;
    position = 7.8125 * SizeConfig.widthMultiplier;
  } else if (isBetween(heartBPMRate, 60, 100)) {
    color = Colors.green;
    position = 40.178571 * SizeConfig.widthMultiplier;
  } else if (heartBPMRate > 100) {
    color = Colors.red;
    position = 69.19642 * SizeConfig.widthMultiplier;
  } else {
    color = Colors.grey;
    position = 7.8125 * SizeConfig.widthMultiplier;
  }

  return [color, position];
}

class HeartRateControllers extends GetxController {
  RxDouble heartRate = 0.0.obs;
  Random random = Random();
  RxBool isTwoDigit = false.obs;
  RxBool animationBool = false.obs;
  int animationCounter = 0;

  RxBool isLoadingAdd = false.obs;

  TextEditingController noteController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    heartBPMRate.value = 0;
  }

  void getHeartRate() {
    heartRate.value = 70.0 + random.nextInt(71);
    heartBPMRate.value = heartRate.value;
  }

  void reCheck() {
    animationBool.value = true;
    animationCounter++;
    update();
  }

  void onEnd() {
    animationBool.value = false;
    update();
  }

  //* color and position for arrow animation\
  Rx<Color> arrowColor = Colors.black.obs;
  RxDouble arrowPosition = 35.0.obs;

  //* Heart Rate Value entered by the user
  RxDouble heartBPMRate = 0.0.obs;

  void changeLevel(double value) {
    heartBPMRate.value = value;
    List<dynamic> list = getHeartColorPosition(heartBPMRate.value);
    arrowColor.value = list[0];
    arrowPosition.value = list[1];
    update();
  }

  //* for selecting state
  RxString State = "Default".obs;

  void DefaultSelect() {
    State.value = "Default";
  }

  void FastingSelect() {
    State.value = "Fasting";
  }

  void BeforeEatingSelect() {
    State.value = "Before Eating";
  }

  void AfterEating1h() {
    State.value = "After Eating (1h)";
  }

  void AfterEating2h() {
    State.value = "After Eating (2h)";
  }

  void AsleepSelect() {
    State.value = "Asleep";
  }

  void BeforeWorkoutSelect() {
    State.value = "Before Workout";
  }

  void AfterWorkoutSelect() {
    State.value = "After Workout";
  }

  //* store heart data to database
  Future<void> addHeartData(BuildContext context) async {
    try {
      isLoadingAdd.value = true;

      final email = FirebaseAuth.instance.currentUser!.email!;
      String date = DateFormat("dd MMM yyyy").format(DateTime.now());
      String time = DateFormat("hh:mm a").format(DateTime.now());

      List<String> colorStatusList = getHeartColorStatus(heartBPMRate.value);
      String color = colorStatusList[0];
      String status = colorStatusList[1];

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("heart_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();

      if (heartBPMRate.value >= 10 && heartBPMRate.value < 100) {
        heartBPMRate.value =
            double.parse((heartBPMRate.value).toStringAsFixed(2));
        isTwoDigit.value = true;
      }

      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add({
          "email": email,
          "heart_data": [
            {
              "date": "${date.toString()} : ${time.toString()}",
              "heart_level": heartBPMRate.value,
              "color": color,
              "status": status,
              "state": State.value,
              "isTwoDigit": isTwoDigit.value,
              "note": noteController.text.toString()
            }
          ]
        });
      } else {
        DocumentSnapshot docs = await querySnapshot.docs.first;
        final list = {
          "date": "${date.toString()} : ${time.toString()}",
          "heart_level": heartBPMRate.value,
          "color": color,
          "status": status,
          "state": State.value,
          "isTwoDigit": isTwoDigit.value,
          "note": noteController.text.toString()
        };

        await docs.reference.update({
          "heart_data": FieldValue.arrayUnion([list])
        });
      }

      toastSuccessSlide(context, "Data Stored Successfully");

      isLoadingAdd.value = false;
    } catch (e) {
      toastErrorSlide(context, "Error adding data");
      isLoadingAdd.value = false;
    }
  }
}

class EditHeartRateDataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchHeartData();
  }

  RxList heart_data_list = [].obs;
  RxList heart_graph_list = [].obs;
  RxList heart_report_list = [].obs;
  RxDouble AvgHearTLevel = 0.0.obs;

  RxBool isLoadingReport = false.obs;

  //* generate report of heart data
  Future<void> generateHeartReport(BuildContext context) async {
    try {
      if (heart_data_list.isEmpty) {
        toastErrorSlide(context, "No Data To Store");
        return;
      }

      isLoadingReport.value = true;

      Map<String, List<double>> heartBPMData = {};

      final email = FirebaseAuth.instance.currentUser!.email!;
      final date = DateFormat('dd MMM yyyy').format(DateTime.now());

      for (var data in heart_data_list) {
        String date = (data["date"] as String).split(":")[0];
        double heartLevel = (data["heart_level"] as num).toDouble();

        //* Add sygar values
        if (!heartBPMData.containsKey(date)) {
          heartBPMData[date] = [];
        }
        heartBPMData[date]!.add(heartLevel);
      }

      //* Calculating average for each date
      Map<String, double> avgHeartLevel = {};

      heartBPMData.forEach((date, values) {
        avgHeartLevel[date] = values.reduce((a, b) => a + b) / values.length;
      });

      final List<dynamic> heart_report = [];

      for (var key in avgHeartLevel.keys) {
        final colorStatusList = getHeartColorStatus(avgHeartLevel[key]!);
        heart_report.add({
          "heart_level": avgHeartLevel[key],
          "date": key,
          "color": colorStatusList[0],
          "status": colorStatusList[1]
        });
      }

      //* submit report data to database
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("heart_report");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add({
          "email": email,
          "heart_report": [
            {"submitted_on": date, "heart_report": heart_report}
          ]
        });
      } else {
        DocumentSnapshot docs = querySnapshot.docs.first;
        final list = {"submitted_on": date, "heart_report": heart_report};

        await docs.reference.update({
          "heart_report": FieldValue.arrayUnion([list])
        });
      }

      //* Clear heart_data if exists
      CollectionReference heartDataCollection =
          FirebaseFirestore.instance.collection("heart_data");
      QuerySnapshot heartDataSnapshot =
          await heartDataCollection.where('email', isEqualTo: email).get();

      if (heartDataSnapshot.docs.isNotEmpty) {
        DocumentSnapshot docs1 = heartDataSnapshot.docs.first;
        await docs1.reference.update({
          'heart_data': FieldValue.delete(),
        });
      }
      toastSuccessSlide(context, "Report Generate Successfully!");

      isLoadingReport.value = false;
    } catch (e) {
      toastErrorSlide(context, e.toString());
      isLoadingReport.value = false;
    }
  }

  //* fetch heart data stream from database
  Stream<List<dynamic>> fetchHeartData() async* {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("heart_data");

      yield* collectionReference
          .where('email', isEqualTo: email)
          .snapshots()
          .map((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot docs = querySnapshot.docs.first;
          List<dynamic> list = docs['heart_data'].toList();

          double heart_sum =
              (list.fold(0, (sum, entry) => sum + entry['heart_level']));
          AvgHearTLevel.value =
              double.parse((heart_sum / list.length).toStringAsFixed(2));
          heart_data_list.value = list;
          return list;
        } else {
          return [];
        }
      });
    } catch (e) {
      yield [];
    }
  }

  //* get report of heart data
  Stream<List<dynamic>> getHeartReportData() {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("heart_report");

      return collectionReference
          .where('email', isEqualTo: email)
          .snapshots()
          .map((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot docs = querySnapshot.docs.first;
          heart_report_list.value = docs['heart_report'];
          return docs['heart_report'] as List<dynamic>;
        } else {
          return [];
        }
      });
    } catch (e) {
      return Stream.value([]);
    }
  }
}
