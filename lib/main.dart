import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/layout/screen_layout.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/seller_information_screen.dart';
import 'package:the_key_to/screens/send_order_to_individual_screen.dart';
import 'package:the_key_to/utils/utils.dart';

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

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ClipRRect")),
      body: Column(
        children: [
          Center(
              child: Text(
            "Image를 Container로 감싼 후,\nContainer에 BorderRadius주기",
            style: TextStyle(fontSize: 20),
          )),
          Container(
            width: 150,
            height: 150,
            child: Image.asset('assets/images/user_profile.jpg'),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Center(
              child: Text(
            "Image를 Container로 감싼 후,\nContainer에 BorderRadius주기",
            style: TextStyle(fontSize: 20),
          )),
          Container(
              width: 150,
              height: 150,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/user_profile.jpg'))),
        ],
      ),
    );
  }
}
