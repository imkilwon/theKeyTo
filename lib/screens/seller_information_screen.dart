import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class SellerInformationScreen extends StatefulWidget {
  const SellerInformationScreen({Key? key}) : super(key: key);

  @override
  State<SellerInformationScreen> createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {



  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
          Get.back();
        },child: Icon(Icons.chevron_left)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.05,
                  ),
                  Icon(
                    Icons.account_circle,
                    size: screenSize.width*0.12,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Container(
                    width: screenSize.width * 0.25,
                    child: Text(
                      "이름",
                      style: TextStyle(fontSize: screenSize.width * 0.06),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      alignment: Alignment.center,
                      width: screenSize.width*0.17,
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: appAccentColor),
                      ),
                      child: Text("팔로우",style: TextStyle(fontSize: screenSize.width*0.04),),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      alignment: Alignment.center,
                      width: screenSize.width*0.17,
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: appAccentColor),
                      ),
                      child: Text("팔로우",style: TextStyle(fontSize: screenSize.width*0.04),),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              )
            ],
          ),
        ],
      ),
    );

  }
}
