import 'package:flutter/material.dart';
import 'package:the_key_to/utils/utils.dart';

class UserFavoriteNotes extends StatelessWidget {
  //유저 찜한 페이지
  const UserFavoriteNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(title : Text("찜한 노트")),
      body: Container(
        width: screenSize.width*0.3,
        height: screenSize.height*0.3,
        child: Column(
          children: [
            Image.asset('assets/images/user_profile.jpg',width: screenSize.width*0.25),
            Text("hi"),
          ],
        ),
      ),
    );
  }
}
