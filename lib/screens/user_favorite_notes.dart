import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/screens/product_detail_screen.dart';
import 'package:the_key_to/utils/utils.dart';

class UserFavoriteNotes extends StatefulWidget {
  const UserFavoriteNotes({Key? key}) : super(key: key);

  @override
  State<UserFavoriteNotes> createState() => _UserFavoriteNotesState();
}

class _UserFavoriteNotesState extends State<UserFavoriteNotes> {
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorite');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: (){
            Get.back();
          },
        ),
        title: Text("찜 목록"),
      ),
      body: StreamBuilder(
        stream: _notes.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return InkWell(
                onTap: (){
                  Get.to(()=>ProductDetailScreen(productModel:ProductModel.getModelFromJson(json: (documentSnapshot.data() as dynamic)),favorite: true,));
                },
                child: Card(
                  child: ListTile(
                    leading: Image.network(documentSnapshot['url']),
                    title: Text(documentSnapshot['productName']),
                    subtitle: Text("${documentSnapshot['cost'].toString()}원"),
                  ),
                ),
              );
            });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
