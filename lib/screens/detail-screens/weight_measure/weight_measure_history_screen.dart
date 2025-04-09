import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/weight_measure_controllers.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/helper/format_Double.dart';
import 'package:health_guardian/screens/detail-screens/heart-rate/heart_rate_history_screen.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:health_guardian/widgets/detail-screen/weight-measure/wm_widgets_2.dart';

class WeightMeasureHistoryScreen extends StatelessWidget {
  WeightMeasureHistoryScreen({super.key});
  final EditWeightMeasureDataController editController =
      Get.find<EditWeightMeasureDataController>();

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
              "Your weight data can be stored in a report up to the current day.",
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
            "Weight Measure History",
            style: TextStyle(
                fontFamily: "CoreSansBold",
                color: Colors.black,
                fontSize: 3.58 * SizeConfig.heightMultiplier),
          ),
        ),
      ),

      body: StreamBuilder(
          stream: editController.fetchWeightDataStream(context),
          builder: (context, AsyncSnapshot snapshot) {
            return ListView.builder(
                itemCount: editController.weight_data_list.length,
                itemBuilder: (context, index) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitCircle(
                      color: Colours.buttonColorRed,
                      size: 50,
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: noData);
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: noData);
                  } else {
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
                                color: Color.fromARGB(255, 161, 153, 153),
                                spreadRadius: 2.5,
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
                                              3 * SizeConfig.heightMultiplier),
                                    ),
                                    Text(
                                      "kg",
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
                                width: 0.5 * SizeConfig.heightMultiplier,
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
                                  child: statsWidgetWeightMeasure(
                                      editController.weight_data_list[index]
                                          ["status"],
                                      editController.weight_data_list[index]
                                          ["date"],
                                      ColorConvert.colorMap[editController
                                          .weight_data_list[index]["color"]]!)),
                              Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () =>
                                        editController.deleteHistoryRecord(
                                            context,
                                            editController
                                                    .weight_data_list[index]
                                                ["date"]),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                      size: 2.94 * SizeConfig.heightMultiplier,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ]),
                    );
                  }
                });
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
                height: 7.37359 * SizeConfig.heightMultiplier,
                width: 39.0625 * SizeConfig.widthMultiplier,
                child: InkWell(
                  onTap: () {
                    editController.generateWeightDataReport(context);
                  },
                  borderRadius: BorderRadius.circular(
                      2.633436 * SizeConfig.heightMultiplier),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: ReportButton(
                    "Store Report",
                    () {},
                    Colours.buttonColorRed,
                    Colors.white,
                    0,
                    0,
                    2.633427 * SizeConfig.heightMultiplier,
                    2.42276 * SizeConfig.heightMultiplier,
                  ),
                ),
              ),
      ),
    ));
  }
}
