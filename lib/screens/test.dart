import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_key_to/model/user_details_model.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("hi"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            FirebaseFirestore.instance.collection("users").doc("mVCvIg5AB7cWUq6qkHJiZsljxrD2").get().then((value){
              print(value.data()!['name']);
            });
          },
          child: Text("읽어오기"),
        )
      )
    );
  }

}