import 'package:flutter/material.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class CoverLetterScreen extends StatefulWidget {
  const CoverLetterScreen({Key? key}) : super(key: key);

  @override
  State<CoverLetterScreen> createState() => _CoverLetterScreenState();
}

class _CoverLetterScreenState extends State<CoverLetterScreen> {

  List<Widget> coverLetter=[];


  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<Widget>? tmpCoverLetter =
    await getProductsFromDiscount("자기소개서 완성");
    setState(() {
      if (tmpCoverLetter != null){
        coverLetter = tmpCoverLetter!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: coverLetter,
      )
    );
  }
}
