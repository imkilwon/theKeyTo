import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/utils/utils.dart';

class SendOrderToIndividualScreen extends StatelessWidget {
  const SendOrderToIndividualScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        title:Text("전문가에게 요청하기"),
        leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.chevron_left),),
        actions: [TextButton(onPressed: (){},  child: const Text(
          "완료",
          style: TextStyle(
              fontSize: 15,
              fontFamily: "NotoSans",
              fontWeight: FontWeight.w700,
              color: Colors.cyan),
        ),),],
      ),
      body:Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              width: screenSize.width*0.9,
              color: Colors.red,
              height: 50,
              child: Text("제목"),
            ),
            SizedBox(height: 10,),
            Container(
              width: screenSize.width*0.9,
              color: Colors.red,
              height: 50,
              child: Text("가격"),
            ),
            SizedBox(height: 10,),
            Container(
              width: screenSize.width*0.9,
              color: Colors.red,
              height: 150,
              child: Text("내용"),
            ),

          ],
        ),
      ),
    );
  }
}
