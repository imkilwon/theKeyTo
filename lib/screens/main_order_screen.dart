import 'package:flutter/material.dart';
import 'package:the_key_to/utils/utils.dart';

class MainOrderScreen extends StatelessWidget {
  const MainOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                width: screenSize.width*0.95,
                height: screenSize.height*0.3,
                color: Colors.white,
              ),
            ),

            Container(
              width: screenSize.width*0.95,
              height: screenSize.height*0.3,
              color: Colors.white,
            )
          ],
        ),
      )
    );
  }
}
