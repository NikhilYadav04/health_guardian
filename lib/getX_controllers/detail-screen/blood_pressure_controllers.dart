import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:intl/intl.dart';

bool isBetween(num value, num min, num max) {
  return value >= min && value <= max;
}

List<String> getColorStatus(num systolic, num diastolic) {
  String color;
  String status;

  if (systolic < 90 && diastolic < 60) {
    color = "Colors.blue";
    status = "Hypotension";
  } else if (isBetween(systolic, 90, 119) && isBetween(diastolic, 60, 79)) {
    color = "Colors.green";
    status = "Normal";
  } else if (isBetween(systolic, 120, 129) && isBetween(diastolic, 60, 79)) {
    color = "Colors.yellow.shade400";
    status = "Elevated";
  } else if (isBetween(systolic, 130, 139) && isBetween(diastolic, 80, 89)) {
    color = "Colors.orange";
    status = "HP = Stage 1";
  } else if (isBetween(systolic, 140, 180) && isBetween(diastolic, 90, 120)) {
    color = "Colors.orange.shade800";
    status = "HP - Stage 2";
  } else if (systolic > 180 && diastolic < 120) {
    color = "Colors.red";
    status = "Hypertensive";
  } else {
    color = "Colors.grey";
    status = "Not Specified";
  }

  return [color, status];
}

class BloodPressureControllers extends GetxController {
  PageController pageControllerDate = PageController();
  TextEditingController noteController = TextEditingController();

  RxBool isLoadingAdd = false.obs;

  //* clear the note controller
  void noteClear() {
    noteController.clear();
  }

  //* declare index
  RxInt pageIndex = 0.obs;
  RxInt pageIndexDate = 0.obs;

  //* Navigate to next page
  void navigatePage() {
    pageIndex.value = 1;
  }

  void navigatePageDate() {
    pageControllerDate.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
    if (pageIndexDate.value < 1) {
      pageIndexDate.value++;
    }
  }

  //* Navigate to previous page
  void previousPage() {
    pageIndex.value = 0;
  }

  void previousPageDate() {
    pageControllerDate.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
    if (pageIndexDate.value > 0) {
      pageIndexDate.value--;
    }
  }

  //* Double for Pressure Level Entered By User
  RxDouble pressureLevelSystolic = 60.0.obs;

  void changeLevelSystolic(double value) {
    pressureLevelSystolic.value = value;
  }

  RxDouble pressureLevelDiastolic = 60.0.obs;

  void changeLevelDiastolic(double value) {
    pressureLevelDiastolic.value = value;
  }

  RxInt pulseLevel = 50.obs;

  void changeLevelPulse(int value) {
    pulseLevel.value = value;
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

  //* add bp data to database
  Future<void> addBPData(BuildContext context) async {
    try {
      isLoadingAdd.value = true;

      final email = await FirebaseAuth.instance.currentUser!.email!;
      String date = DateFormat("dd MMM yyyy").format(DateTime.now());
      String time = DateFormat("hh:mm a").format(DateTime.now());

      String color = "Colors.grey";
      String status = "Not Specified";

      List<String> colorStatusList = getColorStatus(
          pressureLevelSystolic.value, pressureLevelDiastolic.value);
      color = colorStatusList[0];
      status = colorStatusList[1];

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("bp_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();
      DocumentSnapshot docs = await querySnapshot.docs.first;
      if (!docs.exists) {
        await collectionReference.add({
          "email": email,
          "bp_data": [
            {
              "date": "${date.toString()} : ${time.toString()}",
              "systolic": pressureLevelSystolic,
              "diastolic": pressureLevelDiastolic,
              "color": color,
              "state": State.value,
              "status": status,
              "note": noteController.text.toString()
            }
          ]
        });
      } else {
        final list = {
          "date": "${date.toString()} : ${time.toString()}",
          "systolic": pressureLevelSystolic,
          "diastolic": pressureLevelDiastolic,
          "color": color,
          "state": State.value,
          "status": status,
          "note": noteController.text.toString()
        };
        await docs.reference.update({
          "bp_data": FieldValue.arrayUnion([list])
        });
      }
      toastSuccessSlide(context, "Data added successfully");

      isLoadingAdd.value = false;
    } catch (e) {
      toastErrorSlide(context, "Error adding data");
      isLoadingAdd.value = false;
    }
  }
}

class EditBloodPressureDataControllers extends GetxController {
  //* variables and bools
  RxDouble pressureLevelSystolic = 0.0.obs;
  RxDouble pressureLevelDiastolic = 0.0.obs;
  RxDouble pulseLevel = 0.0.obs;

  RxBool isLoadingFetch = false.obs;
  RxBool isLoadingReport = false.obs;

  RxList bp_data_list = [].obs;
  RxList bp_graph_list = [].obs;

  //* to make sorted date wise lists of data
  Future<void> formatGraphList() async {
    bp_graph_list.clear();

    final int listCount = (bp_data_list.length / 6).ceil();

    for (int i = 0; i < listCount; i++) {
      int startIdx = i * 6;
      int endIdx = (startIdx + 6 < bp_data_list.length)
          ? startIdx + 6
          : bp_data_list.length;

      List<dynamic> sublist = bp_data_list.sublist(startIdx, endIdx);

      if (sublist.isNotEmpty) {
        bp_graph_list.add({
          "date": "${sublist.first['date']} - ${sublist.last['date']}",
          "systolic": sublist.map((e) => e['systolic']).toList(),
          "diastolic": sublist.map((e) => e['diastolic']).toList(),
        });
      }
    }
  }

  //* fetch bp data from database
  Future<List<dynamic>> fetchBPData(BuildContext context) async {
    try {
      isLoadingFetch.value = true;
      final email = await FirebaseAuth.instance.currentUser!.email!;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("bp_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      final List<dynamic> data = docs['bp_data'].toList();
      bp_data_list = docs['bp_data'].toList();

      calculateAverage(data);

      isLoadingFetch.value = false;

      return bp_data_list;
    } on FirebaseException catch (e) {
      isLoadingFetch.value = false;
      toastErrorSlide(context, "Error fetching data : ${e.toString()} ");
      return [];
    }
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

  //* generate report of data
  Future<void> generateReportBPDate(BuildContext context) async {
    try {
      if (bp_data_list.isEmpty) {
        toastErrorSlide(context, "No Data To Store");
        return;
      }
      isLoadingReport.value = true;

      Map<String, List<double>> systolicData = {};
      Map<String, List<double>> diastolicData = {};
      Map<String, List<double>> pulseData = {};

      final email = FirebaseAuth.instance.currentUser!.email!;
      final date = DateFormat('dd MMM yyyy').format(DateTime.now());

      //* Grouping data by date
      for (var data in bp_data_list) {
        String date = data["date"];
        double systolic = data["systolic"];
        double diastolic = data["diastolic"];
        double pulse = data['pulse'];

        //* Add systolic values
        if (!systolicData.containsKey(date)) {
          systolicData[date] = [];
        }
        systolicData[date]!.add(systolic);

        //* Add diastolic values
        if (!diastolicData.containsKey(date)) {
          diastolicData[date] = [];
        }
        diastolicData[date]!.add(diastolic);

        //* add pulse value
        if (!pulseData.containsKey(date)) {
          pulseData[date] = [];
        }
        pulseData[date]!.add(pulse);
      }

      //* Calculating average for each date
      Map<String, double> avgSystolic = {};
      Map<String, double> avgDiastolic = {};
      Map<String, double> avgPulse = {};

      //final colorStatusList = getColorStatus()

      systolicData.forEach((date, values) {
        avgSystolic[date] = values.reduce((a, b) => a + b) / values.length;
      });

      diastolicData.forEach((date, values) {
        avgDiastolic[date] = values.reduce((a, b) => a + b) / values.length;
      });

      pulseData.forEach((date, values) {
        avgPulse[date] = values.reduce((a, b) => a + b) / values.length;
      });

      final List<dynamic> bp_report = [];

      for (var key in avgSystolic.keys) {
        final colorStatusList =
            getColorStatus(avgSystolic[key]!, avgDiastolic[key]!);
        bp_report.add({
          "systolic": avgSystolic[key],
          "diastolic": avgDiastolic[key],
          "pulse": avgPulse[key],
          "color": colorStatusList[0],
          "status": colorStatusList[1]
        });
      }

      //* submit the report data to database
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("bp_report");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      if (!docs.exists) {
        await collectionReference.add({
          "email": email,
          "bp_report": [
            {"submitted_on": date, "bp_report": bp_report}
          ]
        });
      } else {
        final list = {"submitted_on": date, "bp_report": bp_report};

        await docs.reference.update({
          "bp_report": FieldValue.arrayUnion([list])
        });

        //* after report is stored clear the data
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection("bp_data");
        QuerySnapshot querySnapshot =
            await collectionReference.where('email', isEqualTo: email).get();
        DocumentSnapshot docs1 = querySnapshot.docs.first;

        await docs1.reference.update({
          'bp_data': FieldValue.delete(),
        });

        toastSuccessSlide(context, "Report Stored Successfully!");
      }

      isLoadingReport.value = false;
    } catch (e) {
      toastErrorSlide(context, "Cannot Store Report : ${e.toString()}");
      isLoadingReport.value = false;
    }
  }

  //* get report data
  Future<List<dynamic>> getReportData() async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("bp_report");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      final List<dynamic> list = docs['bp_report'];
      return list;
    } catch (e) {
      return [];
    }
  }
}
