import 'package:flutter/material.dart';
import 'package:the_key_to/screens/notice_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/widgets/guide_page_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: screenSize.height/14,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Container(
                width: double.infinity,
                child: Text("더보기",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoSans',
                  color: Colors.black.withOpacity(0.8)
                ),),
              ),
            ),
            SizedBox(
              height: screenSize.height/14,
            ),
            GuidePageWidget(pageName: '공지사항',page : NoticeScreen()),
            GuidePageWidget(pageName: '고객 센터',page : NoticeScreen()),
            GuidePageWidget(pageName: '이용약관 및 정책',page : NoticeScreen()),
          ],
        ),
      ),
    );
  }
}
