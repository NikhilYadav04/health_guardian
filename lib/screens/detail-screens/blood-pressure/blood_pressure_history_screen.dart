import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/detail-screen/blood_pressure_controllers.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/screens/detail-screens/heart-rate/heart_rate_history_screen.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class BloodPressureHistoryScreen extends StatelessWidget {
  BloodPressureHistoryScreen({super.key});

  final EditBloodPressureDataControllers editController =
      Get.find<EditBloodPressureDataControllers>();

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

      body: StreamBuilder(
          stream: editController.fetchBPDataStream(),
          builder: (context, AsyncSnapshot snapshot) {
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
              return ListView.builder(
                  itemCount: editController.bp_data_list.length,
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
                          borderRadius: BorderRadius.circular(
                              0.8 * SizeConfig.heightMultiplier),
                          color: Color.fromARGB(255, 237, 228, 228)),
                      child: Column(children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            editController.bp_data_list[index]["status"],
                            style: TextStyle(
                                color: Colors.grey.shade900,
                                fontFamily: "CoreSansBold",
                                fontSize: 2.8 * SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 1.053 * SizeConfig.heightMultiplier,
                        ),
                        Flexible(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: display(
                                        editController.bp_data_list[index]
                                                ["systolic"]
                                            .toStringAsFixed(2),
                                        "systolic")),
                                Expanded(
                                    flex: 1,
                                    child: display(
                                        editController.bp_data_list[index]
                                                ["diastolic"]
                                            .toStringAsFixed(2),
                                        "diastolic")),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          editController.bp_data_list[index]
                                                  ["pulse"]
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "CoreSansBold",
                                              fontSize: 3.3 *
                                                  SizeConfig.heightMultiplier),
                                        ),
                                        Text(
                                          "Pulse",
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
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 1.9 * SizeConfig.heightMultiplier,
                        ),
                        Flexible(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  editController.bp_data_list[index]["date"],
                                  style: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontFamily: "CoreSansMed",
                                      fontSize:
                                          2.1 * SizeConfig.heightMultiplier),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: buttonsDetail1(
                                    editController.bp_data_list[index]
                                        ["status"],
                                    () {},
                                    ColorConvert.colorMap[editController
                                        .bp_data_list[index]["color"]]!,
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
                height: 7.37359 * SizeConfig.heightMultiplier,
                width: 39.0625 * SizeConfig.widthMultiplier,
                child: InkWell(
                  onTap: () {
                    editController.generateReportBPDate(context);
                  },
                  borderRadius: BorderRadius.circular(2.633436 * SizeConfig.heightMultiplier),
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
