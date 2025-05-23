import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/blood_pressure_controllers.dart';
import 'package:health_guardian/screens/detail-screens/blood-pressure/add_blood_pressure_record.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_1.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_2.dart';

class BloodPressureDetail extends StatelessWidget {
  final BloodPressureControllers controller =
      Get.put(BloodPressureControllers());
  final EditBloodPressureDataControllers editController =
      Get.put(EditBloodPressureDataControllers());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      appBar: appB_BP(() {
        Get.back();
      }, () {}),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 1.5 * SizeConfig.heightMultiplier,
              vertical: 0.1 * SizeConfig.heightMultiplier),
          child: Column(
            children: [
              //* widget for showing blood pressure data
              bloodPressureDataWidget(editController),

              //* for buttons of stats and history
              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),
              doubleButtonWidgetBP(controller, editController),
              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* stats and history display widget
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.23 * SizeConfig.widthMultiplier,
                      vertical: 1 * SizeConfig.heightMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        1.05 * SizeConfig.heightMultiplier),
                  ),
                  height: (SizeConfig.heightMultiplier <= 7.32 &&
                          SizeConfig.widthMultiplier <= 4.12)
                      ? 52 * SizeConfig.heightMultiplier
                      : 50.7 * SizeConfig.heightMultiplier,
                  child: dataWidgetBP(controller, editController)),
              SizedBox(
                height: 2.6 * SizeConfig.heightMultiplier,
              ),

              //* pressure text
              pressureText(),

              SizedBox(
                height: 3.4 * SizeConfig.heightMultiplier,
              ),

              //* button for a  dding new record
              authButton("+ Add", () {
                Future.delayed(Duration(milliseconds: 200), () {
                  Get.to(() => AddBloodPressureRecord(),
                      transition: Transition.downToUp);
                });
              }),
              SizedBox(
                height: 2.10 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
