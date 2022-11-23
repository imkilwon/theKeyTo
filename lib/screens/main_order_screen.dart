import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/screens/seller_information_screen.dart';
import 'package:the_key_to/screens/sign_in_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class MainOrderScreen extends StatelessWidget {
  const MainOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GuideBox(SignInScreen(),screenSize.width*0.45, screenSize.height*0.3,"요청서 보내기","전문가를 선택하여 \n요청서 보내기"),
                GuideBox(SignInScreen(),screenSize.width*0.45, screenSize.height*0.3,"받은 요청서 확인","받은 요청 목록 확인하기"),
                // GuideBox(SellerInformationScreen(),screenSize.width*0.45, screenSize.height*0.3,"받은 요청서 확인","받은 요청 확인하기"),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GuideBox(SignInScreen(),screenSize.width*0.45, screenSize.height*0.3,"공개 요청 작성하기","모두가 볼 수 있는 \n요청서 작성하기"),
                GuideBox(SignInScreen(),screenSize.width*0.45, screenSize.height*0.3,"공개 요청 목록","올라온 요청서 목록 \n확인하기"),
              ],
            ),
          ],
        ),
      )
    );
  }
}
Widget GuideBox(Widget page,double width,double height,String mainText, String subText){
  return GestureDetector(
    onTap: (){Get.to(()=>page);},
    child: Container(
      alignment: Alignment.topLeft,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: appAccentColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(mainText,style: TextStyle(fontSize: 21,fontFamily: "Dalseo",fontWeight: FontWeight.w300,color: Colors.black87),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(subText,style: TextStyle(fontSize: 17,fontFamily: "Dalseo",fontWeight: FontWeight.w300,color: Colors.black54),),
            ),
          ],
        ),
      ),
  );
}