import 'package:flutter/material.dart';
//import 'homewidget.dart';
import 'greeter.dart';
import 'test.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialApp materialapp = new MaterialApp(
      title: '电影-flutter客户端',
      home: new Greeter(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
       // "HomePage": (BuildContext context) => new HomeContiner(),
        "TestPage": (BuildContext context) => new TestPage(),
      },
    );
    return materialapp;
  }
}
