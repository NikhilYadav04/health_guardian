import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/auth/login_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';

// ignore: must_be_immutable
class SetPinScreen extends StatelessWidget {
  final CreateAccountController controller = Get.put(CreateAccountController());

  final String email;
  SetPinScreen({super.key, required this.email});

  void setPin(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () async {
      controller.setAppPin(context, email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 4 * SizeConfig.widthMultiplier,
                  vertical: 2.10 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 4.00 * SizeConfig.heightMultiplier,
                        )),
                  ),
                  SizedBox(
                    height: 3.16 * SizeConfig.heightMultiplier,
                  ),
                  T1(
                    "Create App Pin",
                    Images.otpIcon,
                  ),
                  SizedBox(
                    height: 1.45 * SizeConfig.heightMultiplier,
                  ),
                  T2(
                    "Create a 4-digit login PIN for your app\nto login.",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.5 * SizeConfig.heightMultiplier,
            ),
            OTPfield(controller.AppPinController),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 4.91 * SizeConfig.widthMultiplier),
              child: Column(
                children: [
                  SizedBox(
                    height: 4.21 * SizeConfig.heightMultiplier,
                  ),
                  FittedBox(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      "Always remember your app pin for login",
                      style: TextStyle(
                          color: Colours.buttonColorRed,
                          fontFamily: "CoreSansLight",
                          fontWeight: FontWeight.bold,
                          fontSize: 2.25 * SizeConfig.heightMultiplier),
                    ),
                  ),
                  SizedBox(
                    height: 42.5 * SizeConfig.heightMultiplier,
                  ),
                  controller.isLoadingPin.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colours.buttonColorRed,
                          ),
                        )
                      : authButton("Continue", () {
                          controller.setAppPin(context, email);
                        }),
                  SizedBox(
                    height: 1.5 * SizeConfig.heightMultiplier,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
