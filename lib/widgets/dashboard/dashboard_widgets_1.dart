import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:health_guardian/getX_controllers/dashboard/dashboard_controllers.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/dashboard_buttons.dart';
import 'package:health_guardian/widgets/onboard/onboard_widgets.dart';

Widget currentTimeWidget(String date,String day) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: date,
          style: style.copyWith(fontSize: 4.2134979*SizeConfig.heightMultiplier, fontWeight: FontWeight.bold),
        ),
        WidgetSpan(
          child: Transform.translate(
            offset: const Offset(6, -20),
            child: Text(
              day,
              style: style.copyWith(fontSize: 2.528098*SizeConfig.heightMultiplier, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget titleWidget(String name) {
  return Row(
    children: [
      Text(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        "Hello, ${name} !",
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins-Med",
            fontWeight: FontWeight.w700,
            fontSize: 3.58 * SizeConfig.heightMultiplier),
      ),
      SizedBox(
        width: 2.4 * SizeConfig.widthMultiplier,
      ),
      SvgPicture.asset(
        Images.welcomeIcon,
        height: 4.24 * SizeConfig.heightMultiplier,
        width: 10.80 * SizeConfig.widthMultiplier,
      )
    ],
  );
}

TextStyle style = TextStyle(
    color: const Color.fromARGB(255, 103, 101, 101), fontFamily: "Poppins-Med");

BottomNavigationBar bottomBar(
    DashboardControllers controller, BuildContext context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: icontheme().copyWith(color: Colours.buttonColorRed),
    unselectedIconTheme: icontheme().copyWith(color: Colors.grey.shade800),
    selectedItemColor: Colours.buttonColorRed,
    unselectedItemColor: Colors.grey.shade800,
    unselectedLabelStyle: labelStyle(),
    selectedLabelStyle: labelStyle(),
    currentIndex: controller.currentPage.value,
    onTap: (value) {
      controller.changeIndex(value);
    },
    items: [
      BottomNavigationBarItem(
        label: "Home",
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: "Analyze",
        icon: Icon(FontAwesomeIcons.heartCirclePlus),
      ),
      BottomNavigationBarItem(
        label: "Reports",
        icon: Icon(Icons.assignment),
      ),
    ],
  );
}

Widget heartMeasureCard(void Function() onTap,EditHeartRateDataController editController) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 4.46 * SizeConfig.widthMultiplier),
    height: 24.22 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 208, 204),
        borderRadius:
            BorderRadius.circular(1.05 * SizeConfig.heightMultiplier)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //* for text
        Flexible(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.63 * SizeConfig.heightMultiplier,
                ),
                Text(
                  "Heart Rate",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Bold",
                      fontSize: 3.4 * SizeConfig.heightMultiplier),
                ),
                SizedBox(
                  height: 1.05 * SizeConfig.heightMultiplier,
                ),
                Obx(
                  ()=> Text(
                    "${editController.heart_data_list.length} Records",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 80, 78, 78),
                        fontFamily: "Poppins-Bold",
                        fontSize: 2.5 * SizeConfig.heightMultiplier),
                  ),
                ),
                SizedBox(height: 2.63 * SizeConfig.heightMultiplier),
                buttonsSample(
                    "Measure",
                    onTap,
                    Colours.buttonColorRed,
                    Colors.white,
                    5.79 * SizeConfig.heightMultiplier,
                    35.71 * SizeConfig.widthMultiplier)
              ],
            )),
        //* for vector image
        Flexible(flex: 3, child: SvgPicture.asset(Images.heartMeasureIcon))
      ],
    ),
  );
}

Widget diseaseCard(
    String disease,
    String image,
    Color cardColor,
    Color buttonColor,
    void Function() onTap,
    RxBool buttonValue,
    void Function(bool) OnTap1) {
  return Container(
    height: 10.53 * SizeConfig.heightMultiplier,
    padding:
        EdgeInsets.symmetric(horizontal: 3.34 * SizeConfig.widthMultiplier),
    decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(1.05 * SizeConfig.heightMultiplier)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    child: Text(
                      disease,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.21 * SizeConfig.heightMultiplier,
                          fontFamily: "Poppins-Bold"),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    image,
                    height: 6.32 * SizeConfig.heightMultiplier,
                    width: 13.39 * SizeConfig.widthMultiplier,
                  ),
                ),
              ],
            )),
        SizedBox(
          width: 1.11 * SizeConfig.widthMultiplier,
        ),
        Flexible(
          flex: 1,
          child: buttonsDisease(
              "Record",
              onTap,
              buttonColor,
              Colors.white,
              5.79 * SizeConfig.heightMultiplier,
              37.94 * SizeConfig.widthMultiplier,
              buttonValue,
              OnTap1),
        )
      ],
    ),
  );
}

TextStyle labelStyle() {
  return TextStyle(
    fontFamily: "CoreSansBold",
    color: Colours.buttonColorRed,
    fontSize: 1.89 * SizeConfig.heightMultiplier,
  );
}

IconThemeData icontheme() {
  return IconThemeData(
    size: 4.00 * SizeConfig.heightMultiplier,
  );
}
