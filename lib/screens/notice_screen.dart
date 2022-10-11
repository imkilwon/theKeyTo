import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/widgets/notice_bar_widget.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  int? _visibilityIndex;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "공지사항",
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: notices.length,
        itemBuilder: (BuildContext context, int index) {
          return NoticeBarWidget(index: index);
        },
      ),
    );
  }
}
