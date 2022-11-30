import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_key_to/utils/constants.dart';

class Utils{
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
  showSnackBar({required BuildContext context, required String content,required bool error}) {
    // context = context, content 스낵바 내용 , error = 에러인지 아닌지
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: appAccentColor,
        padding: const EdgeInsets.all(20),
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: error ? Row(
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
              size: 22,
            ),
            const SizedBox(
              width: 7,
            ),
            Flexible(
              child: Text(
                content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ):
        Text(
          content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
  
  String ShowPrice({required String price}){
    print("price = $price");
    List<String> result = price.split('');
    int cnt = result.length;
    print("result = $result");
    int count = 0;

    while(true){
      print(count);
      if(result.length -1== count) {
        print("out");
        break;
      }
      count++;
        if(count %3 ==0 && count != 0){
          result.insert(cnt-count, ',');
        }
      }
    if(result[0]==','){
      result[0]='';
    }
    String result_price = result.join();

    return result_price+" 원";
  }

  Future<Uint8List?> pickImage() async {
    //이미지를 pick
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }
}