import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/helper/helper_functions.dart';
import 'package:health_guardian/styling/toast_message.dart';

class ProfileCompletionController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    final email = FirebaseAuth.instance.currentUser!.email!;
    Name.value = await HelperFunctions.getName(email);
    Phone.value = await HelperFunctions.getPhoneNumber(email);
  }

  //* controller
  final TextEditingController nameController = TextEditingController();

  //* variables
  RxString gender = "".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt selectedWeight = 50.obs;
  RxInt selectedHeight = 150.obs;

  RxString Name = "User".obs;
  RxString Phone = "915250XXXX".obs;

  //* bool
  RxBool heart_disease = false.obs;
  RxBool blood_pressure = false.obs;
  RxBool blood_sugar = false.obs;
  RxBool weight_bmi = false.obs;

  RxBool isLoading = false.obs;

  //* functions
  void changeTime(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void changeWeight(int newWeight) {
    selectedWeight.value = newWeight;
  }

  void changeHeight(int newHeight) {
    selectedHeight.value = newHeight;
  }

  Future<String> completeProfile(BuildContext context) async {
    try {
      isLoading.value = true;

      //* verification of parameters

      if (nameController.text.toString().isEmpty ||
          nameController.text.toString() == "") {
        toastErrorSlide(context, "Please Enter a Name");
        isLoading.value = false;
        return "";
      } else if (nameController.text.toString().length >= 9) {
        toastErrorSlide(context, "Name is too long");
        isLoading.value = false;
        return "";
      }

      if (gender == "") {
        toastErrorSlide(context, "Please Specify Your Gender");
        isLoading.value = false;
        return "";
      }

      Rx<DateTime> currentDate = DateTime.now().obs;

      if (currentDate.value.year - selectedDate.value.year <= 18) {
        toastErrorSlide(context, "Your Age must be above 18");
        isLoading.value = false;
        return "";
      }

      if (selectedHeight.value <= 100) {
        toastErrorSlide(context, "Your Height must be above 100 cm");
        isLoading.value = false;
        return "";
      }

      if (selectedWeight.value <= 30) {
        toastErrorSlide(context, "Your Weight must be above 30 kg");
        isLoading.value = false;
        return "";
      }
      final email = FirebaseAuth.instance.currentUser!.email;

      String disease_list = "";

      if (heart_disease.value) {
        disease_list += "Heart Disease, ";
      }
      if (blood_pressure.value) {
        disease_list += "Blood Pressure, ";
      }
      if (blood_sugar.value) {
        disease_list += "Blood Sugar, ";
      }
      if (weight_bmi.value) {
        disease_list += "Weight BMI, ";
      }

      //* Set the name and phone number of user
      Phone.value = await HelperFunctions.getPhoneNumber(email!);
      await HelperFunctions.setName(nameController.text.toString(), email);
      Name.value = await HelperFunctions.getName(email);

      //* add profile details in database
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("profile_details");
      await collectionReference.add({
        "name": nameController.text.toString(),
        "email": email,
        "gender": gender.value,
        "dob": selectedDate.value.toString(),
        "height": selectedHeight.value.toString(),
        "weight": selectedWeight.value.toString(),
        "disease_list": disease_list.toString()
      });

      await HelperFunctions.setProfileStatus(true);

      isLoading.value = false;
      return "Success";
    } catch (e) {
      toastErrorSlide(context, "Error Completing Profile : ${e.toString()}");
      isLoading.value = false;
      return "";
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
