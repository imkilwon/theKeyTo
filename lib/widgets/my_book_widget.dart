//책장에 들어가는 책
import 'package:flutter/material.dart';
import 'package:the_key_to/utils/constants.dart';

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
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenSize.width*0.75,
              height: screenSize.height *0.47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appAccentColor,
              ),
            ),
            Container(
              width: screenSize.width*0.7,
              height: screenSize.height *0.45,
              child: Image.network('https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F5400%2F2021%2F12%2F01%2F0000198752_001_20211201192008928.jpg&type=sc960_832',fit: BoxFit.cover,),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text("섹스를 잘하는 남자는 무슨 비결이 있을까? 매력적인 남자가 되는 58가지 방법",style: TextStyle(fontFamily: "Dalseo",fontWeight: FontWeight.w300,fontSize: 20,),maxLines: 2,overflow: TextOverflow.fade,),
        ),
      ],
    );
  }
}
