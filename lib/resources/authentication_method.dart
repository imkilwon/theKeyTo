import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_key_to/model/user_details_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass_ cloudFirestoreClass = CloudFirestoreClass_();

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String nickName}) async {
    email.trim();
    password.trim();
    nickName.trim();

    String output = "Something went wrong";
    if (email != "" && password != "" && nickName != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        final UserDetailsModel user = UserDetailsModel(name: nickName);
        await cloudFirestoreClass.uploadNickNameAndUidToDataBase(user: user);
        output = "회원가입 성공";
        //아이디랑 비밀번호 만들기 시도
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
        //오류가 나오면 오류에 이렇게 표시
      }
    } else {
      //빈 공간 존재
      output = "빈 공간을 모두 채워주세요";
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();

    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "로그인 성공";
        //아이디랑 비밀번호로 로그인하기
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
        //오류가 나오면 오류에 이렇게 표시
      }
    } else {
      //빈 공간 존재
      output = "빈 공간을 모두 채워주세요";
    }
    return output;
  }
}
