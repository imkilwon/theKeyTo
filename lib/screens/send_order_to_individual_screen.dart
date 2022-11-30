import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/resources/cloudfirestore_methods.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/utils/utils.dart';
import 'package:the_key_to/widgets/normal_text_field_widget.dart';

class SendOrderToIndividualScreen extends StatelessWidget {
  final String sellerUid;
  final String sellerName;

  const SendOrderToIndividualScreen(
      {Key? key, required this.sellerUid, required this.sellerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> dates = [DateTime.now().year,DateTime.now().month,DateTime.now().day];
    TextEditingController titleEditingController = TextEditingController();
    TextEditingController costEditingController = TextEditingController();
    TextEditingController contextEditingController = TextEditingController();
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("${sellerName}님에게 요청하기")),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        actions: [
          TextButton(
            onPressed: () async{
              final output = await CloudFirestoreClass_().sendIndividualOrder(titleEditingController.text, costEditingController.text,contextEditingController.text, sellerName, dates, sellerUid);
              if(output == "요청서를 성공적으로 보냈습니다."){
                Utils().showSnackBar(context: context, content:output, error: false);
                //보낸 요청서 확인하기 page로 이동하기
              }
            },
            child: const Text(
              "완료",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "NotoSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.cyan),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            NormalTextFieldWidget(
                textEditingController: titleEditingController,
                inputType: TextInputType.name,
                label: "제목",
                hintText: "요청하시는 내용의 제목을 적어주세요.",
                width: screenSize.width * 0.9,
                height: 50,
                obscureText: false),
            const SizedBox(
              height: 15,
            ),
            NormalTextFieldWidget(
                textEditingController: costEditingController,
                inputType: TextInputType.number,
                label: "가격",
                hintText: "원하시는 노트의 가격을 적어주세요",
                width: screenSize.width * 0.9,
                height: 50,
                obscureText: false),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: screenSize.width * .9,
              height: screenSize.height / 2,
              child: TextField(
                maxLines: 15,
                controller: contextEditingController,
                decoration: InputDecoration(
                  labelStyle: officialTextStyle,
                  label: const Text("내용"),
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
