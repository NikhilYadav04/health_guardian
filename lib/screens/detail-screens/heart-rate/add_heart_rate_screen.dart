import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_3.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_3.dart';
import 'package:health_guardian/widgets/detail-screen/heart-attack/heart_widgets.dart';
import 'package:health_guardian/widgets/detail-screen/heart-attack/heart_widgets_2.dart';

class AddHeartRateScreen extends StatelessWidget {
  AddHeartRateScreen({super.key});
  final HeartRateControllers heartRateControllers = Get.put(HeartRateControllers());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      appBar: appBAddRecord(),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.67*SizeConfig.widthMultiplier, vertical: 1.58*SizeConfig.heightMultiplier),
          child: Column(
            children: [
              //* for user inout of heart data
              heartRateInputWidget(heartRateControllers),

              SizedBox(height: 3.68*SizeConfig.heightMultiplier,),

              //* state select widget
              heartStateSelectWIdget(heartRateControllers),

              SizedBox(height: 3.68*SizeConfig.heightMultiplier,),

              //* Adding a note
              addNoteBPWidget(heartRateControllers.noteController),

              SizedBox(height: 3.68*SizeConfig.heightMultiplier,),
  
              //* Heart Rate Scale Widget
              heartScaleWidget(),

              SizedBox(height: 3.68*SizeConfig.heightMultiplier),

              //* Button for adding record
              authButton("Add Record", (){}),

              SizedBox(height: 1.58*SizeConfig.heightMultiplier,),
            ]
          ),
        ),
      ),
    ));
  }
}