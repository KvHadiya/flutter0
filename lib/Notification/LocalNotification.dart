import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class LocalNotification extends StatefulWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  //STEP - 1
  FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // STEP -2
    AndroidInitializationSettings androidinit =
    AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iosinit = IOSInitializationSettings();

    // STEP -3
    InitializationSettings initializationSettings =
    InitializationSettings(iOS: iosinit, android: androidinit);

    tz.initializeTimeZones();

    _notificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showNotification();
                  },
                  child: Text("Simple")),

              ElevatedButton(
                  onPressed: () {
                    showSchedualNotification();
                  },
                  child: Text("TimeZone 5 Seec")),
            ],
          ),
        ),
      ),
    );
  }

  // SHOW - 4
  void showNotification() {
    AndroidNotificationDetails and = AndroidNotificationDetails("1", "Android",
        priority: Priority.high, importance: Importance.max);
    IOSNotificationDetails ios = IOSNotificationDetails();

    _notificationsPlugin.show(1, "Flutter Corona", "Testing Flutter",
        NotificationDetails(android: and, iOS: ios));
  }

  void showSchedualNotification() {
    AndroidNotificationDetails and = AndroidNotificationDetails("1", "Schedual",
        priority: Priority.high, importance: Importance.max);

    IOSNotificationDetails ios = IOSNotificationDetails();

    _notificationsPlugin.zonedSchedule(
        1, "5 Second", "Hii Testing", tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        NotificationDetails(iOS: ios, android: and),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
