import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/weight_measure_controllers.dart';
import 'package:health_guardian/getX_controllers/profile/profile_controller.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/weight-measure/wm_widgets_3.dart';
import 'package:health_guardian/widgets/detail-screen/weight-measure/wm_widgets_4.dart';

class AddWeightMeasureRecord extends StatelessWidget {
  final WeightMeasureControllers controller =
      Get.put(WeightMeasureControllers());
  final ProfileCompletionController profileCompletionController = Get.find<ProfileCompletionController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBAddRecordWeight(),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.67 * SizeConfig.widthMultiplier,
              vertical: 1.58 * SizeConfig.heightMultiplier),
          child: Column(
            children: [
              //* for user input of data
              userInputWeightWidget(controller),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* Selecting the state of user
              stateSelectWeightWIdget(controller,profileCompletionController),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* Adding a note
              addNoteWeightWidget(controller.noteController),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* Sugar level Scale Widget
              weightScaleWidget(controller),

              SizedBox(
                height: 3.68 * SizeConfig.heightMultiplier,
              ),

              //* button for adding new record
              Obx(
                () => controller.isLoadingAdd.value
                    ? SpinKitCircle(
                        color: Colours.buttonColorRed,
                        size: 30,
                      )
                    : authButton("Add Record", () {
                        controller.addWeightData(context);
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
