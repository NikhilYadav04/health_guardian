import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_guardian/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/helper/helper_functions.dart';
import 'package:health_guardian/screens/auth/verify_pin_screen.dart';
import 'package:health_guardian/screens/splash/splash_screen.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* Initialize env
  await dotenv.load();

  //* Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: "CoreSansMed"
          ),
            debugShowCheckedModeBanner: false,
            title: "Health Guardian",
            home: FutureBuilder(
                future: HelperFunctions.getAuthStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: Image.asset(
                        "assets/splash/heart_red.png",
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final status = snapshot.data!;
                    var logger = Logger();
                    logger.d("Status : ${status}");
                    if (status) {
                      return VerifyPinScreen(status: "Direct",);
                    } else {
                      return SplashScreen();
                    }
                  } else {
                    toastErrorSlide(context,
                        "Error launching the app , Please try again!!");
                    return Container(
                      color: Colors.white,
                      child: Image.asset(
                        "assets/splash/heart_red.png",
                      ),
                    );
                  }
                }));
      },
    );
  }
}
