import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("내정보 페이지"),
        toolbarHeight: screenSize.height/14,
      ),
      body:Center(
        child: Text("파이어 베이스 연동하고 완성하기"),
      )
    );
  }
}
