import 'package:flutter/material.dart';
import 'package:health_guardian/helper/color_Convert.dart';
import 'package:health_guardian/helper/format_Double.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class BloodSugarDetailedReport extends StatelessWidget {
  BloodSugarDetailedReport({super.key, required this.list});
  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBarReportDetail("Blood Sugar Report", Images.BSugarPNG),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 1.2 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: 1.5800 * SizeConfig.heightMultiplier,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return reportDisplayWidget(
                        " ${doubleDigit(list[index]["sugar_level"])}",
                        " mgdL",
                        list[index]["date"],
                        ColorConvert.colorMap[list[index]["color"]]!,
                        list[index]["status"]);
                  }),
              SizedBox(
                height: 3.16012 * SizeConfig.heightMultiplier,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
