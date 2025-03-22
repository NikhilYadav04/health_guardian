import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReminderController extends GetxController{

  //* bool and variables
  RxBool isCheck = false.obs;
  Rx<DateTime> selectedTime = DateTime.now().obs;
  RxString displayTime = "12:00 AM".obs;

  TextEditingController noteController = TextEditingController();

  void changeTime(DateTime newTime) {
    selectedTime.value = newTime;
    updateDisplayTime();
  }

  void updateDisplayTime() {
    displayTime.value = DateFormat('hh:mm a').format(selectedTime.value);
  }

  void changeSwitch(bool val){
    isCheck.value = val;
  }
}