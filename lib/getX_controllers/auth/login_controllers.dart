import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_guardian/helper/helper_functions.dart';
import 'package:health_guardian/screens/auth/verify_pin_screen.dart';
import 'package:health_guardian/screens/auth/login_screen.dart';
import 'package:health_guardian/screens/auth/set_pin_screen.dart';
import 'package:health_guardian/screens/dashboard/dashboard_screen.dart';
import 'package:health_guardian/screens/profile/profile_completion_screen.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:logger/logger.dart';

class CreateAccountController extends GetxController {
  //* controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController AppPinController = TextEditingController();

  //* bool
  RxBool isVisible = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingPin = false.obs;

  //* keys
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> PasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> PhoneNumberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> AppPinKey = GlobalKey<FormState>();

  //* functions
  Future<void> createAccount(BuildContext context) async {
    try {
      isLoading.value = true;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      final userID = FirebaseAuth.instance.currentUser!.uid;
      await HelperFunctions.setPhoneNumber(
          PhoneNumberController.text.toString(), userID);
      await HelperFunctions.setName("User",PhoneNumberController.text.toString() );
      await HelperFunctions.setProfileStatus(false);

      toastSuccessSlide(context, "Account Created Successfully");
      await Get.to(
          () => SetPinScreen(
                email: emailController.text.toString(),
              ),
          transition: Transition.rightToLeft);
      Future.delayed(Duration(milliseconds: 500));
      clear();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            toastErrorSlide(context, "Email is already registered.");
            break;
          case 'weak-password':
            toastErrorSlide(context, "Email is already registered.");
            break;
          default:
            toastErrorSlide(context, e.message ?? "An error occurred.");
        }
        return;
      } else {
        toastErrorSlide(context, e.toString());

        return;
      }
    }
  }

  Future<void> setAppPin(BuildContext context, String email) async {
    try {
      isLoadingPin.value = true;

      final pin = AppPinController.text.toString();
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('app_pin');
      QuerySnapshot snapshot =
          await collectionReference.where('email', isEqualTo: email).get();
      if (snapshot.docs.isEmpty) {
        await collectionReference.add({"email": email, "pin": pin});
      } else {
        DocumentSnapshot documentSnapshot = snapshot.docs.first;
        await documentSnapshot.reference.update({"email": email, "pin": pin});
      }

      toastSuccessSlide(context, "App Pin set successfully");

      clear();

      Get.to(() => ProfileCompletionScreen(status: "create"),
          transition: Transition.rightToLeft);

      isLoadingPin.value = false;
    } catch (e) {
      isLoadingPin.value = false;
      print("Error : ${e.toString()}");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    super.dispose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    PhoneNumberController.clear();
    AppPinController.clear();
  }
}

class LoginAccountController extends GetxController {
  //* controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController AppPinController = TextEditingController();

  //* bool
  RxBool isVisible = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingPin = false.obs;

  //* keys
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> PasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> AppPinKey = GlobalKey<FormState>();

  //* functions
  Future<void> loginAccount(BuildContext context) async {
    try {
      isLoading.value = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      Get.to(
          () => VerifyPinScreen(
                status: "Login",
              ),
          transition: Transition.rightToLeft);

      clear();

      toastSuccessSlide(context, "Verified Successfully!");

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            toastErrorSlide(context, 'Incorrect password. Please try again.');
            break;
          case 'user-not-found':
            toastErrorSlide(context,
                'No user found with this email. Please register first.');
            break;
          default:
            toastErrorSlide(context, 'An unknown error occurred: ${e.message}');
        }
        return;
      } else {
        toastErrorSlide(context, e.toString());
        return;
      }
    }
  }

  //* verify the code
  Future<void> verifyCode(BuildContext context) async {
    try {
      isLoadingPin.value = true;

      final email = FirebaseAuth.instance.currentUser!.email!;
      final input_pin = AppPinController.text.toString();

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('app_pin');
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        toastErrorSlide(context, "Please Set Up an App PIN");
        isLoadingPin.value = false;
        return;
      }
      final docs = querySnapshot.docs.first;
      final pin = docs.get('pin');
      if (input_pin == pin.toString()) {
        isLoadingPin.value = false;
        clear();
        await HelperFunctions.setAuthStatus(true);

        toastSuccessSlide(context, "Logged In Successfully!");
        Get.offAll(() => DashboardScreen(), transition: Transition.rightToLeft);
      } else {
        isLoadingPin.value = false;
        toastErrorSlide(context, "Invalid App Pin Entered!!");
      }

      isLoadingPin.value = false;
    } catch (e) {
      isLoadingPin.value = false;
      toastErrorSlide(context, "Error logging in!!");
    }
  }

  //* logout
  Future<void> logout() async {
    try {
      await HelperFunctions.setAuthStatus(false);
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen(), transition: Transition.downToUp);
    } catch (e) {
      var logger = Logger();
      logger.d("Error logout : ${e.toString()}");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    super.dispose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    AppPinController.clear();
  }
}
