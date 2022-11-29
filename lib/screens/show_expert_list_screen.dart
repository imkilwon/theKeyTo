import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class ShowExpertListScreen extends StatefulWidget {
  const ShowExpertListScreen({Key? key}) : super(key: key);

  @override
  State<ShowExpertListScreen> createState() => _ShowExpertListScreenState();
}

class _ShowExpertListScreenState extends State<ShowExpertListScreen> {

  List<Widget> expert=[];


  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<Widget>? tmpExpert =
    await CloudFirestoreClass_().getExpertListFromUser();
    if(mounted){
      setState(() {
        if (tmpExpert != null){
          expert = tmpExpert!;
        }
      });
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전문가 선택하기"),
      ),
      body:ListView(
        children: expert,
      ),
    );
  }
}

