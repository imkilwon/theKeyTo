import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/utils/utils.dart';

class SellNotes extends StatefulWidget {
  const SellNotes({Key? key}) : super(key: key);

  @override
  State<SellNotes> createState() => _SellNotesState();
}

class _SellNotesState extends State<SellNotes> {
  final CollectionReference _notes =
  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('sell');

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
        title: Text("판매중인 노트"),
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
                  return Card(
                    child: ListTile(
                      leading: Image.network(documentSnapshot['url']),
                      title: Text(documentSnapshot['productName']),
                      subtitle: Text(documentSnapshot['cost'].toString()),
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
