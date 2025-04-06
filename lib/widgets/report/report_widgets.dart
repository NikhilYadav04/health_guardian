import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';

PreferredSizeWidget appBarReport(String title, String image) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 247, 241, 241),
    toolbarHeight: 8.9536 * SizeConfig.heightMultiplier,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 4.63484 * SizeConfig.heightMultiplier,
        )),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          fontFamily: "Poppins-Bold",
          color: Colors.black,
          fontSize: 3.79214 * SizeConfig.heightMultiplier),
    ),
    actions: [
      Image.asset(
        image,
        height: 5.2668 * SizeConfig.heightMultiplier,
        width: 11.160714 * SizeConfig.widthMultiplier,
      ),
      SizedBox(
        width: 2.2321 * SizeConfig.widthMultiplier,
      )
    ],
  );
}

PreferredSizeWidget appBarReportDetail(String title, String image) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 247, 241, 241),
    toolbarHeight: 8.9536 * SizeConfig.heightMultiplier,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 4.63484 * SizeConfig.heightMultiplier,
        )),
    centerTitle: true,
    title: FittedBox(
      child: Text(
        title,
        style: TextStyle(
            fontFamily: "Poppins-Bold",
            color: Colors.black,
            fontSize: 2.8 * SizeConfig.heightMultiplier),
      ),
    ),
    actions: [
      Image.asset(
        image,
        height: 5.2668 * SizeConfig.heightMultiplier,
        width: 11.160714 * SizeConfig.widthMultiplier,
      ),
      SizedBox(
        width: 2.2321 * SizeConfig.widthMultiplier,
      )
    ],
  );
}

Widget reportDisplayWidget(
    String value, String unit, String date, Color color, String status) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 1.58 * SizeConfig.heightMultiplier,
        horizontal: 2.67 * SizeConfig.widthMultiplier),
    margin: EdgeInsets.symmetric(
        vertical: 1.5 * SizeConfig.heightMultiplier,
        horizontal: 2.67 * SizeConfig.widthMultiplier),
    height: 11.3 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.shade900, spreadRadius: 3, blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(0.8 * SizeConfig.heightMultiplier),
        color: Color.fromARGB(255, 237, 228, 228)),
    child: Row(children: [
      Flexible(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: FittedBox(
                  child: Column(
                    children: [
                      Text(
                        "${value}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "CoreSansBold",
                            fontSize: 3.3 * SizeConfig.heightMultiplier),
                      ),
                      Text(
                        "${unit}",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 80, 78, 78),
                            fontFamily: "CoreSansMed",
                            fontSize: 2.1 * SizeConfig.heightMultiplier),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 7.37 * SizeConfig.heightMultiplier,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                ),
              ),
            ],
          )),
      Flexible(
        flex: 6,
        child: Row(
          children: [
            SizedBox(
              width: 2.23214 * SizeConfig.widthMultiplier,
            ),
            Text(
              date,
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontFamily: "CoreSansMed",
                  fontSize: 2.3 * SizeConfig.heightMultiplier),
            ),
            SizedBox(
              width: 2 * SizeConfig.heightMultiplier,
            ),
            buttonsDetail1(
                status,
                () {},
                color,
                Colors.white,
                4.74 * SizeConfig.heightMultiplier,
                22.32 * SizeConfig.widthMultiplier,
                0.63 * SizeConfig.heightMultiplier,
                2.00 * SizeConfig.heightMultiplier),
          ],
        ),
      ),
    ]),
  );
}

Widget reportDisplayWidgetPressure(
    String systolic,String diastolic,String pulse, String unit, String date, Color color, String status) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 1.58 * SizeConfig.heightMultiplier,
        horizontal: 2.67 * SizeConfig.widthMultiplier),
    margin: EdgeInsets.symmetric(
        vertical: 1.5 * SizeConfig.heightMultiplier,
        horizontal: 2.67 * SizeConfig.widthMultiplier),
    height: 16.5 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.shade900, spreadRadius: 3, blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(0.8 * SizeConfig.heightMultiplier),
        color: Color.fromARGB(255, 237, 228, 228)),
    child: Column(children: [
      Flexible(
          flex: 3,
          child: Row(
            children: [
              Expanded(flex: 1, child: display("78", "systolic")),
              Expanded(flex: 1, child: display("80", "diastolic")),
              Expanded(
                flex: 1,
                child: FittedBox(
                  child: Column(
                    children: [
                      Text(
                        "82",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "CoreSansBold",
                            fontSize: 3.3 * SizeConfig.heightMultiplier),
                      ),
                      Text(
                        "pulse",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 80, 78, 78),
                            fontFamily: "CoreSansMed",
                            fontSize: 2.1 * SizeConfig.heightMultiplier),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
     SizedBox(height: 1.5800*SizeConfig.heightMultiplier,),
      Flexible(
        flex: 2,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "Date : ${date}",
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: "CoreSansMed",
                    fontSize: 2.4* SizeConfig.heightMultiplier),
              ),
            ),
            Expanded(
              flex: 1,
              child: buttonsDetail1(
                  status,
                  () {},
                  color,
                  Colors.white,
                  4.74 * SizeConfig.heightMultiplier,
                  22.32 * SizeConfig.widthMultiplier,
                  0.63 * SizeConfig.heightMultiplier,
                  2.00 * SizeConfig.heightMultiplier),
            ),
          ],
        ),
      ),
    ]),
  );
}

Widget display(String value, String unit) {
  return Row(
    children: [
      Expanded(
        flex: 6,
        child: FittedBox(
          child: Column(
            children: [
              Text(
                "${value}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "CoreSansBold",
                    fontSize: 3.3 * SizeConfig.heightMultiplier),
              ),
              Text(
                "${unit}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 80, 78, 78),
                    fontFamily: "CoreSansMed",
                    fontSize: 2.1 * SizeConfig.heightMultiplier),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          height: 7.37 * SizeConfig.heightMultiplier,
          child: VerticalDivider(
            color: Colors.black,
            thickness: 3,
          ),
        ),
      ),
    ],
  );
}
