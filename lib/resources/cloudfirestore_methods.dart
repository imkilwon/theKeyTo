import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:the_key_to/model/user_details_model.dart';

import '../model/product_model.dart';

class CloudFirestoreClass_ {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNickNameAndUidToDataBase(
      {required UserDetailsModel user}) async {
    final docUid = await firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).set(user.getJson());
    //문서id가 유저의 uid(고유)이고, 내용이 userDetailsModel인 data set을 업로드
  }

  Map<String,dynamic>? readData(String code){
    Map<String,dynamic>? data;
    // final userdb = FirebaseFirestore.instance.collection("users").doc("$code");
    final userdb = FirebaseFirestore.instance.collection("users").doc(code);
    userdb.get().then((value) => {
      data = value.data()
    });
    return data;
  }

  Future<String> uploadNoteToDatabase({
    required Uint8List? image,
    required String noteName,
    required String s_cost,
    required String category,
    required String context,
    required String sellerName,
    required List<int> dates,
  }) async {
    noteName.trim();
    s_cost.trim();
    String output = "Something went wrong";

    try {
      final docProduct = firebaseFirestore.collection('notes').doc();
      String url = image==null ? 'https://firebasestorage.googleapis.com/v0/b/thekeyto-ba57d.appspot.com/o/notes%2F스크린샷%202022-11-07%20오후%201.10.35.png?alt=media&token=3e7ba29a-3430-4805-8c38-53fe197d1946' :
          await uploadImageToDatabase(image: image, uid: docProduct.id);
      int cost = int.parse(s_cost);
      final product = ProductModel(
          url: url,
          productName: noteName,
          cost: cost,
          category: category,
          context: context,
          sellerName: sellerName,
          sellerUid: firebaseAuth.currentUser!.uid,
          productId: docProduct.id,
          buyCnt: 0,
          favorite: 0,
          year: dates[0],
         month: dates[1],
          day: dates[2],
      );

      await docProduct.set(product.getJson());
      await docProduct.set(product.getJson());
      output = "success";
    } catch (e) {
      output = e.toString();
    }
    return output;
  }
}

Stream<List<ProductModel>> readProduct() {
  return FirebaseFirestore.instance.collection('notes').snapshots().map(
      (snapshots) => snapshots.docs
          .map((doc) => ProductModel.getModelFromJson(json: doc.data()))
          .toList());
}

Future<String> uploadImageToDatabase(
    {required Uint8List? image, String uid = ''}) async {
  Reference storageRef =
      FirebaseStorage.instance.ref().child("notes").child(uid);
  UploadTask uploadTask = storageRef.putData(image!);
  TaskSnapshot task = await uploadTask;
  return task.ref.getDownloadURL();
}
