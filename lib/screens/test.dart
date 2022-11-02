import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  int datetime_y = DateTime.now().year;
  int datetime_m = DateTime.now().month;
  int datetime_d = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("hi"),
      ),
      body: Center(
        child: Text("${datetime_y}-${datetime_m}"),
      )
    );
  }
}
