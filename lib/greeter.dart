import 'dart:async';
import 'package:flutter/material.dart';
import 'homewidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Greeter extends StatefulWidget {
  @override
  GreeterState createState() {
    return GreeterState();
  }
}

class GreeterState extends State<Greeter> with WidgetsBindingObserver {
  final num greeterinterval = 48;
  final num largebenefitinterval = 48;
  @override
  Widget build(BuildContext context) {
    return new Image.asset("images/greeter.gif");
  }

  @override
  void initState() {
    super.initState();
    countDown();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    print('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  
  
  
  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, goHomePage);

  }

  void goHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new HomeContiner()),
        (route) => route == null);
  }

  

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
        print('AppLifecycleState.paused');
        break;
      case AppLifecycleState.resumed:
        print('AppLifecycleState.resumed');
        redTime();
        break;
      case AppLifecycleState.suspending:
        print('AppLifecycleState.suspending');
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
