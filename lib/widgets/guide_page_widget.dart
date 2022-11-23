import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/screens/notice_screen.dart';

class GuidePageWidget extends StatelessWidget {

  final String pageName;
  final Widget page;

  const GuidePageWidget({Key? key, required this.pageName,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            Get.to(()=> page);
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left : 20.0),
                  child: Text("${pageName}",style: TextStyle(fontSize: 20,fontFamily: 'Dalseo',fontWeight: FontWeight.w500),),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:15.0),
                  child: Icon(Icons.keyboard_arrow_right_rounded),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Divider(color: Colors.grey,),
      ],
    );
  }
}
