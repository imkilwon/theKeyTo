import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/screens/selling_screen.dart';
import '../utils/utils.dart';

class NotesOnSellScreen extends StatefulWidget {
  const NotesOnSellScreen({Key? key}) : super(key: key);

  @override
  State<NotesOnSellScreen> createState() => _NotesOnSellScreenState();
}

class _NotesOnSellScreenState extends State<NotesOnSellScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<int> dates = [
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day
  ];

  final notes = FirebaseFirestore.instance.collection('notes');
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController contextController = TextEditingController();

  //선택한 값을 보여줄 변수
  String valueChoose = "카테고리 선택";
  final category = ["카테고리 선택", "자기소개서 완성", "입시 합격", "자격증 합격", "전자책", "기타"];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매중인 노트'),
      ),
      body: StreamBuilder(
        stream: users.doc(FirebaseAuth.instance.currentUser!.uid).collection('sell').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: ListTile(
                    title: Text(documentSnapshot['productName']),
                    subtitle: Text(Utils().ShowPrice(price: "${documentSnapshot['cost']}")),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(()=>SellingScreen(update: true,documentSnapshot: documentSnapshot,));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              Utils().showSnackBar(context: context, content: "${documentSnapshot['productName']}을(를) 삭제했습니다.",error: false);
                              users.doc(FirebaseAuth.instance.currentUser!.uid).collection('sell').doc(documentSnapshot['productId']).delete();
                              notes.doc(documentSnapshot['productId']).delete();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
