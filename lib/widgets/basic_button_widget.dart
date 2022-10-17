import 'package:flutter/material.dart';
import 'package:the_key_to/utils/constants.dart';

class BasicButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final Color color;

  const BasicButtonWidget(
      {Key? key, required this.onPressed, required this.buttonName,required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonName,style: officialTextStyle,),
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(
          screenSize.width*0.9,
          screenSize.height*0.07,
        )
      ),
    );
  }
}
