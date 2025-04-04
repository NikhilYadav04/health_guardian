import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/blood_pressure_controllers.dart';
import 'package:health_guardian/getX_controllers/profile/profile_controller.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_3.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_4.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_5.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_3.dart';

class AddBloodPressureRecord extends StatelessWidget {
  final BloodPressureControllers controller =
      Get.put(BloodPressureControllers());
  final ProfileCompletionController profileCompletionController = Get.find<ProfileCompletionController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      appBar: appBAddRecord(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.67 * SizeConfig.widthMultiplier,
              vertical: 1.58 * SizeConfig.heightMultiplier),
          child: Column(
            children: [
              //* for user input of data
              userInputWidgetSystolicPressure(controller),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              userInputWidgetDiastolicPressure(controller),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              pulseLevelWidget(controller),

              SizedBox(height: 3.68 * SizeConfig.heightMultiplier),

              //* Selecting the state of user
              stateSelectWIdgetPressure(controller,profileCompletionController),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* add a note
              addNoteBPWidget(controller.noteController),
              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* Pressure level Scale Widget
              PressureScaleWidget(controller),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* Button for adding record
              Obx(
                () => controller.isLoadingAdd.value
                    ? SpinKitCircle(
                        color: Colours.buttonColorRed,
                        size: 30,
                      )
                    : authButton("Add Record", () {
                        controller.addBPData(context);
                      }),
              ),

              SizedBox(
                height: 1.58 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
