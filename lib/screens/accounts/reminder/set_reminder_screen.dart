import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/reminder/reminder_controller.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';
import 'package:health_guardian/widgets/reminder/reminder_widgets.dart';

class SetReminderScreen extends StatelessWidget {
  SetReminderScreen({super.key});
  final ReminderController reminderController = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBarReminder(),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.4642*SizeConfig.widthMultiplier),
        child: Column(
          children: [
            SizedBox(
              height: 1.5800*SizeConfig.heightMultiplier,
            ),

            //* Reminder Card
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.4642*SizeConfig.widthMultiplier, vertical: 2.633427*SizeConfig.heightMultiplier),
              height: 42.134846*SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade900,
                      spreadRadius: 2.5,
                      blurRadius: 2.5)
                ],
                borderRadius: BorderRadius.circular(0.526687*SizeConfig.heightMultiplier),
              ),
              child: Column(
                children: [
                  reminderSwitch(reminderController),
                  SizedBox(
                    height: 1.053*SizeConfig.heightMultiplier,
                  ),
                  Divider(
                    color: Colors.grey.shade900,
                    height: 1.053*SizeConfig.heightMultiplier,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 1.5800*SizeConfig.heightMultiplier,
                  ),

                  //* set reminder time widget
                  setReminderTime(reminderController),

                  SizedBox(height: 2.63343*SizeConfig.heightMultiplier,),

                  //* set reminder note
                  reminderText(),

                  SizedBox(height: 2.106748*SizeConfig.heightMultiplier,),

                  reminderField(context,reminderController),

                  SizedBox(height: 2.949448*SizeConfig.heightMultiplier,),

                  //* button
                  buttonsDetail("Set Reminder", ()=>{}, Colours.buttonColorRed, Colors.white, 5.793559*SizeConfig.heightMultiplier, 40.178571*SizeConfig.widthMultiplier, 3.160123*SizeConfig.heightMultiplier)
                ],
              ),
            )
          ],
        ),
      ),

      //* bottom text
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 1.2*SizeConfig.heightMultiplier,horizontal: 1.2*SizeConfig.widthMultiplier),
            child: Text(
              "You will receive a reminder notification at selected time. ",
              style: TextStyle(fontSize: 2.1067*SizeConfig.heightMultiplier, fontFamily: "Poppins-Med"),
            ))]
    ));
  }
}

