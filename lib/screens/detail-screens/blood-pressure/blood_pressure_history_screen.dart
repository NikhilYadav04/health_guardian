import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:health_guardian/widgets/detail-screen/blood-pressure/bp_widgets_2.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class BloodPressureHistoryScreen extends StatelessWidget {
  const BloodPressureHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 241, 241),

      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 1.5625 * SizeConfig.widthMultiplier,
                vertical: 0.84269 * SizeConfig.heightMultiplier),
            child: Text(
              "Your blood pressure data can be stored in a report up to the current day.",
              style: TextStyle(
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontFamily: "Poppins-Med"),
            ))
      ],

      //* AppBar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 241, 241),
        toolbarHeight: 8.42 * SizeConfig.heightMultiplier,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 3.58 * SizeConfig.heightMultiplier,
            )),
        title: FittedBox(
          child: Text(
            "Blood Pressure History",
            style: TextStyle(
                fontFamily: "CoreSansBold",
                color: Colors.black,
                fontSize: 3.16 * SizeConfig.heightMultiplier),
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: 1.58 * SizeConfig.heightMultiplier,
                  horizontal: 2.67 * SizeConfig.widthMultiplier),
              margin: EdgeInsets.symmetric(
                  vertical: 1.5 * SizeConfig.heightMultiplier,
                  horizontal: 2.67 * SizeConfig.widthMultiplier),
              height: 22 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade900,
                        spreadRadius: 3,
                        blurRadius: 2)
                  ],
                  borderRadius:
                      BorderRadius.circular(0.8 * SizeConfig.heightMultiplier),
                  color: Color.fromARGB(255, 237, 228, 228)),
              child: Column(children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "Before Eating",
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontFamily: "CoreSansBold",
                        fontSize: 2.8 * SizeConfig.heightMultiplier),
                  ),
                ),
                SizedBox(height: 1.053*SizeConfig.heightMultiplier,),
                Flexible(
                    flex: 5,
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
                                      fontSize:
                                          3.3 * SizeConfig.heightMultiplier),
                                ),
                                Text(
                                  "pulse",
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 80, 78, 78),
                                      fontFamily: "CoreSansMed",
                                      fontSize:
                                          2.1 * SizeConfig.heightMultiplier),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 1.5800 * SizeConfig.heightMultiplier,
                ),
                Flexible(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Dec 22, 2024 : 10:54 AM",
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontFamily: "CoreSansMed",
                              fontSize: 2 * SizeConfig.heightMultiplier),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: buttonsDetail1(
                            "Hyper",
                            () {},
                            Colors.red,
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
          }),

      //*Button For Submitting Report
      floatingActionButton: SizedBox(
        height: 70,
        width: 175,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(25),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: ReportButton(
            "Store Report",
            () {},
            Colours.buttonColorRed,
            Colors.white,
            0,
            0,
            25,
            23,
          ),
        ),
      ),
    ));
  }
}
