import 'package:flutter/material.dart';
import 'package:the_key_to/utils/constants.dart';

class NormalTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController; //Controller 설정
  final TextInputType inputType; //해당 텍스트 위젯이 어떤 인풋값을 받을지 설정
  final String label; //텍스트 필드 위젯에서 클릭 전에 보여줄 라벨
  final String hintText; //텍스트 필드 위젯에서 클릭 후에 보여줄 힌트 텍스트
  final double width; // 텍스트 필드의 가로 길이
  final double height; // 텍스트 필드의 세로 길이
  final bool obscureText; //가릴지 안 가릴지 설정

  NormalTextFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.inputType,
    required this.label,
    required this.hintText,
    required this.width,
    required this.height,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<NormalTextFieldWidget> createState() => _NormalTextFieldWidgetState();
}

class _NormalTextFieldWidgetState extends State<NormalTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelStyle: officialTextStyle,
          labelText: widget.label,
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 14,fontFamily: "NotoSans",fontWeight: FontWeight.w700),
          focusedBorder: OutlineInputBorder(
            //눌렀을 때의 상태
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: appAccentColor,width: 3),
          ),
          enabledBorder: const OutlineInputBorder(
            //누르기 전 평소의 상태
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
