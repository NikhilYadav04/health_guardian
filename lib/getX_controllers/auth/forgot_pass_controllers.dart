import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_guardian/screens/auth/login_screen.dart';
import 'package:health_guardian/styling/toast_message.dart';

class ForgotPassControllers extends GetxController {
  //* controllers
  TextEditingController controller = TextEditingController();

  //*key
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();

  //* bool
  RxBool isLoading = false.obs;

  //* functions

  void clear() {
    controller.clear();
  }

  //* reset pin
  Future<void> resetPassword(BuildContext context) async {
    try {
      isLoading.value = true;

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: controller.text.toString());
      clear();

      isLoading.value = false;
      toastSuccessSlideLong(context,
          "A password reset link has been sent to your email. Check it");
      Get.offAll(() => LoginScreen(), transition: Transition.rightToLeft);
    } catch (e) {
      isLoading.value = false;
      toastErrorSlide(context, "Error : ${e.toString()}");
    }
  }
}
