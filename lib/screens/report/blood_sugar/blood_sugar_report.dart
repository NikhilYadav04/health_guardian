import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/screens/report/blood_sugar/blood_sugar_detailed_report.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/report/report_widgets.dart';

class BloodSugarReport extends StatelessWidget {
  const BloodSugarReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 0.84269*SizeConfig.heightMultiplier),
            child: Text(
              "Click on any date to view detailed report",
              style: TextStyle(fontSize: 2.1067*SizeConfig.heightMultiplier, fontFamily: "Poppins-Med"),
            ))
      ],
      appBar: appBarReport("Report List", Images.BSugarPNG),
      backgroundColor: Color.fromARGB(255, 247, 241, 241),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.6785*SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: 1.5800*SizeConfig.heightMultiplier,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 7,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(

                      //* navigate to detailed screen
                      onTap: ()=>Get.to(()=>BloodSugarDetailedReport(),transition: Transition.rightToLeft),

                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.5800*SizeConfig.heightMultiplier),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red,
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(0.8426*SizeConfig.heightMultiplier),
                            color: Color.fromARGB(255, 246, 226, 226)),
                        height: 9.48037*SizeConfig.heightMultiplier,
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius:3.16012*SizeConfig.heightMultiplier,
                              backgroundColor: Color.fromARGB(255, 239, 185, 181),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      fontFamily: "CoreSansBold",
                                      fontSize: 2.8441*SizeConfig.heightMultiplier,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            title: FittedBox(
                              child: Text(
                                "Submitted On : 16 Dec 2024",
                                style: TextStyle(
                                    fontFamily: "CoreSansBold",
                                    fontSize: 1.68539*SizeConfig.heightMultiplier,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height:  2.106748*SizeConfig.heightMultiplier,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
