import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/layout/screen_layout.dart';
import 'package:the_key_to/screens/sign_in_screen.dart';
import 'package:the_key_to/screens/sign_up_screen.dart';
import 'package:the_key_to/widgets/basic_button_widget.dart';

class MainSignScreen extends StatelessWidget {
  const MainSignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.key),
          const Text("이미지로 대체할 예정"),
          const SizedBox(height: 30,),
          Column(
            children: [
              BasicButtonWidget(onPressed: (){}, buttonName: "카카오톡으로 시작하기", color: Colors.yellow.withOpacity(0.8)),
              const SizedBox(height: 10,),
              BasicButtonWidget(onPressed: (){}, buttonName: "구글로 시작하기", color: Colors.white.withOpacity(0.8)),
              const SizedBox(height: 10,),
              BasicButtonWidget(onPressed: (){Get.to(()=>SignUpScreen());}, buttonName: "이메일로 회원가입", color: Colors.white.withOpacity(0.8)),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("이미 가입 하셨나요?   ", style:TextStyle(fontSize: 14,fontWeight: FontWeight.w300,fontFamily: "NotoSans",color: Colors.grey),),

                  GestureDetector(onTap:(){Get.to(()=>SignInScreen());}, child:const Text("로그인", style:TextStyle(fontSize: 14,decoration: TextDecoration.underline,fontWeight: FontWeight.w600,fontFamily: "NotoSans",color: Colors.grey),)),
                ],
              ),
              const SizedBox(height: 15,),
              GestureDetector(onTap: (){Get.offAll(()=>ScreenLayout());},child:const Text("로그인 하지 않고 구경하러 가기", style:TextStyle(fontSize: 14,decoration: TextDecoration.underline,fontWeight: FontWeight.w400,fontFamily: "NotoSans",color: Colors.grey),)),
        ],
          )
    ],),),);
  }
}
