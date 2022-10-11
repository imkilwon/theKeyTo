import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/layout/screen_layout.dart';

void main() => runApp(TheKeyTo());

class TheKeyTo extends StatelessWidget {
  const TheKeyTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 25,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w700,color: Colors.black.withOpacity(0.8)),
        ),
        primarySwatch: Colors.grey,
      ),
      home: ScreenLayout(),
    );
  }
}
