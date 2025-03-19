
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/helper/helper_functions.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:logger/logger.dart';

class ProfileCompletionController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    final userID = FirebaseAuth.instance.currentUser!.uid;
    Phone.value = await HelperFunctions.getPhoneNumber(userID);
    Name.value = await HelperFunctions.getName(Phone.value);

    var logger = Logger();
    logger.d(userID);
    logger.d("Name is ${Name.value}");
    logger.d("Phone is ${Phone.value}");
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
  RxBool isLoadingEdit = false.obs;

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
      final userID = FirebaseAuth.instance.currentUser!.uid;
      Phone.value = await HelperFunctions.getPhoneNumber(userID);
      await HelperFunctions.setName(
          nameController.text.toString(), Phone.value);
      Name.value = await HelperFunctions.getName(Phone.value);

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

      clear();
      await HelperFunctions.setProfileStatus(true);

      isLoading.value = false;
      return "Success";
    } catch (e) {
      toastErrorSlide(context, "Error Completing Profile : ${e.toString()}");
      isLoading.value = false;
      return "";
    }
  }

  Future<void> getProfileData(BuildContext context) async {
    try {
      isLoadingEdit.value = true;

      final email = FirebaseAuth.instance.currentUser!.email;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("profile_details");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentSnapshot docs = querySnapshot.docs.first;

      nameController.text = docs['name'].toString();
      selectedDate.value = DateTime.parse(docs['dob']);
      selectedHeight.value = int.parse(docs['height']);
      selectedWeight.value = int.parse(docs['weight']);

      print(nameController.text);
      print(selectedWeight.value);

      isLoadingEdit.value = false;
    } catch (e) {
      isLoadingEdit.value = false;
      print(e.toString());
      return;
    }
  }

  Future<String> updateProfile(BuildContext context) async {
    try {
      isLoading.value = true;

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

      var logger = Logger();
      logger.d("gender is ${gender.value}");

      if (gender.value == "") {
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
      final userID = FirebaseAuth.instance.currentUser!.uid;
      Phone.value = await HelperFunctions.getPhoneNumber(userID);
      await HelperFunctions.setName(
          nameController.text.toString(), Phone.value);
      Name.value = await HelperFunctions.getName(Phone.value);

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("profile_details");
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      DocumentReference docs = querySnapshot.docs.first.reference;

      await docs.update({
        "name": nameController.text.toString(),
        "email": email,
        "gender": gender.value,
        "dob": selectedDate.value.toString(),
        "height": selectedHeight.value.toString(),
        "weight": selectedWeight.value.toString(),
        "disease_list": disease_list.toString()
      });

      clear();
      isLoading.value = false;

      return "Success";
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      return "Error";
    }
  }

  void clear() {
    nameController.text = "";
    selectedDate.value = DateTime.now();
    selectedHeight.value = 150;
    selectedWeight.value = 50;
    gender.value = "";
    heart_disease.value = false;
    blood_pressure.value = false;
    blood_sugar.value = false;
    weight_bmi.value = false;
  }
}
