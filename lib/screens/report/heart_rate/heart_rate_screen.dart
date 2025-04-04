import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/detail-screen/heart_rate_controllers.dart';
import 'package:health_guardian/screens/report/heart_rate/heart_rate_detailed_report.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class HeartRateScreen extends StatelessWidget {
  HeartRateScreen({super.key});
  final EditHeartRateDataController editController =
      Get.put(EditHeartRateDataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.84269 * SizeConfig.heightMultiplier),
            child: Text(
              "Click on any date to view detailed report",
              style: TextStyle(
                  fontSize: 2.1067 * SizeConfig.heightMultiplier,
                  fontFamily: "Poppins-Med"),
            ))
      ],
      appBar: appBarReport("Report List", Images.heartPNG),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: editController.getHeartReportData(),
            builder: (context, AsyncSnapshot snapshot) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 2.6785 * SizeConfig.widthMultiplier),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.5800 * SizeConfig.heightMultiplier,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: editController.heart_report_list.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(

                            //* navigate to detail page
                            onTap: () => Get.to(
                              () => HeartRateDetailedReport(
                                    list:
                                        editController.heart_report_list[index]["heart_report"],
                                  ),
                              transition: Transition.rightToLeft),

                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      1.5800 * SizeConfig.heightMultiplier),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      0.8426 * SizeConfig.heightMultiplier),
                                  color: Color.fromARGB(255, 246, 226, 226)),
                              height: 9.48037 * SizeConfig.heightMultiplier,
                              child: Center(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius:
                                        3.16012 * SizeConfig.heightMultiplier,
                                    backgroundColor:
                                        Color.fromARGB(255, 239, 185, 181),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            fontFamily: "CoreSansBold",
                                            fontSize: 2.8441 *
                                                SizeConfig.heightMultiplier,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  title: FittedBox(
                                    child: Text(
                                      "Submitted On : ${editController.heart_report_list[index]["submitted_on"]}",
                                      style: TextStyle(
                                          fontFamily: "CoreSansBold",
                                          fontSize: 1.68539 *
                                              SizeConfig.heightMultiplier,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 2.106748 * SizeConfig.heightMultiplier,
                    )
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
