import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/dashboard/dashboard_widgets_2.dart';
import 'package:health_guardian/widgets/detail-screen/weight-measure/wm_widgets_2.dart';

class WeightMeasureHistoryScreen extends StatelessWidget {
  const WeightMeasureHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 241, 241),

      //* AppBar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 241, 241),
        toolbarHeight: 8.42*SizeConfig.heightMultiplier,
        centerTitle: true,
        leading:  IconButton(
        onPressed: (){Get.back();},
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size:3.58*SizeConfig.heightMultiplier,
        )),
        title: FittedBox(
          child: Text(
            "Weight Measure History",
            style: TextStyle(
                fontFamily: "CoreSansBold", color: Colors.black, fontSize: 3.58*SizeConfig.heightMultiplier),
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 1.58*SizeConfig.heightMultiplier, horizontal: 2.67*SizeConfig.widthMultiplier),
              margin: EdgeInsets.symmetric(vertical: 1.26*SizeConfig.heightMultiplier, horizontal: 2.67*SizeConfig.widthMultiplier),
              height: 11.06*SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 161, 153, 153),
                        spreadRadius: 2.5,
                        blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(1.05*SizeConfig.heightMultiplier),
                  color: Color.fromARGB(255, 240, 237, 237)),
              child: Row(children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "75.6",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CoreSansBold",
                                fontSize: 3.3 * SizeConfig.heightMultiplier),
                          ),
                          Text(
                            "kg",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 80, 78, 78),
                                fontFamily: "CoreSansMed",
                                fontSize: 2.1 * SizeConfig.heightMultiplier),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.10*SizeConfig.heightMultiplier,
                      ),
                      Container(
                          height: 7.37*SizeConfig.heightMultiplier,
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
                      Flexible(flex: 3, child: statsWidgetWeightMeasure("", "", "")),
                      Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 2.94*SizeConfig.heightMultiplier,
                          )),
                    ],
                  ),
                )
              ]),
            );
          }),
     //*Button For Submitting Report
      floatingActionButton: SizedBox(
        height: 70, width: 175,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(25),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: ReportButton(
            "Store Report",() {}, Colours.buttonColorRed, Colors.white,0,0,25,23,
          ),
        ),
      ),
    ));
  }
}