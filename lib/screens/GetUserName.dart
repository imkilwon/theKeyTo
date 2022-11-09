import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_key_to/model/user_details_model.dart';
import 'package:the_key_to/utils/utils.dart';
class GetUserName extends StatelessWidget {
  final String documentId;
  final double width;

  GetUserName({
    required this.documentId,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: width,child: Text("${data['name']}",style: TextStyle(fontSize: 17,fontFamily: "NotoSans",fontWeight: FontWeight.w500,color: Colors.white,overflow: TextOverflow.ellipsis),)),
              SizedBox(width: width,child: Text("${data['email']}",style: TextStyle(fontSize: 12,fontFamily: "NotoSans",fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis),)),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}