import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/user_details_model.dart';
import 'package:the_key_to/screens/send_order_to_individual_screen.dart';
import 'package:the_key_to/widgets/information_screen_product_widget.dart';
import 'package:the_key_to/widgets/simple_product_widget.dart';

import '../model/product_model.dart';

class CloudFirestoreClass_ {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNickNameAndUidToDataBase(
      {required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
    //문서id가 유저의 uid(고유)이고, 내용이 userDetailsModel인 data set을 업로드
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    //snap에 doc의 정보를 가져옴

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
      //snap에 가져온 doc 정보를 dynamic 형태로 바꿔서 userModel 생성
    );

    return userModel.name;
  }

  Future<String> uploadNoteToDatabase({
    required Uint8List? image,
    required String productName,
    required String sCost,
    required String category,
    required String context,
    required String sellerName,
    required List<int> dates,
  }) async {
    productName.trim();
    sCost.trim();
    String output = "Something went wrong";
    final user = firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("sell");
    try {
      final docProduct = firebaseFirestore.collection('notes').doc();
      String url =
          await uploadImageToDatabase(image: image, uid: docProduct.id);
      int cost = int.parse(sCost);
      final product = ProductModel(
        url: url,
        productName: productName,
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
      await user.doc(docProduct.id).set(product.getJson());
      output = "success";
    } catch (e) {
      output = e.toString();
    }
    return output;
  }

  Future<String> userFavorite(ProductModel productModel) async {
    if (firebaseAuth.currentUser == null) {
      return "로그인을 하셔야 합니다.";
    }
    if (productModel.sellerUid == firebaseAuth.currentUser!.uid) {
      return "자신의 상품은 찜할 수 없습니다.";
    }
    final user = firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection("favorite");
    var check = await user.doc(productModel.productId).get();
    final test =
        firebaseFirestore.collection('notes').doc(productModel.productId);
    if (check.exists == true) {
      //존재하면 ( 찜 함 )
      user.doc(productModel.productId).delete();
      firebaseFirestore
          .collection('notes')
          .doc(productModel.productId)
          .collection('favorite_user')
          .doc(firebaseAuth.currentUser!.uid)
          .delete();
      test.get().then((value) => {
            firebaseFirestore
                .collection('notes')
                .doc(productModel.productId)
                .update({'favorite': (value.data()!['favorite']) - 1})
          });
      //삭제하기 ( 찜 해제 )
      return "성공";
    } else {
      //존재하지 않으면 ( 찜 하지 않은 상태 )
      user.doc(productModel.productId).set(productModel.getJson());
      firebaseFirestore
          .collection('notes')
          .doc(productModel.productId)
          .collection('favorite_user')
          .doc(firebaseAuth.currentUser!.uid)
          .set({"uid": firebaseAuth.currentUser!.uid});
      test.get().then((value) => {
            firebaseFirestore
                .collection('notes')
                .doc(productModel.productId)
                .update({'favorite': (value.data()!['favorite']) + 1})
          });
      //추가하기
      return "해제";
    }
  }

  Future<String> userFollow(String sellerId) async {
    if (firebaseAuth.currentUser == null) {
      return "로그인을 하셔야 합니다.";
    } else {
      if (firebaseAuth.currentUser!.uid == sellerId) {
        return "자기 자신을 팔로우 할 수 없습니다.";
      } else {
        final user = firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .collection("follow");
        var check = await user.doc(sellerId).get();
        if (check.exists == true) {
          //존재하면 ( 이미 팔로우 함 )
          user.doc(sellerId).delete();
          //삭제하기 ( 찜 해제 )
          return "팔로우 해제";
        } else {
          //존재하지 않으면 ( 찜 하지 않은 상태 )
          user.doc(sellerId).set({"sellerId": sellerId});
          //추가하기
          return "팔로우 성공";
        }
      }
    }
  }

  Future<String> UpdateNoteToFirebase({
    required Uint8List? image,
    required String productName,
    required String sCost,
    required String category,
    required String context,
    required String sellerName,
    required List<int> dates,
    required String id,
  }) async {
    productName.trim();
    sCost.trim();
    String output = "Something went wrong";
    int cost = int.parse(sCost);
    try {
      final product = firebaseFirestore.collection('notes');
      final user = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('sell');
      await product.doc(id).update({
        "productName": productName,
        "cost": cost,
        "category": category,
        "context": context,
        "year": dates[0],
        "month": dates[1],
        "day": dates[2]
      });
      await user.doc(id).update({
        "productName": productName,
        "cost": cost,
        "category": category,
        "context": context,
        "year": dates[0],
        "month": dates[1],
        "day": dates[2]
      });
      output = "success";
    } catch (e) {
      output = e.toString();
    }
    return output;
  }

  Future<List<Widget>> getProductsFromSeller(String uid) async {
    bool _isExist = false;

    //로그인 안 했으면 모두 false
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection("notes")
        .where("sellerUid", isEqualTo: uid)
        .get();
    //sellerUid가 같으면 가져옴

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));

      if (firebaseAuth.currentUser != null) {
        //로그인 했으면
        var check = await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .collection("favorite")
            .doc(model.productId)
            .get();
        _isExist = check.exists;
      }

      children.add(InformationScreenProductWidget(
          productModel: model, favorite: _isExist));
    }
    return children;
  }

  Future<List<Widget>> getProductsFromCategory(String category) async {
    //로그인 안 했으면 모두 false
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("notes")
        .where("category", isEqualTo: category)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));

      children.add(SimpleProductWidget(
          productModel: model, favorite: await checkFavorite(model.productId)));
    }
    return children;
  }

  Future<String> sendIndividualScreen(
    String orderTitle,
    String sCost,
    String context,
    String sellerName,
    List<int> dates,
    String id,
  ) async {
    orderTitle.trim();
    sCost.trim();
    String output = "Something went wrong";
    int cost = int.parse(sCost);
    try {
      final user = firebaseFirestore
          .collection('users')
          .doc(id)//요청서를 받을 사람의 uid
          .collection('send_order');
      final expert = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)//요청서를 보낸 사람의 uid
          .collection('receive_order');
      await user.doc(firebaseAuth.currentUser!.uid).set({
        "orderTitle": orderTitle,
        "cost": cost,
        "context": context,
        "year": dates[0],
        "month": dates[1],
        "day": dates[2]
      });
      await expert.doc(id).set({
        "orderTitle": orderTitle,
        "cost": cost,
        "context": context,
        "year": dates[0],
        "month": dates[1],
        "day": dates[2]
      });
      output = "success";
    } catch (e) {
      output = e.toString();
    }
    return output;
  }

  Future<List<Widget>> getExpertListFromUser() async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("users")
        .where("expert", isEqualTo: true)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      children.add(GestureDetector(
        onTap: () {
          Get.to(() => SendOrderToIndividualScreen(
              sellerUid: docSnap['uid'], sellerName: docSnap['name']));
        },
        child: Card(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: ListTile(
            title: Text(docSnap['name']),
            subtitle: Text(docSnap['email']),
          ),
        ),
      ));
    }
    return children;
  }

  Future<bool> checkFavorite(String productId) async {
    if (firebaseAuth.currentUser != null) {
      //로그인 했으면 이 부분으로 들어옴
      var check = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("favorite")
          .doc(productId)
          .get();
      bool isExist = check.exists;
      return isExist; //있으면 true 없으면 false 전달
    } else {
      return false; //로그인 안 했으면 무조건 false
    }
  }

  Future<bool> checkFollow(String sellerId) async {
    if (firebaseAuth.currentUser != null) {
      //로그인 했으면 이 부분으로 들어옴
      var check = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("follow")
          .doc(sellerId)
          .get();
      bool isExist = check.exists;
      return isExist; //있으면 true 없으면 false 전달
    } else {
      return false; //로그인 안 했으면 무조건 false
    }
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
