import 'package:flutter/material.dart';
//import 'homewidget.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Greeter extends StatefulWidget {
  @override
  GreeterState createState() {
    return GreeterState();
  }
}

class GreeterState extends State<Greeter> with WidgetsBindingObserver {
  final num _staytime = 3;
  @override
  Widget build(BuildContext context) {
    return new Image.asset("images/greeter.jpg");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    stay();
  }
  
  void stay() {
    var _duration = new Duration(seconds: _staytime);
    new Future.delayed(_duration, goHomePage);

  }

  void goHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil("TestPage",(route)=>route==null);
    /*
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new HomeContiner()),
        (route) => route == null);
    */
  }
  
  
  @override
  void dispose() {
    print('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
        break;
      case AppLifecycleState.suspending:
        print('AppLifecycleState.suspending');
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
