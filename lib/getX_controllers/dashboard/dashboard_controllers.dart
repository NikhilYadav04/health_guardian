import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_guardian/helper/current_date.dart';
import 'package:health_guardian/helper/helper_functions.dart';
import 'package:logger/logger.dart';

class DashboardControllers extends GetxController {
  //* variables
  RxString currentDate = "".obs;
  RxString currentDay = "".obs;

  //* check profile completion status
  @override
  void onInit() async {
    super.onInit();
    final email = await FirebaseAuth.instance.currentUser!.email;
    QuerySnapshot profilesnapshot = await FirebaseFirestore.instance
        .collection("profile_details")
        .where('email', isEqualTo: email)
        .get();
    bool status = profilesnapshot.docs.isNotEmpty;
    await HelperFunctions.setProfileStatus(status);

    ProfileStatus.value = status;

    var logger = Logger();
    logger.d("Profile status is ${ProfileStatus.value}");

    //* get current date and day
    currentDate.value = await CurrentDate.getDate();
    currentDay.value = await CurrentDate.getDay();
  }

  //* bool
  RxBool ProfileStatus = false.obs;

  //*index for appbar icons
  RxInt currentPage = 0.obs;

  //*for changing index between pages
  void changeIndex(index) {
    currentPage.value = index;
    print(currentPage);
  }

  void onClose() {
    super.onClose();
  }
}
