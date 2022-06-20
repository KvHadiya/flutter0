import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class GlobalNotification extends StatefulWidget {
  const GlobalNotification({Key? key}) : super(key: key);

  @override
  State<GlobalNotification> createState() => _GlobalNotificationState();
}

class _GlobalNotificationState extends State<GlobalNotification> {
  @override
  void initState() {
    super.initState();

    AndroidInitializationSettings and =
        AndroidInitializationSettings('app_icon');
    IOSInitializationSettings ios = IOSInitializationSettings();

    InitializationSettings initializationSettings =
        InitializationSettings(android: and, iOS: ios);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;

      if (notification != null || androidNotification != null) {
        AndroidNotificationDetails anoti =
            AndroidNotificationDetails(channel.id, channel.name);

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(android: anoti));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text(
            "Global Notification",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
