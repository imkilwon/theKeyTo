import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/layout/screen_layout.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/seller_information_screen.dart';
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
                return ScreenLayout();
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
    Size screenSize = Utils().getScreenSize();
    String _name ='?';
    void check() {
      // future 라는 변수에서 미래에(3초 후에) int가 나올 것입니다
      Future name = CloudFirestoreClass_().getNameAndAddress();


      name.then((val) {
        // int가 나오면 해당 값을 출력
        _name = val;
      }).catchError((error) {
        // error가 해당 에러를 출력
        print('error: $error');
      });

      print('기다리는 중');
    }
    return Scaffold(
      appBar: AppBar(
        title:Text("하이ㅜ")
      ),
      body: ElevatedButton(
        onPressed: (){
          check();
        },
        child: Text(_name)
      )
    );
  }
}
