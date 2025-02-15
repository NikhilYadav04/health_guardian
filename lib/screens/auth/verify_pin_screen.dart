// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:health_guardian/getX_controllers/auth/login_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';

// ignore: must_be_immutable
class VerifyPinScreen extends StatelessWidget {
  final LoginAccountController controller = Get.put(LoginAccountController());

  final String status;
  VerifyPinScreen({
    Key? key,
    required this.status,
  }) : super(key: key);

  void submit(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () {
      controller.verifyCode(context);
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
                  status == "Login"
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 4.00 * SizeConfig.heightMultiplier,
                              )),
                        )
                      : Center(child: Image.asset("assets/splash/heart_red.png",height: 50,width: 50,),),
                  SizedBox(
                    height: 3.16 * SizeConfig.heightMultiplier,
                  ),
                  T1(
                    "Enter App Pin",
                    Images.otpIcon,
                  ),
                  SizedBox(
                    height: 1.45 * SizeConfig.heightMultiplier,
                  ),
                  T2(
                    "Enter the 4-digit login PIN of your app to\ncontinue.",
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
                    height: 4.7 * SizeConfig.heightMultiplier,
                  ),
                  forgetPin(),
                  SizedBox(
                    height: 42.5 * SizeConfig.heightMultiplier,
                  ),
                  controller.isLoadingPin.value
                      ? CircularProgressIndicator(
                          color: Colours.buttonColorRed,
                        )
                      : authButton("Continue", () {
                          if (controller.AppPinController.text.length < 4) {
                            toastErrorSlide(
                                context, "Pin length must be of 4 characters");
                          } else {
                            submit(context);
                          }
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
