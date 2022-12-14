import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/screens/cover_letter_screen.dart';
import 'package:the_key_to/screens/entrance_exam_screen.dart';
import 'package:the_key_to/screens/main_order_screen.dart';
import 'package:the_key_to/screens/pass_certificate.dart';
import 'package:the_key_to/screens/selling_screen.dart';
import 'package:the_key_to/utils/utils.dart';

import '../utils/constants.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isSelected = false;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("The Key To"),
        ),
        body: Column(
          children: [
            Container(
              //decoration: BoxDecoration(border: Border(top: BorderSide(color: appAccentColor,width:0.2))),
              width: screenSize.width,
              height: 40,
              child: TabBar(
                indicatorColor: Colors.white70,
                controller: _tabController,
                tabs: [
                  Text(
                    "자기소개서 완성",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Dalseo",
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "입시 합격",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Dalseo",
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "자격증 합격",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Dalseo",
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    CoverLetterScreen(),
                    EntranceExamScreen(),
                    PassCertificateScreen(),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: _isSelected
            ? Container(
                width: screenSize.width / 6,
                height: screenSize.height / 3,
                child: FloatingActionButton.extended(
                    backgroundColor: appAccentColor,
                    label: Column(
                      children: [
                        IconButton(icon: Icon(Icons.add),onPressed: (){
                          if(FirebaseAuth.instance.currentUser!=null){
                            Get.to(()=>SellingScreen(update: false,));
                          }
                          else{
                            Utils().showSnackBar(context: context, content: "로그인을 하셔야 합니다.",error: true);
                          }
                        },iconSize: 25,),
                        SizedBox(height: screenSize.height*0.025,),
                        IconButton(icon: Icon(Icons.home),onPressed: (){
                          // Get.to(()=>TestPage());
                        },iconSize: 25,),
                        SizedBox(height: screenSize.height*0.025,),
                        IconButton(icon: Icon(Icons.search),onPressed: (){
                          // Get.to(()=>TestPage());
                        },iconSize: 25,),
                        SizedBox(height: screenSize.height*0.025,),
                        IconButton(icon: Icon(Icons.keyboard_return),onPressed: (){
                          setState(() {
                            _isSelected = !_isSelected;
                          });
                        },iconSize: 25,),
                      ],
                    ),
                    onPressed: () {
                    }),
              )
            : Container(
                width: screenSize.width / 6,
                height: screenSize.width / 6,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  backgroundColor: appAccentColor,
                  focusColor: Colors.blue,
                ),
              ),
      ),
    );
  }
}
