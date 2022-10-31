import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/resources/authentication_method.dart';
import 'package:the_key_to/screens/sign_up_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/widgets/basic_button_widget.dart';
import 'package:the_key_to/widgets/normal_text_field_widget.dart';

import '../layout/screen_layout.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("이메일로 로그인")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenSize.height*0.05,),
            NormalTextFieldWidget(
                textEditingController: emailEditingController,
                inputType: TextInputType.text,
                label: "이메일",
                hintText: "사용하고 계신 정확한 이메일 주소를 적어주세요",
                width: screenSize.width * 0.9,
                height: screenSize.height * 0.07,
                obscureText: false),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NormalTextFieldWidget(
                  textEditingController: passwordEditingController,
                  inputType: TextInputType.text,
                  label: "비밀번호",
                  hintText: "10~18자 이내의 비밀번호를 입력해주세요",
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.07,
                  obscureText: true),
            ),
            SizedBox(
              height: 30,
            ),
            BasicButtonWidget(
              onPressed:
                  () async {
                String output = await authenticationMethods.signInUser(
                    email: emailEditingController.text,
                    password: passwordEditingController.text);
                if(output == "success"){
                  Get.offAll(()=>ScreenLayout());
                }
                //스낵바 위젯 추가하기
              },
              buttonName: "로그인",
              color: appAccentColor,
            ),
            BasicButtonWidget(onPressed: (){Get.to(()=>SignUpScreen());}, buttonName: "회원가입", color: appAccentColor),
          ],
        ),
      ),
    );
  }
}
