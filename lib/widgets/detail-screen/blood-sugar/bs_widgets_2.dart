import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/blood_sugar_controllers.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/helper/format_Double.dart';
import 'package:health_guardian/screens/detail-screens/blood-sugar/blood_sugar_history_screen.dart';
import 'package:health_guardian/screens/detail-screens/blood-sugar/sugar_graph_report.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';

Widget dataWidget(BloodSugarControllers controller,
    EditBloodSugarDataControllers editController) {
  return Column(
    children: [
      Center(
        child: Text("Blood Sugar (mg/dL)",
            style: TextStyle(
              fontSize: 3.05 * SizeConfig.heightMultiplier,
              color: Colors.black,
              fontFamily: "CoreSansBold",
            )),
      ),
      SizedBox(
        height: 0.84 * SizeConfig.heightMultiplier,
      ),
      Divider(
        color: Color.fromARGB(255, 229, 222, 222),
        thickness: 2,
      ),
      SizedBox(
        height: 1.05 * SizeConfig.heightMultiplier,
      ),

      //* For displaying graph and history
      Obx(() => controller.pageIndex.value == 0
          ? graphData(controller, editController)
          : historyList(editController, () {
              Get.to(() => BloodSugarHistoryScreen(),
                  transition: Transition.rightToLeft);
            })),
    ],
  );
}

Widget graphData(BloodSugarControllers controller,
    EditBloodSugarDataControllers editController) {
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
            size: 2.4 * SizeConfig.heightMultiplier,
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
              : FittedBox(
                child: Text(editController.sugar_report_date[controller.dateIndex.value],
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
            size: 2.4 * SizeConfig.heightMultiplier,
          ),
          onPressed: () => controller.navigatePageDate(editController.sugar_graph_list.length),
          color: Colors.black,
        )
      ],
    ),
    SizedBox(
      height: 2.633 * SizeConfig.heightMultiplier,
    ),
    Obx(
      () => editController.isLoadingGraph.value
          ? SpinKitCircle(
              color: Colours.buttonColorRed,
              size: 40,
            )
          : Container(
              color: Colors.white,
              height: 28.4 * SizeConfig.heightMultiplier,
              width: 91.517 * SizeConfig.widthMultiplier,
              child: PageView(
                controller: controller.pageControllerDate,
                children: List.generate(
                  editController.sugar_graph_list.length,
                  (index) =>  CustomLineChart(
                    list: [editController.sugar_graph_list[index]],
                  ), // pass data if needed
                ),
              ),
            ),
    ),
  ]);
}

Widget historyList(
    EditBloodSugarDataControllers editController, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 1.11 * SizeConfig.widthMultiplier,
      ),
      height: 36.86 * SizeConfig.heightMultiplier,
      child: editController.sugar_data_list.length == 0
          ? Center(
              child: Text(
                "No History Found",
                style:
                    TextStyle(color: Colors.black, fontFamily: "Poppins-Bold"),
              ),
            )
          : ListView.builder(
              itemCount: editController.sugar_data_list.length > 4
                  ? 4
                  : editController.sugar_data_list.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 1.58 * SizeConfig.heightMultiplier,
                      horizontal: 2.67 * SizeConfig.widthMultiplier),
                  margin: EdgeInsets.symmetric(
                      vertical: 0.84 * SizeConfig.heightMultiplier),
                  height: 11.06 * SizeConfig.heightMultiplier,
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
                            child: FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    editController.sugar_data_list[index]
                                            ["isTwoDigit"]
                                        ? doubleDigit(editController
                                                .sugar_data_list[index]
                                            ["sugar_level"])
                                        : tripleDigit(editController
                                                .sugar_data_list[index]
                                            ["sugar_level"]),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "CoreSansBold",
                                        fontSize:
                                            2.4 * SizeConfig.heightMultiplier),
                                  ),
                                  Text(
                                    "mg/dL",
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
                          ),
                          SizedBox(
                            width: 1 * SizeConfig.widthMultiplier,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                height: 7.37 * SizeConfig.heightMultiplier,
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
                              child: statsWidget(
                                  editController.sugar_data_list[index]
                                      ["status"],
                                  editController.sugar_data_list[index]
                                      ["state"],
                                  editController.sugar_data_list[index]["date"],
                                  ColorConvert.colorMap[editController
                                      .sugar_data_list[index]["color"]]!)),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 2.94 * SizeConfig.heightMultiplier,
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

Widget statsWidget(String status, String state, String date, Color color) {
  return Column(
    children: [
      Flexible(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonsDetail1(
                status,
                () {},
                color,
                Colors.white,
                4.74 * SizeConfig.heightMultiplier,
                22.32 * SizeConfig.widthMultiplier,
                0.63 * SizeConfig.heightMultiplier,
                2.00 * SizeConfig.heightMultiplier),
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
        height: 1.05 * SizeConfig.heightMultiplier,
      ),
      Flexible(
        flex: 1,
        child: Text(
          date,
          style: TextStyle(
              color: const Color.fromARGB(255, 80, 78, 78),
              fontFamily: "CoreSansMed",
              fontSize: 1.65 * SizeConfig.heightMultiplier),
        ),
      ),
    ],
  );
}
