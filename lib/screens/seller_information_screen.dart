import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/selling_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class SellerInformationScreen extends StatefulWidget {
  final String sellerName;
  final String sellerUid;
  const SellerInformationScreen({Key? key,required this.sellerName,required this.sellerUid}) : super(key: key);

  @override
  State<SellerInformationScreen> createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {


  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
          Get.back();
        },child: Icon(Icons.chevron_left)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                    Icon(
                      Icons.account_circle,
                      size: screenSize.width*0.12,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.02,
                    ),
                    Container(
                      width: screenSize.width * 0.25,
                      child: Text(
                        "${widget.sellerName}",
                        style: TextStyle(fontSize: screenSize.width * 0.06),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        width: screenSize.width*0.17,
                        height: screenSize.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: appAccentColor),
                        ),
                        child: Text("팔로우",style: TextStyle(fontSize: screenSize.width*0.04),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        width: screenSize.width*0.17,
                        height: screenSize.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: appAccentColor),
                        ),
                        child: Text("팔로우",style: TextStyle(fontSize: screenSize.width*0.04),),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                )
              ],
            ),
            StreamBuilder(
              stream: users.doc(widget.sellerUid).collection('sell').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
                      mainAxisSpacing: 20, //수평 Padding
                      crossAxisSpacing: 20, //수직 Padding
                    ),
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return Column(
                        children: [
                          Container(
                            width:screenSize.width*0.3,
                            height: screenSize.width*0.3,
                            child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(documentSnapshot['url'],fit: BoxFit.cover,)),
                            
                          ),
                          Text("${documentSnapshot['productName']}"),
                        ],
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );

  }
}
