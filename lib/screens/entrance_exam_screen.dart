import 'package:flutter/material.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class EntranceExamScreen extends StatefulWidget {
  const EntranceExamScreen({Key? key}) : super(key: key);

  @override
  State<EntranceExamScreen> createState() => _EntranceExamScreenState();
}

class _EntranceExamScreenState extends State<EntranceExamScreen> {
  List<Widget> entranceExam=[];


  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<Widget>? tmpEntrance =
    await getProductsFromDiscount("입시 합격");
    setState(() {
      if (tmpEntrance != null){
        entranceExam = tmpEntrance!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: entranceExam,
        )
    );
  }
}
