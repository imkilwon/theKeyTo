import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CloudFirestoreClass{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String noteName,
    required String s_cost,//수정 전 문자열 숫자
    required String sellerName,
    required String sellerUid,
  })async{
    noteName.trim();
    cost.trim();
    String output = "Something went wrong";

    if (image != null && noteName != "" && s_cost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        int cost = int.parse(s_cost);
        ProductModel product = ProductModel(
            url: url,
            productName: noteName,
            cost: cost,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);

        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }
   return output;
  }

}