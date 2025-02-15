import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/screens/profile/profile_completion_screen.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:logger/logger.dart';

List<IconData> iconDataList = [
  Icons.alarm,
  Icons.privacy_tip_outlined,
  Icons.help_outline_outlined,
  Icons.logout,
];

List<String> title = [
  "Reminder",
  "Account & Security",
  "Help & Security",
  "Logout"
];

Widget profileWidgetAcc(String name,String phone) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: 3.348 * SizeConfig.widthMultiplier,
        vertical: 0.526 * SizeConfig.heightMultiplier),
    height: 12.4 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0.632 * SizeConfig.heightMultiplier),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: CircleAvatar(
                radius: 4.213 * SizeConfig.heightMultiplier,
                backgroundImage: AssetImage(Images.profileIcon))),
        Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.5 * SizeConfig.heightMultiplier,
                ),
                Text(
                  "${name}",
                  style: TextStyle(
                      fontFamily: "Poppins-Med",
                      fontWeight: FontWeight.bold,
                      fontSize: 2.738 * SizeConfig.heightMultiplier,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 1.053 * SizeConfig.heightMultiplier,
                ),
                Text(
                    "Phone Number : ${phone}           ",
                    style: TextStyle(
                        fontFamily: "Poppins-Med",
                        fontWeight: FontWeight.bold,
                        fontSize: 2 * SizeConfig.heightMultiplier,
                        color: Colors.grey.shade700),
                  ),
              ],
            )),
      ],
    ),
  );
}

Widget profileOptions(
    BuildContext context, List<void Function()> functions, bool status) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0.632 * SizeConfig.heightMultiplier),
    ),
    height: 37.869 * SizeConfig.heightMultiplier,
    padding:
        EdgeInsets.symmetric(vertical: 1.264 * SizeConfig.heightMultiplier),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            status
                ? SizedBox()
                : Get.to(
                    () => ProfileCompletionScreen(
                          status: "complete",
                        ),
                    transition: Transition.rightToLeft);
          },
          child: Container(
            height: 6.847 * SizeConfig.heightMultiplier,
            child: ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: status ? Colors.black : Colours.buttonColorRed,
                size: 3.160 * SizeConfig.heightMultiplier,
              ),
              title: Text(
                status ? "Edit Profile" : "Incomplete Profile",
                style: TextStyle(
                    fontFamily: "Poppins-Med",
                    fontWeight: FontWeight.bold,
                    fontSize: 2.317 * SizeConfig.heightMultiplier,
                    color: status ? Colors.black : Colours.buttonColorRed),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black,
                size: 2.528 * SizeConfig.heightMultiplier,
              ),
            ),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: functions[index],
                child: listCard(title[index], iconDataList[index], index),
              );
            }),
      ],
    ),
  );
}

Widget listCard(String title, IconData icon, int index) {
  return Container(
    height: 6.847 * SizeConfig.heightMultiplier,
    child: ListTile(
      leading: Icon(
        icon,
        color: icon == Icons.logout ? Colours.buttonColorRed : Colors.black,
        size: 3.160 * SizeConfig.heightMultiplier,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: "Poppins-Med",
            fontWeight: FontWeight.bold,
            fontSize: 2.317 * SizeConfig.heightMultiplier,
            color: title == "Logout" ? Colors.red : Colors.black),
      ),
      trailing: index == 4
          ? SizedBox()
          : Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 2.528 * SizeConfig.heightMultiplier,
            ),
    ),
  );
}
