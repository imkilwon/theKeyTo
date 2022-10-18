import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/widgets/basic_button_widget.dart';
import 'package:the_key_to/widgets/normal_text_field_widget.dart';

class SellingScreen extends StatefulWidget {
  const SellingScreen({Key? key}) : super(key: key);

  @override
  State<SellingScreen> createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController contextController = TextEditingController();

  //선택한 값을 보여줄 변수
  String? valueChoose = "카테고리 선택";
  final category = ["카테고리 선택", "자기소개서 완성", "입시 합격", "자격증 합격", "전자책", "기타"];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("판매 글 작성"),
        leading: IconButton(icon: Icon(Icons.chevron_left),onPressed: (){
          Get.back();
        },),
        actions: [TextButton(onPressed: () {}, child: Text("완료",style: TextStyle(fontSize: 15,fontFamily: "NotoSans",fontWeight: FontWeight.w700,color: Colors.cyan),))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
            ),
            Container(
              height: screenSize.height / 8,
              color: Colors.orange,
            ),
            Divider(
              color: Colors.grey,
            ),
            //이름 적는 곳
            NormalTextFieldWidget(
                textEditingController: nameController,
                inputType: TextInputType.text,
                label: "Key Name",
                hintText: "책의 제목을 적어주세요.",
                width: screenSize.width * 0.95,
                height: screenSize.height / 15,
                obscureText: false),
            Divider(
              color: Colors.grey,
            ),
            //카테고리 선택
            SizedBox(
              width: screenSize.width * 0.9,
              child: DropdownButton(
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w500),
                isExpanded: true,
                value: valueChoose,
                underline: SizedBox(),
                icon: const Icon(Icons.arrow_drop_down_outlined),
                iconSize: 30,
                items: category.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    valueChoose = newValue!;
                  });
                },
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            //가격 적는 곳
            NormalTextFieldWidget(
                textEditingController: priceController,
                inputType: TextInputType.number,
                label: "가격",
                hintText: "책의 가격을 적어주세요.",
                width: screenSize.width * 0.95,
                height: screenSize.height / 15,
                obscureText: false),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: screenSize.width * .95,
              height: screenSize.width / 2,
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  labelStyle: officialTextStyle,
                  label: Text("내용"),
                  hintText: "여러분의 비결을 소개해주세요!(사실과 글이 다를 시 게시가 제한될 수 있습니다.)",
                  hintStyle: const TextStyle(
                      fontSize: 18,
                      fontFamily: "NotoSans",
                      fontWeight: FontWeight.w700),
                  focusedBorder: OutlineInputBorder(
                    //눌렀을 때의 상태
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: appAccentColor, width: 3),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    //누르기 전 평소의 상태
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
