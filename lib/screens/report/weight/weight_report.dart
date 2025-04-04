import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/detail-screen/weight_measure_controllers.dart';
import 'package:health_guardian/screens/report/weight/weight_detailed_report.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class WeightReport extends StatelessWidget {
  WeightReport({super.key});

  final EditWeightMeasureDataController editController =
      Get.put(EditWeightMeasureDataController());

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
      appBar: appBarReport("Report List", Images.weightPNG),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.6785 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: 1.5800 * SizeConfig.heightMultiplier,
              ),
              StreamBuilder(
                  stream: editController.getReportData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: editController.weight_report_list.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(

                            //* navigate to detail page
                            onTap:  () => Get.to(
                              () => WeightDetailedReport(
                                    list:
                                        editController.weight_report_list[index]["weight_report"],
                                  ),
                              transition: Transition.rightToLeft),

                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.3693 * SizeConfig.heightMultiplier),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 162, 150, 39),
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      0.8426 * SizeConfig.heightMultiplier),
                                  color: Color.fromARGB(255, 247, 244, 204)),
                              height: 9.48037 * SizeConfig.heightMultiplier,
                              child: Center(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 3.16012 * SizeConfig.heightMultiplier,
                                    backgroundColor:
                                        Color.fromARGB(255, 232, 222, 115),
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
                                      "Submitted On : ${editController.weight_report_list[index]["submitted_on"]}",
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
                        });
                  }),
              SizedBox(
                height: 2.106748 * SizeConfig.heightMultiplier,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
