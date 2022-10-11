import 'package:flutter/material.dart';
import 'package:the_key_to/screens/cover_letter_screen.dart';
import 'package:the_key_to/screens/entrance_exam_screen.dart';
import 'package:the_key_to/widgets/display_book_widget.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
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
              width: screenSize.width,
              height: 20,
              child: TabBar(
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: [
                  Text("자기소개서 완성"),
                  Text("입시 합격"),
                  Text("자격증 합격"),
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
                    Center(child: Text("자격증",style: TextStyle(color: Colors.white),),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
