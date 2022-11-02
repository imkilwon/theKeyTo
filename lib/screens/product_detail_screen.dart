import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';
import 'package:the_key_to/widgets/basic_button_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailScreen(
      {Key? key,
      required this.productModel})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Get.back();
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
                    InkWell(onTap: (){},child: Text("${widget.productModel.sellerName} >",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,fontFamily: "Dalseo",color: appAccentColor),)),
                    Row(
                      children: [
                        IconButton(onPressed: (){
                        }, icon: Icon(Icons.favorite_border)),
                        Text("${widget.productModel.favorite}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
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
