import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/dashboard/dashboard_controllers.dart';
import 'package:health_guardian/getX_controllers/profile/profile_controller.dart';
import 'package:health_guardian/screens/dashboard/account_screen.dart';
import 'package:health_guardian/screens/dashboard/home_screen.dart';
import 'package:health_guardian/screens/dashboard/analyze_screen.dart';
import 'package:health_guardian/screens/dashboard/report_screen.dart';
import 'package:health_guardian/screens/notification/notification_screen.dart';
import 'package:health_guardian/services/workManager.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_1.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardControllers controllers = Get.put(DashboardControllers());

  final ProfileCompletionController profileCompletionController =
      Get.put(ProfileCompletionController());

  List<dynamic> pages = [
    Text("Hello"),
    Home_D_Screen(),
    AnalyzeScreen(),
    ReportScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      //* AppBar for my screen
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => currentTimeWidget(
            controllers.currentDate.value, controllers.currentDay.value)),
        toolbarHeight: 10.01 * SizeConfig.heightMultiplier,
        actions: [
          IconButton(
              onPressed: () {
                WorkManager.scheduleReminder(0, "Heart Data Enter BEfore Eating");
              },
              icon: Icon(
                Icons.favorite,
                color: Colours.buttonColorRed,
                size: 4.42 * SizeConfig.heightMultiplier,
              )),
          IconButton(
              onPressed: () {
                Get.to(()=>NotificationScreen(),transition: Transition.upToDown);
              },
              icon: Icon(
                FontAwesomeIcons.solidBell,
                color: const Color.fromARGB(255, 103, 101, 101),
                size: 4.10 * SizeConfig.heightMultiplier,
              )),
          IconButton(
              onPressed: () {
                Get.to(() => AccountScreen(), transition: Transition.upToDown);
              },
              icon: Icon(
                Icons.account_circle,
                color: const Color.fromARGB(255, 103, 101, 101),
                size: 4.84 * SizeConfig.heightMultiplier,
              )),
        ],
      ),

      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 3.34 * SizeConfig.widthMultiplier,
                vertical: 0.52 * SizeConfig.heightMultiplier),
            child: pages[controllers.currentPage.value + 1],
          ),
        ),
      ),

      //* bottomBar for navigation
      bottomNavigationBar: Obx(() => Theme(
          data: ThemeData(splashFactory: NoSplash.splashFactory),
          child: bottomBar(controllers, context))),
    ));
  }
}
