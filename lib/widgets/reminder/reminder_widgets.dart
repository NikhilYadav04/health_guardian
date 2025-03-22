import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/reminder/reminder_controller.dart';
import 'package:health_guardian/styling/sizeConfig.dart';

PreferredSizeWidget appBarReminder() {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 247, 241, 241),
    toolbarHeight: 8.427 * SizeConfig.heightMultiplier,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 4.424 * SizeConfig.heightMultiplier,
        )),
    title: Text(
      "Reminder",
      style: TextStyle(
          color: Colors.black,
          fontFamily: "CoreSansBold",
          fontSize: 3.581 * SizeConfig.heightMultiplier),
    ),
  );
}

TextStyle style = TextStyle(fontFamily: "Poppins-Med", color: Colors.black);

Widget reminderSwitch(ReminderController controller) {
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reminder",
          style: style.copyWith(fontSize: 2.73877*SizeConfig.heightMultiplier, fontWeight: FontWeight.w700),
        ),
        Switch(
          value: controller.isCheck.value,
          onChanged: (bool val) {
            controller.changeSwitch(val);
          },
          focusColor: Colors.red,
          inactiveThumbColor: Colors.red,
          inactiveTrackColor: Colors.white,
          activeColor: Colors.white,
          activeTrackColor: Colors.red,
        )
      ],
    ),
  );
}

Widget setReminderTime(ReminderController controller) {
  return Obx(
    () => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reminder Time",
          style: style.copyWith(fontSize: 2.63343*SizeConfig.heightMultiplier, fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            Text(
              controller.displayTime.value,
              style: style.copyWith(
                  fontSize: 2.52809*SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800),
            ),
            SizedBox(
              width: 2.23214*SizeConfig.widthMultiplier,
            ),

            //* Set Time
            InkWell(
                onTap: () => Get.bottomSheet(Container(
                      height: 26.34 * SizeConfig.heightMultiplier,
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        initialDateTime: controller.selectedTime.value,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newTime) {
                          controller.changeTime(newTime);
                        },
                      ),
                    )),
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.grey.shade800,
                  size: 2.9494485*SizeConfig.heightMultiplier,
                ))
          ],
        ),
      ],
    ),
  );
}

Widget reminderText() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      "Set Reminder Note : ",
      style: style.copyWith(
          fontSize: 2.52809*SizeConfig.heightMultiplier, fontWeight: FontWeight.w700, color: Colors.black),
    ),
  );
}

Widget reminderField(BuildContext context,ReminderController controller) {
  return SizedBox(
    height: 6.32024*SizeConfig.heightMultiplier,
    child: FormField(builder: (context) {
      return TextField(
        controller: controller.noteController,
        style: style.copyWith(
            color: Colors.grey.shade800,
            fontSize: 2.00141*SizeConfig.heightMultiplier,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            focusColor: Colors.black,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(
                    color: Colors.black, width: 2, style: BorderStyle.solid)),
            label: FittedBox(
              child: Text(
                "Enter Heart Data Before Eating",
                style: style.copyWith(
                    color: Colors.grey.shade800,
                    fontSize: 2.00141*SizeConfig.heightMultiplier,
                    fontWeight: FontWeight.w700),
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                    color: Colors.black, width: 2, style: BorderStyle.solid)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(
                    color: Colors.black, width: 2, style: BorderStyle.solid))),
      );
    }),
  );
}
