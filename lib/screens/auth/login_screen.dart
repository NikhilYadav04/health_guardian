import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/auth/login_controllers.dart';
import 'package:health_guardian/screens/auth/forgot_password.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/auth/login_widgets.dart';

class LoginScreen extends StatelessWidget {
  final LoginAccountController controller = Get.put(LoginAccountController());

  void login(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () async {
      controller.loginAccount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 4.5 * SizeConfig.widthMultiplier,
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
                height: 2 * SizeConfig.heightMultiplier,
              ),
              T1(
                "Welcome Back!",
                Images.welcomeIcon,
              ),
              SizedBox(
                height: 1.45 * SizeConfig.heightMultiplier,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: T2(
                  "Login to continue your health journey.",
                ),
              ),
              SizedBox(
                height: 5.21 * SizeConfig.heightMultiplier,
              ),
              Authtext(
                "Email",
              ),
              SizedBox(
                height: 1.9 * SizeConfig.heightMultiplier,
              ),
              fieldText(
                  "Enter your email",
                  controller.emailController,
                  Icons.email_outlined,
                  TextInputType.emailAddress,
                  controller.emailKey),
              SizedBox(
                height: 3.16 * SizeConfig.heightMultiplier,
              ),
              Authtext(
                "Password",
              ),
              SizedBox(
                height: 1.9 * SizeConfig.heightMultiplier,
              ),
              Form(
                key: controller.PasswordKey,
                child: Obx(
                  () => TextFormField(
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return 'This field cannot be empty';
                      } else {
                        if (GetUtils.isLengthLessThan(value.toString(), 6)) {
                          return 'Password length should be minimum 6 characters!';
                        }
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 49, 49),
                      fontFamily: "CoreSansLight",
                      fontSize: 2.31 * SizeConfig.heightMultiplier,
                    ),
                    obscureText: controller.isVisible.value,
                    controller: controller.passwordController,
                    decoration: fieldPasswordDecoration(
                      "Enter your password",
                      Icons.lock_outline,
                    ).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color.fromARGB(255, 51, 49, 49),
                          size: 2.63 * SizeConfig.heightMultiplier,
                        ),
                        onPressed: () {
                          controller.isVisible.value =
                              !controller.isVisible.value;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              forgotPassWidget(() {
                Get.to(() => ForgotPassword(),
                    transition: Transition.rightToLeft);
              }),
              SizedBox(
                height: 25,
              ),
              createText(),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 18 * SizeConfig.heightMultiplier,
              ),
              controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colours.buttonColorRed,
                      ),
                    )
                  : authButton(
                      "Sign in",
                      () {
                        if (controller.emailKey.currentState!.validate() &&
                            controller.PasswordKey.currentState!.validate()) {
                          login(context);
                        } else {}
                      },
                    ),
              SizedBox(
                height: 1.7 * SizeConfig.heightMultiplier,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
