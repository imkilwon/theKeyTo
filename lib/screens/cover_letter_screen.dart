import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/screens/selling_screen.dart';
import 'package:the_key_to/screens/product_detail_screen.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class CoverLetterScreen extends StatefulWidget {
  const CoverLetterScreen({Key? key}) : super(key: key);

  @override
  State<CoverLetterScreen> createState() => _CoverLetterScreenState();
}

class _CoverLetterScreenState extends State<CoverLetterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductModel>>(
        stream: readProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return ListView(
              children: product.map(buildProduct).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildProduct(ProductModel productModel) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        if(FirebaseAuth.instance.currentUser != null){
          //로그인이 되어있지 않으면 자세한 내용을 보지 못함
          Get.to(() => ProductDetailScreen(
              url: productModel.url,
              productName: productModel.productName,
              context: productModel.context,
              sellerName: "김똘똘",
              cost: productModel.cost));
        }else{
          Utils().showSnackBar(context: context, content: "로그인을 하셔야 합니다.");
        }
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
                      child: Image.network(productModel.url, fit: BoxFit.cover),
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
                        productModel.productName,
                        style: TextStyle(
                            fontFamily: "Dalseo",
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      )),
                  SizedBox(
                      height: screenSize.width * 0.1,
                      child: Text(
                        "제작자 이름",
                        style: TextStyle(
                            fontFamily: "Dalseo",
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                      )),
                  SizedBox(
                      height: screenSize.width * 0.1,
                      child: Text(
                        "₩ ${productModel.cost}",
                        style: TextStyle(
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
                          child: InkWell(
                            child: Icon(Icons.favorite_border),
                            onTap: () {},
                          ),
                        ),
                        Text(
                          "1",
                          style: TextStyle(
                              fontFamily: "Dalseo",
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
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
