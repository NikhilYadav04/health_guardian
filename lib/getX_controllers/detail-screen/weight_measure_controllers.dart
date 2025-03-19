import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:intl/intl.dart';

bool isBetween(num value, num min, num max) {
  return value >= min && value <= max;
}

List<String> getWeightColorStatus(double weightLevel) {
  String color;
  String status;

  if (weightLevel < 40) {
    color = "Colors.blue";
    status = "Very Severely Underweight";
  } else if (isBetween(weightLevel, 40, 45)) {
    color = "Colors.blue.shade300";
    status = "Severely Underweight";
  } else if (isBetween(weightLevel, 46, 54)) {
    color = "Colors.blue.shade200";
    status = "Underweight";
  } else if (isBetween(weightLevel, 55, 70)) {
    color = "Colors.green";
    status = "Normal";
  } else if (isBetween(weightLevel, 71, 85)) {
    color = "Colors.yellow";
    status = "Overweight";
  } else if (isBetween(weightLevel, 86, 100)) {
    color = "Colors.yellow.shade800";
    status = "Obese Class I";
  } else if (isBetween(weightLevel, 101, 120)) {
    color = "Colors.orange";
    status = "Obese Class II";
  } else if (weightLevel > 120) {
    color = "Colors.red";
    status = "Obese Class III";
  } else {
    color = "Colors.grey";
    status = "Not Known";
  }

  return [color, status];
}

class WeightMeasureControllers extends GetxController {
  //*initialize the controllers
  PageController pageController = PageController();
  TextEditingController noteController = TextEditingController();

  //* clear the note controller
  void noteClear() {
    noteController.clear();
  }

  RxBool isLoadingAdd = false.obs;

  //* declare index
  RxInt pageIndex = 0.obs;
  RxInt pageIndexDate = 0.obs;

  //* Navigate to next page
  void navigatePage() {
    pageIndex.value = 1;
  }

  void navigatePageDate() {
    pageController.nextPage(
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
    pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
    if (pageIndexDate.value > 0) {
      pageIndexDate.value--;
    }
  }

  //* Double for Weight And Height Entered By User
  RxDouble weightValue = 0.0.obs;

  void changeLevel(double value) {
    weightValue.value = value;
  }

  RxDouble heightValue = 0.0.obs;

  void changeLevelHeight(double value) {
    heightValue.value = value;
  }

  //* store weight data in database
  Future<void> addWeightData(BuildContext context) async {
    try {
      isLoadingAdd.value = true;
      final email = FirebaseAuth.instance.currentUser!.email!;
      String date = DateFormat("dd MMM yyyy").format(DateTime.now());
      String time = DateFormat("hh:mm a").format(DateTime.now());

      List<String> colorStatusList = getWeightColorStatus(weightValue.value);
      String color = colorStatusList[0];
      String status = colorStatusList[1];

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("weight_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();
      DocumentSnapshot docs = await querySnapshot.docs.first;

      if (!docs.exists) {
        await collectionReference.add({
          "email": email,
          "weight_data": [
            {
              "date": "${date.toString()} : ${time.toString()}",
              "weight_level": weightValue.value,
              "color": color,
              "status": status,
              "note": noteController.text.toString()
            }
          ]
        });
      } else {
        final list = {
          "date": "${date.toString()} : ${time.toString()}",
          "weight_level": weightValue.value,
          "color": color,
          "status": status,
          "note": noteController.text.toString()
        };

        await docs.reference.update({
          "weight_data": FieldValue.arrayUnion([list])
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

class EditWeightMeasureDataController extends GetxController {
  //* variables and bools
  RxDouble AvgWeightLevel = 0.0.obs;
  RxDouble MaxWeightLevel = 0.0.obs;
  RxDouble MinWeightLevel = 0.0.obs;

  RxList weight_data_list = [].obs;
  RxList weight_graph_list = [].obs;

  RxBool isLoadingReport = false.obs;

  //* format weight data for graph
  Future<void> formatWeightData() async {
    try {
      weight_graph_list.clear();

      final int listCount = (weight_data_list.length / 6).ceil();

      for (int i = 0; i < listCount; i++) {
        int startIdx = i * 6;
        int endIdx = (startIdx + 6 < weight_data_list.length)
            ? startIdx + 6
            : weight_data_list.length;

        List<dynamic> sublist = weight_data_list.sublist(startIdx, endIdx);

        if (sublist.isNotEmpty) {
          weight_graph_list.add({
            "date": "${sublist.first['date']} - ${sublist.last['date']}",
            "weight_level": sublist.map((e) => e['weight_level']).toList()
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //* fetch weight data from database
  Future<List<dynamic>> fetchWeightData(BuildContext context) async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("weight_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      List<dynamic> list = docs['weight_data'].toList();
      weight_data_list.value = list;

      double weight_sum =
          (list.fold(0, (sum, entry) => sum + entry['weight_level']));
      AvgWeightLevel.value = weight_sum / list.length;

      MaxWeightLevel.value = list.reduce((a, b) =>
          a['weight_level'] > b['weight_level'] ? a : b)['weight_level'];
      MinWeightLevel.value = list.reduce((a, b) =>
          a['weight_level'] < b['weight_level'] ? a : b)['weight_level'];

      return weight_data_list;
    } catch (e) {
      toastErrorSlide(context, "Error fetching data");
      print(e.toString());
      return [];
    }
  }

  //* generate report of weight data
  Future<void> generateWeightDataReport(BuildContext context) async {
    try {
      if (weight_data_list.isEmpty) {
        toastErrorSlide(context, "No Data To Store");
        return;
      }
      isLoadingReport.value = true;

      Map<String, List<double>> weightLevelData = {};

      final email = FirebaseAuth.instance.currentUser!.email!;
      final date = DateFormat('dd MMM yyyy').format(DateTime.now());

      for (var data in weight_data_list) {
        String date = data["date"];
        double weightLevel = data["weight_level"];

        //* Add weight values
        if (!weightLevelData.containsKey(date)) {
          weightLevelData[date] = [];
        }
        weightLevelData[date]!.add(weightLevel);
      }

      //* Calculating average for each date
      Map<String, double> avgWeightLevel = {};

      weightLevelData.forEach((date, values) {
        avgWeightLevel[date] = values.reduce((a, b) => a + b) / values.length;
      });

      final List<dynamic> weight_report = [];

      for (var key in avgWeightLevel.keys) {
        final colorStatusList = getWeightColorStatus(avgWeightLevel[key]!);
        weight_report.add({
          "weight_level": avgWeightLevel[key],
          "color": colorStatusList[0],
          "status": colorStatusList[1]
        });
      }

      //* submit report data to database
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("weight_report");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      if (!docs.exists) {
        await collectionReference.add({
          "email": email,
          "weight_report": [
            {"submitted_on": date, "weight_report": weight_report}
          ]
        });
      } else {
        final list = {"submitted_on": date, "weight_report": weight_report};

        await docs.reference.update({
          "weight_report": FieldValue.arrayUnion([list])
        });

        //* after report is stored clear the data
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection("weight_data");
        QuerySnapshot querySnapshot =
            await collectionReference.where('email', isEqualTo: email).get();
        DocumentSnapshot docs1 = querySnapshot.docs.first;
        await docs1.reference.update({
          'weight_data': FieldValue.delete(),
        });

        toastSuccessSlide(context, "Report Stored Successfully!");

        isLoadingReport.value = false;
      }
    } catch (e) {
      toastErrorSlide(context, "Cannot Store Report : ${e.toString()}");
      isLoadingReport.value = false;
    }
  }

  //* get report of weight data
  Future<List<dynamic>> getReportData() async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("weight_report");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      final List<dynamic> list = docs['weight_report'];
      return list;
    } catch (e) {
      return [];
    }
  }
}
