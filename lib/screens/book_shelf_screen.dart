import 'package:flutter/material.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';

class BookShelfScreen extends StatefulWidget {
  const BookShelfScreen({Key? key}) : super(key: key);

  @override
  State<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("책 장"),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: readProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          else if (snapshot.hasData) {
            final product = snapshot.data!;
            return ListView(
              children: product.map(buildProduct).toList(),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildProduct(ProductModel productModel) {
    Size screenSize = Utils().getScreenSize();
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appAccentColor,
              ),
              width: screenSize.width * 0.93,
              height: screenSize.height * 0.63,
            ),
            Container(
                width: screenSize.width * 0.86,
                height: screenSize.height * 0.6,
                child: Image.network(productModel.url, fit: BoxFit.fill,)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 2.0),
          child: Text(productModel.productName,style: TextStyle(color: appAccentColor,fontFamily: "Dalseo",fontWeight: FontWeight.w300,fontSize: 20),),
        ),
        Divider(color: appAccentColor,),
        SizedBox(height: 4.0,),
      ],
    );
  }
}