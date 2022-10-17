//메인화면에서 파는 중인 책을 보여주는 위젯
import 'package:flutter/material.dart';
import 'package:the_key_to/utils/constants.dart';

class DisplayBookWidget extends StatelessWidget {
  const DisplayBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Divider(
          color: Colors.grey[200],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appAccentColor,
                    ),
                    width: screenSize.width * 0.44,
                    height: screenSize.width * 0.54,
                  ),
                  Container(
                    //이미지가 들어갈 상자
                    width: screenSize.width * 0.4,
                    height: screenSize.width / 2,
                    child: Image.network(
                        'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjAxMTRfMzIg%2FMDAxNjQyMTYxMTcwMzA2.mtgUGTGJRtbsVMCnOC358ALrwsjueI7VwCfVtiSa_b4g.OMT8m4g3ETtv7zth6y0PU3ZV94ta2y6oxm2j92LgPUQg.JPEG.nwowolf%2F1642161146.jpg&type=sc960_832',
                        fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.width * 0.02,
                ),
                SizedBox(
                    width: screenSize.width*0.45,
                    height: screenSize.width * 0.1,
                    child: Text(
                      "코딩 천재가 되고싶다면?",
                      style: TextStyle(
                          fontFamily: "Dalseo",
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    )),
                SizedBox(
                    height: screenSize.width * 0.1,
                    child: Text(
                      "제작자 이름",
                      style: TextStyle(
                          fontFamily: "Dalseo",
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    )),
                SizedBox(
                    height: screenSize.width * 0.1,
                    child: Text(
                      "35,000원",
                      style: TextStyle(
                          fontFamily: "Dalseo",
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    )),
                Container(
                  width: screenSize.width*0.47,
                  height: screenSize.height*0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: Icon(Icons.favorite_border),
                          onTap: () {},
                        ),
                      ),
                      Text(
                        "1",
                        style: TextStyle(
                            fontFamily: "Dalseo",
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
