import 'package:flutter/material.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class ReceiveOrdersScreen extends StatefulWidget {
  const ReceiveOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveOrdersScreen> createState() => _ReceiveOrdersScreenState();
}

class _ReceiveOrdersScreenState extends State<ReceiveOrdersScreen> {

  List<Widget> orders=[];


  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<Widget>? tmpOrders =
    await CloudFirestoreClass_().getReceiveOrdersFromData();
    if(mounted){
      setState(() {
          orders = tmpOrders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("받은 요청서 확인하기"),
      ),
      body:ListView(
        children: orders,
      ),
    );
  }
}