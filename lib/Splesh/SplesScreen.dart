import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter0/Utils/Shared.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    check();

    // Timer(Duration(seconds: 3),(){Navigator.pushNamed(context, '/home');});

    return SafeArea(
      child: Scaffold(
        body: Container(),
      ),
    );
  }


  void check()
  async{

    bool? isShow = await getSHR();
    if (isShow == true && isShow!=null) {
      Timer(Duration(seconds: 3), () async {
        Navigator.pushNamed(context, '/home');
      });
    } else {
      Timer(Duration(seconds: 3), () async {
        Navigator.pushNamed(context, '/intro');
      });
    }

  }
}
