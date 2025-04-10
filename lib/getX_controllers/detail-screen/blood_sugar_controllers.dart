import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:health_guardian/services/workManager.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:intl/intl.dart';

bool isBetween(num value, num min, num max) {
  return value >= min && value <= max;
}

List<String> getSugarColorSatus(double sugarLevel) {
  String color;
  String status;

  if (sugarLevel < 72) {
    color = "Colors.blue";
    status = "Low";
  } else if (isBetween(sugarLevel, 72, 99)) {
    color = "Colors.green";
    status = "Normal";
  } else if (isBetween(sugarLevel, 99, 126)) {
    color = "Colors.orange";
    status = "Pre-Diabetes";
  } else if (sugarLevel >= 126) {
    color = "Colors.red";
    status = "Diabetes";
  } else {
    color = "Colors.grey";
    status = "Mot Known";
  }

  return [color, status];
}

List<dynamic> getSugarColorPosition(double sugarLevel) {
  Color color;
  double position;

  if (sugarLevel < 72) {
    color = Colors.blue;
    position = 5.580357 * SizeConfig.widthMultiplier;
  } else if (isBetween(sugarLevel, 72, 99)) {
    color = Colors.green;
    position = 27.90178 * SizeConfig.widthMultiplier;
  } else if (isBetween(sugarLevel, 99, 126)) {
    color = Colors.orange;
    position = 51.3392 * SizeConfig.widthMultiplier;
  } else if (sugarLevel >= 126) {
    color = Colors.red;
    position = 74.55357 * SizeConfig.widthMultiplier;
  } else {
    color = Colors.black;
    position = 5.580357 * SizeConfig.widthMultiplier;
  }

  return [color, position];
}

class BloodSugarControllers extends GetxController {
  //* initialize the controller
  PageController pageController = PageController();
  PageController pageControllerDate = PageController();
  TextEditingController noteController = TextEditingController();

  //* clear the note controller
  void noteClear() {
    noteController.clear();
  }

  //* color and position for arrow animation
  Rx<Color> arrowColor = Colors.blue.obs;
  RxDouble arrowPosition = 10.0.obs;

  RxBool isLoadingAdd = false.obs;
  RxBool isTwoDigit = false.obs;

  //* declare index
  RxInt pageIndex = 0.obs;
  RxInt pageIndexDate = 0.obs;
  RxInt dateIndex = 0.obs;

  //* function to change index
  void changeIndex(index) {
    pageIndex.value = index;
    print(pageIndex);
  }

  //* Navigate to next page
  void navigatePage() {
    pageIndex.value = 1;
  }

  void navigatePageDate(num index) {
    if (pageIndexDate.value < (index - 1)) {
      pageControllerDate.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
      pageIndexDate.value++;
      dateIndex.value++;
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
      dateIndex.value--;
    }
  }

  //* Double for Sugar Level Entered By User
  RxDouble sugarLevel = 0.0.obs;

  void changeLevel(double value) {
    sugarLevel.value = value;
    List<dynamic> list = getSugarColorPosition(sugarLevel.value);
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

  //* store sugar data in database
  Future<void> addSugarData(BuildContext context) async {
    try {
      isLoadingAdd.value = true;
      final email = FirebaseAuth.instance.currentUser!.email!;
      String date = DateFormat("dd MMM yyyy").format(DateTime.now());
      String time = DateFormat("hh:mm a").format(DateTime.now());

      List<String> colorStatusList = getSugarColorSatus(sugarLevel.value);
      String color = colorStatusList[0];
      String status = colorStatusList[1];

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("sugar_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();

      if (sugarLevel.value >= 10 && sugarLevel.value < 100) {
        sugarLevel.value = double.parse((sugarLevel.value).toStringAsFixed(2));
        isTwoDigit.value = true;
      }

      if (sugarLevel.value == 0.0) {
        toastErrorSlide(context, "Enter A Valid Level");
        isLoadingAdd.value =false;
        return;
      }

      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add({
          "email": email,
          "sugar_data": [
            {
              "date": "${date.toString()} : ${time.toString()}",
              "sugar_level": sugarLevel.value,
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
          "sugar_level": sugarLevel.value,
          "color": color,
          "status": status,
          "state": State.value,
          "isTwoDigit": isTwoDigit.value,
          "note": noteController.text.toString()
        };

        await docs.reference.update({
          "sugar_data": FieldValue.arrayUnion([list])
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

class EditBloodSugarDataControllers extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    isLoadingGraph.value = true;
    print("Controller Initialized!");
    await fetchSugarData();
    await formatSugarData();
    logger.d(sugar_graph_list);
    isLoadingGraph.value = false;
  }

  //* variables and bools
  RxDouble AvgSugarLevel = 0.0.obs;
  RxDouble MaxSugarLevel = 0.0.obs;
  RxDouble MinSugarLevel = 0.0.obs;

  RxList sugar_data_list = [].obs;
  RxList sugar_graph_list = [].obs;
  RxList sugar_report_list = [].obs;
  RxList sugar_report_date = [].obs;

  RxBool isLoadingReport = false.obs;
  RxBool isLoadingGraph = false.obs;

  //* format sugar data for graph
  Future<void> formatSugarData() async {
    try {
      sugar_graph_list.clear();

      final int listCount = (sugar_data_list.length / 6).ceil();

      for (int i = 0; i < listCount; i++) {
        int startIdx = i * 6;
        int endIdx = (startIdx + 6 < sugar_data_list.length)
            ? startIdx + 6
            : sugar_data_list.length;

        List<dynamic> sublist = sugar_data_list.sublist(startIdx, endIdx);

        if (sublist.isNotEmpty) {
          bool isSame = sublist.first['date'].toString().split(":")[0].trim() ==
              sublist.last['date'].toString().split(":")[0].trim();

          sugar_graph_list.add({
            "date": isSame
                ? "Whole Day - ${sublist.first['date'].toString().split(":")[0]}"
                : "${sublist.first['date'].toString().split(":")[0]} - ${sublist.last['date'].toString().split(":")[0]}",
            "sugar_level": sublist.map((e) => e['sugar_level']).toList()
          });

          sugar_report_date.add(isSame
              ? "Whole Day - ${sublist.first['date'].toString().split(":")[0]}"
              : "${sublist.first['date'].toString().split(":")[0]} - ${sublist.last['date'].toString().split(":")[0]}");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //* fetch sugar data
  Future<List<dynamic>> fetchSugarData() async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("sugar_data");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      List<dynamic> list = docs['sugar_data'].toList();
      sugar_data_list.value = list;

      double sugar_sum =
          (list.fold(0, (sum, entry) => sum + entry['sugar_level']));
      AvgSugarLevel.value =
          double.parse((sugar_sum / list.length).toStringAsFixed(2));

      MaxSugarLevel.value = double.parse((list.reduce((a, b) =>
              a['sugar_level'] > b['sugar_level'] ? a : b)['sugar_level'])
          .toStringAsFixed(2));
      MinSugarLevel.value = double.parse((list.reduce((a, b) =>
              a['sugar_level'] < b['sugar_level'] ? a : b)['sugar_level'])
          .toStringAsFixed(2));
      

      return sugar_data_list;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //* fetch sugar data stream from database
  Stream<List<dynamic>> fetchSugarDataStream() {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("sugar_data");

      return collectionReference
          .where('email', isEqualTo: email)
          .snapshots()
          .map((querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return [];
        }

        final DocumentSnapshot docs = querySnapshot.docs.first;
        final List<dynamic> list = List.from(docs['sugar_data']);

        sugar_data_list.value = list;

        double sugar_sum =
            (list.fold(0, (sum, entry) => sum + entry['sugar_level']));
        AvgSugarLevel.value =
            double.parse((sugar_sum / list.length).toStringAsFixed(2));

        MaxSugarLevel.value = double.parse((list.reduce((a, b) =>
                a['sugar_level'] > b['sugar_level'] ? a : b)['sugar_level'])
            .toStringAsFixed(2));
        MinSugarLevel.value = double.parse((list.reduce((a, b) =>
                a['sugar_level'] < b['sugar_level'] ? a : b)['sugar_level'])
            .toStringAsFixed(2));

        return list;
      });
    } on FirebaseException {
      //toastErrorSlide(context, "Error fetching data: ${e.message}");
      return Stream.value([]);
    }
  }

  //* generate report of sugar data
  Future<void> generateSugarDataReport(BuildContext context) async {
    try {
      if (sugar_data_list.isEmpty) {
        toastErrorSlide(context, "No Data To Store");
        return;
      }
      isLoadingReport.value = true;

      Map<String, List<double>> sugarLevelData = {};

      final email = FirebaseAuth.instance.currentUser!.email!;
      final date = DateFormat('dd MMM yyyy').format(DateTime.now());

      for (var data in sugar_data_list) {
        String date = (data["date"] as String).split(":")[0];
        double sugarLevel = (data["sugar_level"] as num).toDouble();

        //* Add sygar values
        if (!sugarLevelData.containsKey(date)) {
          sugarLevelData[date] = [];
        }
        sugarLevelData[date]!.add(sugarLevel);
      }

      //* Calculating average for each date
      Map<String, double> avgSugarLevel = {};

      sugarLevelData.forEach((date, values) {
        avgSugarLevel[date] = values.reduce((a, b) => a + b) / values.length;
      });

      final List<dynamic> sugar_report = [];

      for (var key in avgSugarLevel.keys) {
        final colorStatusList = getSugarColorSatus(avgSugarLevel[key]!);
        sugar_report.add({
          "sugar_level": avgSugarLevel[key],
          "date": key,
          "color": colorStatusList[0],
          "status": colorStatusList[1]
        });
      }

      //* submit report data to database
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("sugar_report");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        await collectionReference.add({
          "email": email,
          "sugar_report": [
            {"submitted_on": date, "sugar_report": sugar_report}
          ]
        });
      } else {
        final list = {"submitted_on": date, "sugar_report": sugar_report};
        DocumentSnapshot docs = querySnapshot.docs.first;

        await docs.reference.update({
          "sugar_report": FieldValue.arrayUnion([list])
        });
      }

      //* after report is stored clear the data
      CollectionReference sugar_reference =
          FirebaseFirestore.instance.collection("sugar_data");
      QuerySnapshot sugar_snapshot =
          await sugar_reference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs1 = sugar_snapshot.docs.first;
      await docs1.reference.update({
        'sugar_data': FieldValue.delete(),
      });

      toastSuccessSlide(context, "Report Stored Successfully!");

      isLoadingReport.value = false;
    } catch (e) {
      toastErrorSlide(context, "Cannot Store Report : ${e.toString()}");
      isLoadingReport.value = false;
    }
  }

  //* get report of sugar data
  Stream<List<dynamic>> getReportData() {
    try {
      final email = FirebaseAuth.instance.currentUser!.email!;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("sugar_report");

      return collectionReference
          .where('email', isEqualTo: email)
          .snapshots()
          .map((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot docs = querySnapshot.docs.first;
          sugar_report_list.value = docs["sugar_report"];
          return docs['sugar_report'] as List<dynamic>;
        } else {
          return [];
        }
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

   //* delete a history record
  Future<void> deleteHistoryRecord(BuildContext context, String date) async {
    try {
      final collection = FirebaseFirestore.instance.collection('sugar_data');
      final email = FirebaseAuth.instance.currentUser!.email!;
      final querySnapshot =
          await collection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) return;

      final doc = querySnapshot.docs.first;
      final sugarDataList = List<Map<String, dynamic>>.from(doc['sugar_data']);
      sugarDataList.removeWhere((entry) => entry['date'] == date);

      await collection.doc(doc.id).update({'sugar_data': sugarDataList});
    } catch (e) {
      print(e.toString());
    }
  }
}
