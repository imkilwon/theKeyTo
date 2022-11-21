import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/main_sign_screen.dart';
import 'package:the_key_to/screens/sign_in_screen.dart';
import 'package:the_key_to/screens/GetUserName.dart';
import 'package:the_key_to/utils/utils.dart';

class LoginStateWidget extends StatefulWidget {

  const LoginStateWidget({Key? key}) : super(key: key);

  @override
  State<LoginStateWidget> createState() => _LoginStateWidgetState();
}

class _LoginStateWidgetState extends State<LoginStateWidget> {

  void update() {
    return setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLogined = FirebaseAuth.instance.currentUser != null;//로그인 되어 있으면 true, 안 되어 있으면 false
    Size screenSize = Utils().getScreenSize();
    return Container(
      child: isLogined ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: screenSize.width*0.01,
              ),
              Container(
                width: 20,
                height: 20,
                child: Icon(Icons.account_circle,size: 30,),
              ),

              SizedBox(
                width: screenSize.width*0.05,
              ),
              GetUserName(documentId: FirebaseAuth.instance.currentUser!.uid,width: screenSize.width*0.65,),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                FirebaseAuth.instance.signOut();
                update();
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ):GestureDetector(
        onTap: (){
          Get.to(()=>MainSignScreen());
        },
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //로그인 안 되어 있을 때,
            children: [
              Text("로그인이 필요합니다."),
              Icon(Icons.keyboard_arrow_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}