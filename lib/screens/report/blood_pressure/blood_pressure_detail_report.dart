import 'package:flutter/material.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class BloodPressureDetailReport extends StatelessWidget {
  const BloodPressureDetailReport({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
      appBar: appBarReportDetail("Blood Pressure Report", Images.bloodPressurePNG),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 1.2 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                  height: 1.5800*SizeConfig.heightMultiplier,
                ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context,index){
                  return reportDisplayWidgetPressure("98","mmhg","Dec 22, 2024 : 10:54 AM",Colors.green,"Normal");
                }
                ),

              SizedBox(height: 3.16012*SizeConfig.heightMultiplier,)
            ],
          ),
        ),
      ),
    ));
  }
}