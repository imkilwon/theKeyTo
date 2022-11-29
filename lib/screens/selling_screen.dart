import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_key_to/layout/screen_layout.dart';
import 'package:the_key_to/utils/constants.dart';
import 'package:the_key_to/widgets/normal_text_field_widget.dart';
import '../resources/cloudfirestore_methods.dart';
import '../utils/utils.dart';

class SellingScreen extends StatefulWidget {
  final bool update;
  final DocumentSnapshot? documentSnapshot;
  const SellingScreen({Key? key,required this.update,this.documentSnapshot}) : super(key: key);

  @override
  State<SellingScreen> createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  List<int> dates = [DateTime.now().year,DateTime.now().month,DateTime.now().day];
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController contextController = TextEditingController();
  String userName='';
  //선택한 값을 보여줄 변수
  String valueChoose = "카테고리 선택";
  final category = ["카테고리 선택", "자기소개서 완성", "입시 합격", "자격증 합격", "전자책", "기타"];

  @override
  void initState(){
    super.initState();
    getName();
  }

  void getName() {
    Future name = CloudFirestoreClass_().getNameAndAddress();
    name.then((val){
      // int가 나오면 해당 값을 출력
      userName= val;
    }).catchError((error) {
      // error가 해당 에러를 출력
      userName =error;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return widget.update ? updateNote(screenSize): uploadNote(screenSize) ;
  }



  Widget uploadNote ( Size screenSize ){
    return Scaffold(
      appBar: AppBar(
        title: const Text("판매 글 작성"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
              onPressed: () async {
                if(valueChoose == "카테고리 선택") {
                  Utils().showSnackBar(context: context, content: "카테고리를 선택해주세요.", error: true);
                }
                else if(image == null){
                  Utils().showSnackBar(context: context, content: "이미지를 선택해주세요.", error: true );
                }
                else{
                  String output = await CloudFirestoreClass_()
                      .uploadNoteToDatabase(
                    image: image,
                    productName: nameController.text,
                    sCost: priceController.text,
                    category: valueChoose,
                    context: contextController.text,
                    sellerName: userName,
                    dates:dates,
                    //버튼 누르는 사람 이름 가져오게 하는 코드 필요
                  );
                  if(output =="success"){
                    Get.offAll(()=> const ScreenLayout());
                  }
                  else{
                    if(priceController.text == '1'){
                      Utils().showSnackBar(context: context, content: output, error : true);
                    }
                  }
                }
                //userNote.doc(FirebaseAuth.instance.currentUser!.uid).update()
              },

              child: const Text(
                "완료",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: screenSize.height / 8,
              child: Stack(
                children: [
                  image == null
                      ? Image.network(
                    "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                    height: screenSize.height / 10,
                  )
                      : Image.memory(
                    image!,
                    height: screenSize.height / 10,
                  ),
                  IconButton(
                      onPressed: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                          });
                        }
                      },
                      icon: const Icon(Icons.file_upload))
                ],
              ),
            ),
            const Divider(
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
            const Divider(
              color: Colors.grey,
            ),
            //카테고리 선택
            SizedBox(
              width: screenSize.width * 0.9,
              child: DropdownButton(
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w500),
                isExpanded: true,
                value: valueChoose,
                underline: const SizedBox(),
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
            const Divider(
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
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: screenSize.width * .95,
              height: screenSize.width / 2,
              child: TextField(
                maxLines: 10,
                controller: contextController,
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
//==========================================================================================================
  Widget updateNote( Size screenSize ){
    nameController.text = widget.documentSnapshot!['productName'];
    priceController.text = "${widget.documentSnapshot!['cost']}";
    contextController.text = widget.documentSnapshot!['context'];
    valueChoose = widget.documentSnapshot!['category'];
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.documentSnapshot!['productName']} 수정"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: (){

            Get.back();

          },
        ),
        actions: [
          TextButton(
              onPressed: () async {
                String output = await CloudFirestoreClass_().UpdateNoteToFirebase(image: image, productName: nameController.text, sCost: priceController.text, category: valueChoose, context: contextController.text, sellerName: "김 머시깽이", dates: dates, id: widget.documentSnapshot!.id);
                Get.back();
                Utils().showSnackBar(context: context, content: output, error: false);
              },

              child: const Text(
                "완료",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w700,
                    color: Colors.cyan),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: screenSize.height / 8,
              child: Stack(
                children: [
                  image == null
                      ? Image.network(
                    "${widget.documentSnapshot!['url']}",
                    height: screenSize.height / 10,
                  )
                      : Image.memory(
                    image!,
                    height: screenSize.height / 10,
                  ),
                  IconButton(
                      onPressed: () async {
                        Uint8List? temp = await Utils().pickImage();
                        if (temp != null) {
                          setState(() {
                            image = temp;
                          });
                        }
                      },
                      icon: const Icon(Icons.file_upload))
                ],
              ),
            ),
            const Divider(
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
            const Divider(
              color: Colors.grey,
            ),
            //카테고리 선택
            SizedBox(
              width: screenSize.width * 0.9,
              child: DropdownButton(
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w500),
                isExpanded: true,
                value: valueChoose,
                underline: const SizedBox(),
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
            const Divider(
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
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: screenSize.width * .95,
              height: screenSize.width / 2,
              child: TextField(
                maxLines: 10,
                controller: contextController,
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

