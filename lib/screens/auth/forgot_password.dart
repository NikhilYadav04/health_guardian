import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/auth/forgot_pass_controllers.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';

class ForgotPassword extends StatelessWidget {
  final ForgotPassControllers controller = Get.put(ForgotPassControllers());

  void reset(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () {
      controller.resetPassword(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 4.3 * SizeConfig.widthMultiplier,
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
              T1("Forgot Password", Images.lockIcon),
              SizedBox(
                height: 1.45 * SizeConfig.heightMultiplier,
              ),
              T2(
                "A password reset link will be sent to your\nentered email address.",
              ),
              SizedBox(
                height: 2.8 * SizeConfig.heightMultiplier,
              ),
              fieldText("Enter your email", controller.controller, Icons.email,
                  TextInputType.emailAddress, controller.emailKey),
              SizedBox(
                height: 52.5 * SizeConfig.heightMultiplier,
              ),
              controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colours.buttonColorRed,
                      ),
                    )
                  : authButton("Send Code", () {
                      if (controller.emailKey.currentState!.validate()) {
                        reset(context);
                      } else {}
                    })
            ],
          ),
        ),
      ),
    ));
  }
}
