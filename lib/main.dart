import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:health_guardian/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/notification/notification-controllers.dart';
import 'package:health_guardian/helper/helper_functions.dart';
import 'package:health_guardian/screens/auth/verify_pin_screen.dart';
import 'package:health_guardian/screens/splash/splash_screen.dart';
import 'package:health_guardian/services/notificationService.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/styling/toast_message.dart';
import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((task, inputData) async {
    var logger = Logger();
    switch (task) {
      case "simple":
        debugPrint("Item is running in background");
        logger.d("Item is running in background");
        break;

      case "reminder":
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        Notificationservice.initialize();

        final note = inputData?["note"].toString();

        //? background function to check which items are near expiry and notify them
        Notificationservice.notificationReminder(note!);
        break;
      //! cannot run fcm cloud server function to send notification because of free plan
      default:
        logger.d("Unknown background task: $task");
        debugPrint("Unknown background task: $task");
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* Initialize env
  await dotenv.load();

  //* Initialize Gemini API
  Gemini.init(
    apiKey: dotenv.get('GEMINI_KEY'),
  );

  //* Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //* Initialize Workmanager in background
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  //* Notification Service Initialize
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Notificationservice.initialize();

  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}

//* Background handler for FCM
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Notificationservice.createanddisplaynotification(message);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //* setup controller for initializing background handler functions
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return GetMaterialApp(
            theme: ThemeData(fontFamily: "CoreSansMed"),
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
                      return VerifyPinScreen(
                        status: "Direct",
                      );
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
