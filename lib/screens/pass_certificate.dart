import 'package:flutter/material.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';

class PassCertificateScreen extends StatefulWidget {
  const PassCertificateScreen({Key? key}) : super(key: key);

  @override
  State<PassCertificateScreen> createState() => _PassCertificateScreenState();
}

class _PassCertificateScreenState extends State<PassCertificateScreen> {
  List<Widget> passCertificate=[];


  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  void dispose(){
    super.dispose();
  }


  void getData() async {
    List<Widget>? tmpPassCertificate =
    await getProductsFromCategory("자격증 합격");
    setState(() {
      passCertificate = tmpPassCertificate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: passCertificate,
        )
    );
  }
}
