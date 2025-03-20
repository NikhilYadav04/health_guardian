import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/detail-screen/blood-sugar/bs_widgets_2.dart';

class HeartRateHistoryScreen extends StatelessWidget {
  const HeartRateHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
       backgroundColor: Color.fromARGB(255, 247, 241, 241),

       //* appBar
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 241, 241),
        toolbarHeight: 8.42*SizeConfig.heightMultiplier,
        centerTitle: true,
        leading:  IconButton(
        onPressed: (){Get.back();},
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 3.58*SizeConfig.heightMultiplier,
        )),
        title: FittedBox(
          child: Text(
            "Heart Rate History",
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
              margin: EdgeInsets.symmetric(vertical: 1.5*SizeConfig.heightMultiplier, horizontal: 2.67*SizeConfig.widthMultiplier),
              height:11.06*SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red,
                        spreadRadius: 2,
                        blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(0.8*SizeConfig.heightMultiplier),
                  color: Color.fromARGB(255, 240, 214, 214)),
              child: Row(children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            " 79",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CoreSansBold",
                                fontSize: 3.3 * SizeConfig.heightMultiplier),
                          ),
                          Text(
                            " bpm",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 80, 78, 78),
                                fontFamily: "CoreSansMed",
                                fontSize: 2.1 * SizeConfig.heightMultiplier),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.60*SizeConfig.heightMultiplier,
                      ),
                      Container(
                          height: 7.37*SizeConfig.heightMultiplier,
                          child: VerticalDivider(
                            color: Colours.buttonColorRed,
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
                      Flexible(flex: 3, child: statsWidget("", "", "")),
                      Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 2.94*SizeConfig.heightMultiplier,
                          )),
                    ],
                  ),
                )
              ]),
            );
          }),
    ));
  }
}