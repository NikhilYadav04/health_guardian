import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/helper/format_Double.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_2.dart';

class HeartRateHistoryScreen extends StatelessWidget {
  HeartRateHistoryScreen({super.key});

  final EditHeartRateDataController editController =
      Get.find<EditHeartRateDataController>();

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
                "Your heart rate data can be stored in a report up to the current day.",
                style: TextStyle(
                    fontSize: 2 * SizeConfig.heightMultiplier,
                    fontFamily: "Poppins-Med"),
              ))
        ],

        //* appBar
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
              "Heart Rate History",
              style: TextStyle(
                  fontFamily: "CoreSansBold",
                  color: Colors.black,
                  fontSize: 3.58 * SizeConfig.heightMultiplier),
            ),
          ),
        ),

        body: StreamBuilder(
            stream: editController.fetchHeartData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitCircle(
                  color: Colours.buttonColorRed,
                  size: 50,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: noData,
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: noData);
              } else {
                return ListView.builder(
                    itemCount: editController.heart_data_list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.58 * SizeConfig.heightMultiplier,
                            horizontal: 2.67 * SizeConfig.widthMultiplier),
                        margin: EdgeInsets.symmetric(
                            vertical: 1.26 * SizeConfig.heightMultiplier,
                            horizontal: 2.67 * SizeConfig.widthMultiplier),
                        height: 11.06 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red,
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(
                                1.05 * SizeConfig.heightMultiplier),
                            color: Color.fromARGB(255, 240, 237, 237)),
                        child: Row(children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                FittedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        editController.heart_data_list[index]
                                                ["isTwoDigit"]
                                            ? doubleDigit(editController
                                                    .heart_data_list[index]
                                                ["heart_level"])
                                            : tripleDigit(editController
                                                    .heart_data_list[index]
                                                ["heart_level"]),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "CoreSansBold",
                                            fontSize: 3.1 *
                                                SizeConfig.heightMultiplier),
                                      ),
                                      Text(
                                        "mg/dL",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 80, 78, 78),
                                            fontFamily: "CoreSansMed",
                                            fontSize: 2.1 *
                                                SizeConfig.heightMultiplier),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 0.2 * SizeConfig.heightMultiplier,
                                ),
                                Container(
                                    height: 7.37 * SizeConfig.heightMultiplier,
                                    child: VerticalDivider(
                                      color: Color.fromARGB(255, 229, 222, 222),
                                      thickness: 3,
                                    )),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 3,
                                    child: statsWidget(
                                        editController.heart_data_list[index]
                                                ["status"]
                                            .toString(),
                                        editController.heart_data_list[index]
                                                ["state"]
                                            .toString(),
                                        editController.heart_data_list[index]
                                                ["date"]
                                            .toString(),
                                        ColorConvert.colorMap[editController
                                            .heart_data_list[index]["color"]
                                            .toString()]!)),
                                Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () =>
                                          editController.deleteHistoryRecord(
                                              context,
                                              editController
                                                      .heart_data_list[index]
                                                  ["date"]),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                        size:
                                            2.94 * SizeConfig.heightMultiplier,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ]),
                      );
                    });
              }
            }),

        //*Button For Submitting Report

        floatingActionButton: Obx(
          () => editController.isLoadingReport.value
              ? FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colours.buttonColorRed,
                  child: SpinKitCircle(color: Colors.white, size: 24),
                )
              : SizedBox(
                  height: 70,
                  width: 175,
                  child: InkWell(
                    onTap: () {
                      editController.generateHeartReport(context);
                    },
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
        ),
      ),
    );
  }
}

final noData = Text(
  "NO History Found",
  style:
      TextStyle(color: Colors.black, fontSize: 24, fontFamily: "Poppins-Bold"),
);
