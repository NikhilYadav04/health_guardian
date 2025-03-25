import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationservice {
  Notificationservice._();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //* initialize flutter local notifications plugin
  static void initialize() {
    //* Initialization settings for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print("onDidReceiveNotificationResponse");
        String? id = response.payload;
        if (id != null && id.isNotEmpty) {
          // print("Router Value1234 $id");

          // Navigate to a specific screen on notification tap
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DemoScreen(
          //       id: id,
          //     ),
          //   ),
          // );
        }
      },
    );
  }

  //* to display notification popup

  //* handles push notification ( usually from fcm )
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "health_guardian",
          "reminderchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  //* manually show notification
  static void notificationReminder(String note) async {
    try {
      //* Send notification
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "health_guardian",
          "reminderchannel",
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            '', // Add your large text here
            contentTitle: '<b>Your Bold Title</b>', // Use HTML tags for bold
            htmlFormatContentTitle:
                true, // Enable HTML formatting for the title
            htmlFormatBigText: true, // Enable HTML formatting for the big text
          ),
          largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
        ),
      );

      await _notificationsPlugin.show(
        id,
        "Reminder to enter your health data",
        note,
        notificationDetails,
        payload: "",
        //* default payload :- message.data['_id']
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    print(message.data.toString());
    print(message.notification!.title);
  }
}
