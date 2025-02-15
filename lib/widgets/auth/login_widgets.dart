import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_guardian/getX_controllers/button/button_controllers.dart';
import 'package:health_guardian/screens/auth/create_account_screen.dart';
import 'package:health_guardian/screens/auth/login_screen.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:pinput/pinput.dart';

final ButtonControllers controller = Get.put(ButtonControllers());

Widget T1(String title, String image) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "CoreSansBold",
            fontSize: 3.8 * SizeConfig.heightMultiplier),
      ),
      SizedBox(
        width: 2.23 * SizeConfig.widthMultiplier,
      ),
      SvgPicture.asset(
        image,
        height: 4.74 * SizeConfig.heightMultiplier,
        width: 11.40 * SizeConfig.widthMultiplier,
      )
    ],
  );
}

Widget T2(String title) {
  return FittedBox(
    child: Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      title,
      style: TextStyle(
          color: Color.fromARGB(255, 99, 92, 92),
          fontFamily: "CoreSansLight",
          fontWeight: FontWeight.bold,
          fontSize: 2.38 * SizeConfig.heightMultiplier),
    ),
  );
}

Widget Authtext(String text) {
  return Row(
    children: [
      Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "CoreSansMed",
            fontWeight: FontWeight.bold,
            fontSize: 2.63 * SizeConfig.heightMultiplier),
      ),
    ],
  );
}

Widget fieldText(String text, TextEditingController controller, IconData icon,
    TextInputType type, GlobalKey<FormState> key) {
  return Form(
    key: key,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'This field cannot be empty';
        } else if (type == TextInputType.name) {
          if (!GetUtils.isEmail(value.toString())) {
            return 'Enter a valid email!';
          }
        } else if (type == TextInputType.phone) {
          if (!GetUtils.isLengthEqualTo(value.toString(), 10)) {
            return 'Phone Number should be 10 digits only.';
          }
        }
        return null;
      },
      keyboardType: type,
      style: TextStyle(
          color: Color.fromARGB(255, 51, 49, 49),
          fontFamily: "CoreSansLight",
          fontSize: 2.31 * SizeConfig.heightMultiplier),
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0x66D9D9D9),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x66D9D9D9))),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(0.80 * SizeConfig.heightMultiplier)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.symmetric(
              vertical: 2.10 * SizeConfig.heightMultiplier),
          label: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 49, 49),
                    fontFamily: "CoreSansLight",
                    fontSize: 2.31 * SizeConfig.heightMultiplier),
              ),
            ],
          ),
          prefixIcon: Icon(
            icon,
            size: 2.52 * SizeConfig.heightMultiplier,
            color: Color.fromARGB(255, 51, 49, 49),
          )),
    ),
  );
}

InputDecoration fieldPasswordDecoration(String text, IconData icon) {
  return InputDecoration(
      filled: true,
      fillColor: Color(0x66D9D9D9),
      errorStyle: TextStyle(fontSize: 1.790 * SizeConfig.heightMultiplier),
      // errorText: value
      //   ? null
      //   : " Password must be at least 6 characters",
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Color(0x66D9D9D9))),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.circular(0.84 * SizeConfig.heightMultiplier)),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding:
          EdgeInsets.symmetric(vertical: 2.10 * SizeConfig.heightMultiplier),
      label: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 49, 49),
                fontFamily: "CoreSansLight",
                fontSize: 2.31 * SizeConfig.heightMultiplier),
          ),
        ],
      ),
      prefixIcon: Icon(
        icon,
        size: 2.52 * SizeConfig.heightMultiplier,
        color: Color.fromARGB(255, 51, 49, 49),
      ));
}

Widget authButton(String text, void Function() onTap) {
  return GestureDetector(
    onTapDown: (_) {
      controller.setPressed(true); //* Shrink the button when pressed
    },
    onTapUp: (_) {
      controller.setPressed(
          false); //* Return to original size when the tap is released
    },

    //* onTap is used to navigate to other screen
    onTap: onTap,
    child: Obx(
      () => TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 100),
        tween: Tween<double>(
          begin: 1.0,
          end: controller.isPressed.value ? 0.93 : 1.0,
        ),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: double.infinity,
              height: 6.32 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                      3.37 * SizeConfig.heightMultiplier)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: "CoreSansMed",
                      fontSize: 2.8 * SizeConfig.heightMultiplier),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget T3(String text1, String text2, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
                color: Colors.white,
                fontFamily: "CoreSansBold",
                fontSize: 2.40 * SizeConfig.heightMultiplier)
            .copyWith(color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: TextStyle(
                    color: Colors.white,
                    fontFamily: "CoreSansBold",
                    fontSize: 2.40 * SizeConfig.heightMultiplier)
                .copyWith(color: Colors.black), // Different color for 'Login'
          ),
        ],
      ),
    ),
  );
}

Widget orDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Divider(
          color: Color.fromARGB(255, 185, 181, 181),
          thickness: 1,
          height: 1.05 * SizeConfig.heightMultiplier,
        ),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 2.23 * SizeConfig.widthMultiplier),
        child: Text(
          "OR",
          style: TextStyle(
            color: Color.fromARGB(255, 185, 181, 181),
            fontFamily: "CoreSansBold",
            fontSize: 2.00 * SizeConfig.heightMultiplier,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Color.fromARGB(255, 185, 181, 181),
          thickness: 1,
          height: 1.05 * SizeConfig.heightMultiplier,
        ),
      ),
    ],
  );
}

Widget forgotPassWidget(void Function() onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
          child: Divider(
        color: Colors.black,
        height: 5,
        thickness: 2,
      )),
      SizedBox(
        width: 10,
      ),
      GestureDetector(
        onTap: onTap,
        child: Text(
          "Forgot Password?",
          style: TextStyle(
              color: Colours.buttonColorRed,
              fontFamily: "CoreSansBold",
              fontSize: 2.2 * SizeConfig.heightMultiplier),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
          child: Divider(
        color: Colors.black,
        height: 5,
        thickness: 2,
      )),
    ],
  );
}

Widget OTPfield(TextEditingController controller) {
  return Pinput(
    controller: controller,
    length: 4,
    defaultPinTheme: pinTheme(),
    focusedPinTheme: pinTheme().copyWith(
      decoration: pinTheme().decoration!.copyWith(
            border: Border.all(color: Colours.buttonColorRed), // No border on focus
          ),
    ),
    submittedPinTheme: pinTheme(),
    showCursor: true,
    onTap: () {},
  );
}

PinTheme pinTheme() {
  return PinTheme(
    margin: EdgeInsets.symmetric(horizontal: 2.1 * SizeConfig.widthMultiplier),
    width: 17.85 * SizeConfig.widthMultiplier,
    height: 7.38 * SizeConfig.heightMultiplier,
    textStyle: TextStyle(
        color: Colors.black,
        fontFamily: "CoreSansMed",
        fontSize: 2.5 * SizeConfig.heightMultiplier),
    decoration: BoxDecoration(
      boxShadow: const [BoxShadow(color: Color(0x66D9D9D9))],
      color: Color(0x66D9D9D9),
      borderRadius: BorderRadius.circular(
          0.80 * SizeConfig.heightMultiplier), // Rounded corners
    ),
  );
}

Widget createText() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: FittedBox(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontFamily: "CoreSansBold"),
          children: [
            TextSpan(
              text: "Create one",
              style: TextStyle(
                  color: Colours.buttonColorRed,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CoreSansBold"),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(() => CreateAccountScreen(),
                      transition: Transition.rightToLeft);
                },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget alreadyText() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: FittedBox(
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontFamily: "CoreSansBold"),
          children: [
            TextSpan(
              text: "Login Now",
              style: TextStyle(
                  color: Colours.buttonColorRed,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CoreSansBold"),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(() => LoginScreen(),
                      transition: Transition.rightToLeft);
                },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget forgetPin() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: FittedBox(
      child: RichText(
        text: TextSpan(
          text: "Forgot your app pin? ",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontFamily: "CoreSansBold"),
          children: [
            TextSpan(
              text: "Click Here",
              style: TextStyle(
                  color: Colours.buttonColorRed,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CoreSansBold"),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Get.to(() => LoginScreen(),
                  //     transition: Transition.rightToLeft);
                },
            ),
          ],
        ),
      ),
    ),
  );
}
