import 'package:flutter/material.dart';

class SelectExpertScreen extends StatefulWidget {
  const SelectExpertScreen({Key? key}) : super(key: key);

  @override
  State<SelectExpertScreen> createState() => _SelectExpertScreenState();
}

class _SelectExpertScreenState extends State<SelectExpertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("전문가 선택하기"),
      ),
    );
  }
}

