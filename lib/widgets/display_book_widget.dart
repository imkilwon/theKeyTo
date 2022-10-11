//메인화면에서 파는 중인 책을 보여주는 위젯
import 'package:flutter/material.dart';

class DisplayBookWidget extends StatelessWidget {
  const DisplayBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Divider(color: Colors.grey[200],),
        Row(
          children: [
            Container(
              //이미지가 들어갈 상자
              width: screenSize.width*0.4,
              height: screenSize.width/2,
              child: Image.network('https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjAxMTRfMzIg%2FMDAxNjQyMTYxMTcwMzA2.mtgUGTGJRtbsVMCnOC358ALrwsjueI7VwCfVtiSa_b4g.OMT8m4g3ETtv7zth6y0PU3ZV94ta2y6oxm2j92LgPUQg.JPEG.nwowolf%2F1642161146.jpg&type=sc960_832',fit: BoxFit.cover,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("김민주입니다."),
                Text("아이즈원"),
                Text("얼굴마담"),
              ],
            )
          ],
        ),
      ],
    );
  }
}