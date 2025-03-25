import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/services/workManager.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:intl/intl.dart';

class ReminderController extends GetxController {
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

  void changeSwitch(bool val) {
    isCheck.value = val;
  }

  void setReminder(BuildContext context) {
    try {
      if (!isCheck.value) {
        toastErrorSlide(context, "Enable Reminder !!");
        return;
      }

      if (noteController.text.toString().isEmpty) {
        toastErrorSlide(context, "Please add a note");
        return;
      }

      int minutes = selectedTime.value.minute - DateTime.now().minute;
      if (minutes < 0) {
        toastErrorSlide(context, "Select a future time for reminder");
        return;
      }

      WorkManager.scheduleReminder(minutes, noteController.text.toString());
      clear();
      toastSuccessSlide(context, "Reminder Set Successfully");
    } catch (e) {
      toastErrorSlide(context, "Error Setting Reminder");
    }
  }

  void clear() {
    selectedTime.value = DateTime.now();
    noteController.clear();
  }
}
