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
  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: appAccentColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: SizedBox(
          width: getScreenSize().width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String ShowPrice({required String price}){
    List<String> result = price.split('');
    int cnt = result.length;
    int count = 0;

    while(true){
      if(result.length -1== count)break;
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