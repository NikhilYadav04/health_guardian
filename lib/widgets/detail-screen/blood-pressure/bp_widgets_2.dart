import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/blood_pressure_controllers.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/screens/detail-screens/blood-pressure/blood_pressure_history_screen.dart';
import 'package:health_guardian/screens/detail-screens/blood-pressure/pressure_graph_report.dart';
// ignore: unused_import
import 'package:health_guardian/screens/detail-screens/blood-sugar/sugar_graph_report.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';

Widget dataWidgetBP(BloodPressureControllers controller,
    EditBloodPressureDataControllers editController) {
  return Column(
    children: [
      Center(
        child: Text("Blood Pressure (mmHg)",
            style: TextStyle(
              fontSize: 3.054 * SizeConfig.heightMultiplier,
              color: Colors.black,
              fontFamily: "CoreSansBold",
            )),
      ),
      SizedBox(
        height: 0.842 * SizeConfig.heightMultiplier,
      ),
      Divider(
        color: Color.fromARGB(255, 229, 222, 222),
        thickness: 2,
      ),
      SizedBox(
        height: 1.053 * SizeConfig.heightMultiplier,
      ),

      //* For displaying graph and history
      Obx(() => controller.pageIndex.value == 0
          ? graphDataBP(controller, editController)
          : historyListBP(editController, () {
              Get.to(() => BloodPressureHistoryScreen(),
                  transition: Transition.rightToLeft);
            })),
    ],
  );
}

Widget graphDataBP(BloodPressureControllers controller,
    EditBloodPressureDataControllers editController) {
  return Column(children: [
    SizedBox(
      height: 0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 2.528 * SizeConfig.heightMultiplier,
          ),
          onPressed: controller.previousPageDate,
          color: Colors.black,
        ),
        Obx(
          () => editController.isLoadingGraph.value
              ? SpinKitCircle(
                  color: Colours.buttonColorRed,
                  size: 40,
                )
              : editController.bp_graph_list.length==0 ? Center(child: Text("NO DATA"),) : FittedBox(
                  child: Text(
                      editController.bp_report_date[controller.dateIndex.value],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 2.25 * SizeConfig.heightMultiplier,
                          color: Colors.black,
                          fontFamily: "Poppins-Med",
                          fontWeight: FontWeight.bold)),
                ),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 2.528 * SizeConfig.heightMultiplier,
          ),
          onPressed: () =>
              controller.navigatePageDate(editController.bp_graph_list.length),
          color: Colors.black,
        )
      ],
    ),
    SizedBox(
      height: 3.5 * SizeConfig.heightMultiplier,
    ),
    Obx(
      () => editController.isLoadingGraph.value
          ? SpinKitCircle(
              color: Colours.buttonColorRed,
              size: 40,
            )
          : Container(
              color: Colors.white,
              height: 28 * SizeConfig.heightMultiplier,
              width: 91.517 * SizeConfig.widthMultiplier,
              child: PageView(
                controller: controller.pageControllerDate,
                children: List.generate(
                  editController.bp_graph_list.length,
                  (index) => BarChartExample(
                    list: [editController.bp_graph_list[index]],
                  ), // pass data if needed
                ),
              ),
            ),
    ),
    SizedBox(
      height: 2.106 * SizeConfig.heightMultiplier,
    ),
    FittedBox(
      child: Text("Systolic Pressure, Diastolic Pressure",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 21.5 * SizeConfig.heightMultiplier,
              color: Colors.black,
              fontFamily: "Poppins-Med",
              fontWeight: FontWeight.bold)),
    ),
    SizedBox(
      height: 2.633 * SizeConfig.heightMultiplier,
    ),
  ]);
}

Widget historyListBP(
    EditBloodPressureDataControllers editController, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: editController.bp_data_list.length == 0
        ? Center(
            child: Text(
              "No History Found",
              style: TextStyle(color: Colors.black, fontFamily: "Poppins-Bold"),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: 1.116 * SizeConfig.widthMultiplier,
            ),
            height: 36.869 * SizeConfig.heightMultiplier,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: editController.bp_data_list.length > 4
                    ? 4
                    : editController.bp_data_list.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.580 * SizeConfig.heightMultiplier,
                        horizontal: 3 * SizeConfig.widthMultiplier),
                    margin: EdgeInsets.symmetric(
                        vertical: 0.842 * SizeConfig.heightMultiplier),
                    height: 12.0604 * SizeConfig.heightMultiplier,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            1.05 * SizeConfig.heightMultiplier),
                        color: Color.fromARGB(255, 240, 237, 237)),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    editController.bp_data_list[index]
                                            ["diastolic"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "CoreSansBold",
                                        fontSize:
                                            3.3 * SizeConfig.heightMultiplier),
                                  ),
                                  Text(
                                    "mmHg",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 80, 78, 78),
                                        fontFamily: "CoreSansMed",
                                        fontSize:
                                            2.1 * SizeConfig.heightMultiplier),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: 4.464 * SizeConfig.widthMultiplier,
                            // ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 7.373 * SizeConfig.heightMultiplier,
                                  child: VerticalDivider(
                                    color: Color.fromARGB(255, 229, 222, 222),
                                    thickness: 3,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 4,
                                child: statsWidgetBP(
                                    editController.bp_data_list[index]
                                        ["status"],
                                    editController.bp_data_list[index]["state"],
                                    editController.bp_data_list[index]["date"],
                                    ColorConvert.colorMap[editController
                                        .bp_data_list[index]["color"]]!)),
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 2.949 * SizeConfig.heightMultiplier,
                                )),
                          ],
                        ),
                      )
                    ]),
                  );
                }),
          ),
  );
}

Widget statsWidgetBP(String status, String state, String date, Color color) {
  return Column(
    children: [
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonsDetail1(
                status,
                () {},
                color,
                Colors.white,
                4.740 * SizeConfig.heightMultiplier,
                22.321 * SizeConfig.widthMultiplier,
                0.632 * SizeConfig.heightMultiplier,
                2.001 * SizeConfig.heightMultiplier),
            Text(
              state,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "CoreSansBold",
                  fontSize: 2.6 * SizeConfig.heightMultiplier),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 0.6 * SizeConfig.heightMultiplier,
      ),
      Expanded(
        flex: 1,
        child: Text(
          date,
          style: TextStyle(
              color: const Color.fromARGB(255, 80, 78, 78),
              fontFamily: "CoreSansMed",
              fontSize: 1.7 * SizeConfig.heightMultiplier),
        ),
      ),
    ],
  );
}
