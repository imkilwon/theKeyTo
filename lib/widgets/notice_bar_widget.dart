import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NoticeBarWidget extends StatefulWidget {
  final int index;

  const NoticeBarWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<NoticeBarWidget> createState() => _NoticeBarWidgetState();
}

class _NoticeBarWidgetState extends State<NoticeBarWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: screenSize.height / 14,
            child: Text(
              notices[widget.index],
              style: TextStyle(fontSize: 20, fontFamily: 'Dalseo'),
              maxLines: 2,
            ),
          ),
          onTap: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        Visibility(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.1),
            child: Text(
              notices_content[widget.index],
              style: TextStyle(fontSize: 15,color:Colors.black,fontFamily: 'NotoSans',fontWeight: FontWeight.w300),
            ),
          ),
          visible: isVisible,
        ),
        Divider(color: Colors.grey,),],
    );
  }
}
