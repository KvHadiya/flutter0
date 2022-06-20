import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter0/HomeScreen/Home_Screen.dart';
import 'package:flutter0/InAppWeb/Web_APp.dart';
import 'package:flutter0/Login/Login_Screen.dart';
import 'package:flutter0/Notification/GlobalNotification.dart';
import 'package:flutter0/Notification/LocalNotification.dart';
import 'package:flutter0/Splesh/SplesScreen.dart';
import 'package:flutter0/Utils/Shared.dart';
import 'package:flutter0/audio/Audio_Screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:introduction_screen/introduction_screen.dart';



// STEP 1 FLUTTER NOTIFICATION OBJECT CREATE
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


// STEP - 3 ANDROID NOTIFICATION CHANNEL CREATE
AndroidNotificationChannel channel =
AndroidNotificationChannel("1", "Android", importance: Importance.max);


// STEP - 2
Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  // STEP - 4 APPLY CHANNEL
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // STEP - 5 NOTIFICATION REPRESENT
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/globalnotification',
      routes: {
        '/': (context) => Login_Screen(),
        '/home': (context) => Home_Screen(),
        '/web': (context) => InAppWeb_Screen(),
        '/intro': (context) => Intro(),
        '/splesh': (context) => SpleshScreen(),
        '/audio': (context) => Audio_screen(),
        '/notification': (context) => LocalNotification(),
        '/globalnotification': (context) => GlobalNotification(),
      },
    ),
  );
}

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
                title: "1st",
                image: Image.network(
                    "https://i.pinimg.com/originals/58/ba/ce/58bace42e0e777c45691cecfc1f4167e.jpg"),
                body: "Hello"),
            PageViewModel(
                title: "2st",
                image: Image.network(
                    "https://i.pinimg.com/originals/58/ba/ce/58bace42e0e777c45691cecfc1f4167e.jpg"),
                body: "Hello"),
            PageViewModel(
                title: "3st",
                image: Image.network(
                    "https://i.pinimg.com/originals/58/ba/ce/58bace42e0e777c45691cecfc1f4167e.jpg"),
                body: "Hello"),
          ],
          onChange: (ps) {},
          done: Text("Done"),
          onDone: () {
            createSHR(true);
            Navigator.pushNamed(context, '/home');
          },
          next: Text("Next"),
        ),
      ),
    );
  }
}
