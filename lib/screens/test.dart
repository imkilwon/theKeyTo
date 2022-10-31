import 'package:flutter/material.dart';
import 'package:the_key_to/model/product_model.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로덕트 업로드 테스트 페이지"),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: readProduct(),
        builder: (context,snapshot){
          if (snapshot.hasError){
            return Text('${snapshot.error}');
          }
          else if(snapshot.hasData){
            final product = snapshot.data!;
            return ListView(
              children: product.map(buildProduct).toList(),
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  Widget buildProduct (ProductModel productModel)=>Row(
    children: [
      Container(width:200,height: 200,child: Image.network(productModel.url,fit: BoxFit.fill,)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 200,
              height: 100,
              child: Text(
                "${productModel.productName}",
                style: TextStyle(
                    fontFamily: "Dalseo",
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              )),
          SizedBox(
              height: 100,
              child: Text(
                "제작자이름",
                style: TextStyle(
                    fontFamily: "Dalseo",
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              )),
          SizedBox(
              height: 100,
              child: Text(
                "${productModel.cost}",
                style: TextStyle(
                    fontFamily: "Dalseo",
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              )),
          Container(
            width: 200,
            height: 100,
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
      )
    ],
  );
}
