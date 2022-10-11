//책장에 들어가는 책
import 'package:flutter/material.dart';

class MyBookWidget extends StatefulWidget {
  const MyBookWidget({Key? key}) : super(key: key);

  @override
  State<MyBookWidget> createState() => _MyBookWidgetState();
}

class _MyBookWidgetState extends State<MyBookWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Divider(color: Colors.grey,),
        Container(
          width: screenSize.width*0.7,
          height: screenSize.height *0.45,
          child: Image.network('https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F5400%2F2021%2F12%2F01%2F0000198752_001_20211201192008928.jpg&type=sc960_832',fit: BoxFit.cover,),
        ),
        Text("유진이얌"),
      ],
    );
  }
}
