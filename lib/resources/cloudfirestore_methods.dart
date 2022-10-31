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
    final docUid = await firebaseFirestore.collection('users').doc();
    user.userId = docUid.id;
    docUid.set(user.getJson());
  }

  Future<String> uploadNoteToDatabase({
    required Uint8List? image,
    required String noteName,
    required String s_cost,
    required String category,
    required String context,
  }) async {
    noteName.trim();
    s_cost.trim();
    String output = "Something went wrong";

    try {
      final docProduct = firebaseFirestore.collection('notes').doc();
      String url =
          await uploadImageToDatabase(image: image, uid: docProduct.id);
      int cost = int.parse(s_cost);
      final product = ProductModel(
          url: url,
          productName: noteName,
          cost: cost,
          category: category,
          context: context,
          productId: docProduct.id);

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
