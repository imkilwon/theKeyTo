import 'package:flutter/material.dart';

import 'package:the_key_to/screens/notes_on_sell_screen.dart';
import 'package:the_key_to/screens/user_favorite_notes.dart';
import 'package:the_key_to/widgets/guide_page_widget.dart';
import 'package:the_key_to/widgets/login_state_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: LoginStateWidget(),
      ),
      body: Column(
        children: [
          SizedBox(height: screenSize.height*0.15,),
          GuidePageWidget(pageName: "판매중인 노트", page:NotesOnSellScreen()),
          GuidePageWidget(pageName: "구매한 노트", page: NotesOnSellScreen()),
          GuidePageWidget(pageName: "찜 목록", page: UserFavoriteNotes()),
        ],
      ),
    );
  }
}
