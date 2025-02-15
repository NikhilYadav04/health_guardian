import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_guardian/helper/helper_functions.dart';

class DashboardControllers extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    ProfileStatus.value = await HelperFunctions.getProfileStatus();
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
