import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/resources/authentication_method.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/widgets/basic_button_widget.dart';
import 'package:the_key_to/widgets/normal_text_field_widget.dart';

import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nickNameEditingController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("이메일로 회원가입")),
      body: Container(
        width: double.infinity,
        height: screenSize.height,
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NormalTextFieldWidget(
                  textEditingController: emailEditingController,
                  inputType: TextInputType.emailAddress,
                  label: "이메일",
                  hintText: "이메일을 입력하세요",
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.07,
                  obscureText: false),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NormalTextFieldWidget(
                  textEditingController: passwordEditingController,
                  inputType: TextInputType.text,
                  label: "비밀번호",
                  hintText: "비밀번호를 입력하세요",
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.07,
                  obscureText: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NormalTextFieldWidget(
                  textEditingController: nickNameEditingController,
                  inputType: TextInputType.text,
                  label: "닉네임",
                  hintText: "닉네임을 입력하세요",
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.07,
                  obscureText: false),
            ),
            BasicButtonWidget(
                onPressed: () async {
                  String output = await authenticationMethods.signUpUser(
                    email: emailEditingController.text,
                    password: passwordEditingController.text,
                    nickName : nickNameEditingController.text,
                  );
                  if (output == "success") {
                    Get.off(() => SignInScreen());
                  }
                },
                buttonName: "회원가입",
                color: appAccentColor),
          ],
        ),
      ),
    );
  }
}
