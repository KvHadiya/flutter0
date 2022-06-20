import 'package:flutter/material.dart';
import 'package:flutter0/HomeScreen/Home_Screen.dart';

import '../Utils/Auth.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController email_txt = TextEditingController();
  TextEditingController password_txt = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Auth().currentUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: email_txt,
              ),
              TextField(
                controller: password_txt,
              ),
              ElevatedButton(
                  onPressed: () {
                    Auth().signUP(email_txt.text, password_txt.text);
                  },
                  child: Text("Register")),
              ElevatedButton(
                  onPressed: () {
                    Auth().signIN(email_txt.text, password_txt.text, context);
                  },
                  child: Text("Login")),

              ElevatedButton(
                  onPressed: () {
                    Auth().googleLogin(context);
                  },
                  child: Text("Google")),


            ],
          ),
        ),
      ),
    );
  }
}
