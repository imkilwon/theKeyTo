import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/product_detail_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class SellerInformationScreen extends StatefulWidget {
  final String sellerName;
  final String sellerUid;
  final bool isFollowed;

  const SellerInformationScreen(
      {Key? key,
      required this.sellerName,
      required this.sellerUid,
      required this.isFollowed})
      : super(key: key);

  @override
  State<SellerInformationScreen> createState() =>
      _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  bool _isClicked = false;
  bool _isFollowed = false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.chevron_left)),
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
                      size: screenSize.width * 0.12,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.02,
                    ),
                    Container(
                      width: screenSize.width * 0.25,
                      child: Text(
                        widget.sellerName,
                        style: TextStyle(fontSize: screenSize.width * 0.05),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _isClicked
                        ? InkWell(
                            onTap: () async {
                              final output = await CloudFirestoreClass_()
                                  .userFollow(widget.sellerUid);
                              if(output == "팔로우 성공" || output == "팔로우 해제"){
                                Utils().showSnackBar(
                                    context: context,
                                    content: output,
                                    error: false);
                                setState(() {
                                  _isFollowed = !_isFollowed;
                                });
                              }else{
                                Utils().showSnackBar(
                                    context: context,
                                    content: output,
                                    error: true);
                              }
                            },
                            child: _isFollowed
                                ? Container(
                                    alignment: Alignment.center,
                                    width: screenSize.width * 0.17,
                                    height: screenSize.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: appAccentColor,
                                      border: Border.all(color: appAccentColor),
                                    ),
                                    child: FittedBox(
                                        child: Text(
                                      "팔로우",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    width: screenSize.width * 0.17,
                                    height: screenSize.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: appAccentColor),
                                    ),
                                    child: FittedBox(child: Text("팔로우")),
                                  ),
                          )
                        :
                        //아직 안 누름
                        InkWell(
                            onTap: () async {
                              final output = await CloudFirestoreClass_()
                                  .userFollow(widget.sellerUid);
                              if(output == "팔로우 성공" || output == "팔로우 해제"){
                                Utils().showSnackBar(
                                    context: context,
                                    content: output,
                                    error: false);
                                setState(() {
                                  _isClicked = true;
                                  _isFollowed = !widget.isFollowed;
                                });
                              }else{
                                Utils().showSnackBar(
                                  context: context,
                                  content: output,
                                  error: true);
                              }
                            },
                            child: widget.isFollowed
                                ? Container(
                                    alignment: Alignment.center,
                                    width: screenSize.width * 0.17,
                                    height: screenSize.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: appAccentColor,
                                      border: Border.all(color: appAccentColor),
                                    ),
                                    child: FittedBox(
                                        child: Text(
                                      "팔로우",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    width: screenSize.width * 0.17,
                                    height: screenSize.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: appAccentColor),
                                    ),
                                    child: FittedBox(child: Text("팔로우")),
                                  ),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: screenSize.width * 0.17,
                        height: screenSize.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: appAccentColor),
                        ),
                        child: FittedBox(child: Text("요청하기")),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            StreamBuilder(
              stream:
                  users.doc(widget.sellerUid).collection('sell').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 1.5, //item 의 가로 1, 세로 2 의 비율
                    ),
                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () async {
                          bool result = await CloudFirestoreClass_()
                              .checkFavorite(documentSnapshot['productId']);
                          Get.to(() => ProductDetailScreen(
                              productModel: ProductModel(
                                url: documentSnapshot['url'],
                                productName: documentSnapshot['productName'],
                                cost: documentSnapshot['cost'],
                                category: documentSnapshot['category'],
                                context: documentSnapshot['context'],
                                sellerName: documentSnapshot['sellerName'],
                                sellerUid: documentSnapshot['sellerUid'],
                                productId: documentSnapshot['productId'],
                                buyCnt: 0,
                                favorite: 0,
                                year: documentSnapshot['year'],
                                month: documentSnapshot['month'],
                                day: documentSnapshot['day'],
                              ),
                              favorite: result)); //ㄱ ㄱ ㄱ
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenSize.width * 0.3,
                                height: screenSize.width * 0.3,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      documentSnapshot['url'],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Text(
                                Utils().ShowPrice(
                                    price: "${documentSnapshot['cost']}"),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "NotoSans",
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${documentSnapshot['productName']}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "NotoSans",
                                    fontWeight: FontWeight.w300),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
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
