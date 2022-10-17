import 'package:flutter/material.dart';
import 'package:the_key_to/utils/constants.dart';


class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController =PageController();
  int currentPage = 0;

  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
  changePage(int page){
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: screens,
          controller: pageController,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Container(
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300]!,width:1))),
            child: TabBar(
              indicator: BoxDecoration(border:Border(top: BorderSide(color: appAccentColor ,width: 3),),),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(child: Icon(Icons.home_outlined, color: currentPage==0? appAccentColor : Colors.grey),),
                Tab(child: Icon(Icons.book,color: currentPage==1? appAccentColor : Colors.grey),),
                Tab(child: Icon(Icons.account_circle_outlined,color: currentPage==2? appAccentColor : Colors.grey),),
                Tab(child: Icon(Icons.menu,color: currentPage==3? appAccentColor : Colors.grey),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}