import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/seller_information_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';
import 'package:the_key_to/widgets/basic_button_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  final bool favorite;

  const ProductDetailScreen(
      {Key? key,
      required this.productModel,
      required this.favorite,})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {


  bool _isClicked = false;
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              // Get.back(closeOverlays: true);
              Navigator.pop(context,_isClicked ? _isFavorited : widget.favorite);
              //뒤로 가면서 눌렀으면 누른 이후의 _isFavorited 정보를 안눌렀으면 원래 받아온 favorite 정보를 전달해줌
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:18.0,right: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: screenSize.height * 0.3,
                  child: Image.network(widget.productModel.url, fit: BoxFit.fitHeight),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(onTap: (){
                      Get.to(()=>SellerInformationScreen(sellerName: widget.productModel.sellerName,));
                    },child: Text("${widget.productModel.sellerName} >",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,fontFamily: "Dalseo",color: appAccentColor),)),
                    Row(
                      children: [
                        _isClicked
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
                        IconButton(onPressed: (){}, icon: Icon(Icons.share)),
                      ],
                    )
                  ],
                ),
                Divider(color: appAccentColor,),
                Text(widget.productModel.productName,style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700,fontFamily: "NotoSans",color: Colors.white),),
                SizedBox(height: 10.0,),
                Text("게시일 : ${widget.productModel.year} - ${widget.productModel.month} - ${widget.productModel.day}",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300,fontFamily: "NotoSans",color: appAccentColor),),
                SizedBox(height: 30.0,),
                Text(widget.productModel.context,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: "NotoSans",color: Colors.white),),
                SizedBox(height: 30.0),
                Text("구매 건수 ${widget.productModel.buyCnt}",style : TextStyle(fontSize: 14,fontFamily: "NotoSans",fontWeight: FontWeight.w300,color: appAccentColor)),
                SizedBox(height: 30.0),
                Divider(color: appAccentColor,),
                BasicButtonWidget(onPressed: (){}, buttonName: "구매하기", color: appAccentColor),
              ],
            ),
          ),
        ),);
  }
}
