import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/product_detail_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class SimpleProductWidget extends StatefulWidget {
  final ProductModel productModel;
  final bool favorite;

  const SimpleProductWidget({
    Key? key,
    required this.favorite,
    required this.productModel,
  }) : super(key: key);

  @override
  State<SimpleProductWidget> createState() => _SimpleProductWidgetState();
}

class _SimpleProductWidgetState extends State<SimpleProductWidget> {
  CollectionReference favoriteCnt =
      FirebaseFirestore.instance.collection('notes');

  bool _isClicked = false;
  bool _isFavorited = false;

  // @override
  // void initState(){
  //   super.initState();
  // }
  // @override
  // void dispose(){
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () async{
        bool refresh = await Get.to(() => ProductDetailScreen(productModel: widget.productModel,favorite: _isClicked ?_isFavorited: widget.favorite,));
        //디테일 화면으로 넘어간 이후 돌아왔다면, refresh에 받아온 값을 저장
        setState(() {
          _isClicked = true;
          _isFavorited = refresh;
          //저장한 값을 _isFavorited에 적용
        });
      },
      child: Column(
        children: [
          Divider(
            color: Colors.grey[200],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 15),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appAccentColor,
                      ),
                      width: screenSize.width * 0.44,
                      height: screenSize.width * 0.54,
                    ),
                    Container(
                      //이미지가 들어갈 상자
                      width: screenSize.width * 0.4,
                      height: screenSize.width / 2,
                      child: Image.network(widget.productModel.url,
                          fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.width * 0.02,
                  ),
                  SizedBox(
                      width: screenSize.width * 0.45,
                      height: screenSize.width * 0.1,
                      child: Text(
                        widget.productModel.productName,
                        style: const TextStyle(
                            fontFamily: "Dalseo",
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      )),
                  SizedBox(
                      height: screenSize.width * 0.1,
                      child:Text(
                        widget.productModel.sellerName,
                        style: const TextStyle(
                            fontFamily: "Dalseo",
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      )),
                  SizedBox(
                      height: screenSize.width * 0.1,
                      child: Text(
                        "₩${Utils().ShowPrice(price: "${widget.productModel.cost}")}",
                        style: const TextStyle(
                            fontFamily: "Dalseo",
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      )),
                  Container(
                    width: screenSize.width * 0.47,
                    height: screenSize.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _isClicked
                              ? InkWell(
                              child: _isFavorited
                                  ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                                  : const Icon(Icons.favorite_border),
                              onTap: () async {
                                //눌렸어? 눌렸으면
                                String output = await CloudFirestoreClass_()
                                    .userFavorite(widget.productModel);
                                setState(() {
                                  _isFavorited = !_isFavorited;
                                  _isFavorited? Utils().showSnackBar(context: context, content: "${widget.productModel.productName}을(를) 찜 하였습니다.", error: false) : Utils().showSnackBar(context: context, content: "${widget.productModel.productName}을(를) 찜 해제하였습니다.", error: false);
                                });
                              })
                              : InkWell(
                            child: widget.favorite
                                ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                                : const Icon(Icons.favorite_border),
                            onTap: () async {
                              //눌렸어? 눌렸으면
                              String output = await CloudFirestoreClass_()
                                  .userFavorite(widget.productModel);
                              setState(
                                    () {
                                  _isClicked = true;
                                  _isFavorited = !widget.favorite;
                                  _isFavorited? Utils().showSnackBar(context: context, content: "${widget.productModel.productName}을(를) 찜 하였습니다.", error: false) : Utils().showSnackBar(context: context, content: "${widget.productModel.productName}을(를) 찜 해제하였습니다.", error: false);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
