import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/weight_measure_controllers.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/helper/format_Double.dart';
import 'package:health_guardian/screens/detail-screens/weight_measure/weight_measure_graph.dart';
import 'package:health_guardian/screens/detail-screens/weight_measure/weight_measure_history_screen.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';

Widget dataWidgetWeightMeasure(WeightMeasureControllers controller,
    EditWeightMeasureDataController editController) {
  return Column(
    children: [
      Center(
        child: Text("Weight (kg)",
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
          ? graphDataWeightMeasure(controller)
          : historyListWeightMeasure(editController, () {
              Get.to(() => WeightMeasureHistoryScreen(),
                  transition: Transition.rightToLeft);
            })),
    ],
  );
}

Widget graphDataWeightMeasure(WeightMeasureControllers controller) {
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
        Text("Dec 16 - Dec 22, 2024",
            style: TextStyle(
                fontSize: 2.317 * SizeConfig.heightMultiplier,
                color: Colors.black,
                fontFamily: "Poppins-Med",
                fontWeight: FontWeight.bold)),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 2.528 * SizeConfig.heightMultiplier,
          ),
          onPressed: controller.navigatePageDate,
          color: Colors.black,
        )
      ],
    ),
    SizedBox(
      height: 0,
    ),
    Container(
      color: Colors.white,
      height: 31 * SizeConfig.heightMultiplier,
      width: 91.517 * SizeConfig.widthMultiplier,
      child: PageView(
        controller: controller.pageController,
        children: [
          CustomBarChart(),
          CustomBarChart(),
        ],
      ),
    ),
  ]);
}

Widget historyListWeightMeasure(
    EditWeightMeasureDataController editController, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: editController.weight_data_list.length == 0
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
                itemCount: editController.weight_data_list.length > 4
                    ? 4
                    : editController.weight_data_list.length,
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
                              child: FittedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      editController.weight_data_list[index]
                                              ["isTwoDigit"]
                                          ? doubleDigit(editController
                                                  .weight_data_list[index]
                                              ["weight_level"])
                                          : tripleDigit(editController
                                                  .weight_data_list[index]
                                              ["weight_level"]),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "CoreSansBold",
                                          fontSize:
                                              3.3 * SizeConfig.heightMultiplier),
                                    ),
                                    Text(
                                      "kg",
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
                                child: statsWidgetWeightMeasure(
                                    editController.weight_data_list[index]
                                        ["status"],
                                    editController.weight_data_list[index]
                                        ["date"],
                                    ColorConvert.colorMap[editController
                                        .weight_data_list[index]["color"]]!)),
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

Widget statsWidgetWeightMeasure(String status, String date, Color color) {
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
              "BMI 21.6",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "CoreSansBold",
                  fontSize: 2.3 * SizeConfig.heightMultiplier),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 1.05 * SizeConfig.heightMultiplier,
      ),
      Expanded(
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
