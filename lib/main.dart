import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/layout/screen_layout.dart';
import 'package:the_key_to/screens/camera_ex.dart';
import 'package:the_key_to/screens/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const TheKeyTo());
}

class TheKeyTo extends StatelessWidget {
  const TheKeyTo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "the key to",
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: TextStyle(
                fontSize: 25,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w700,
                color: Colors.white70.withOpacity(0.8)),
          ),
          primarySwatch: Colors.grey,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                //user의 연결상태가 웨이팅이라면
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlueAccent,
                  ),
                );
              } else {
                return const ScreenLayout();
              }
            }));
  }
}
