

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceAuthController extends GetxController {
  //TODO: Implement FaceAuthController
  Rx<XFile> image=XFile('').obs;
 String? base64Image;
 RxBool isPicked = false.obs;
 RxBool backss = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void pickImage({required bool isCamera}) async {

    XFile? _file;
    if (isCamera) {
      _file = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      _file = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if (_file != null) {
      image.value = XFile(_file.path);
      var rr = XFile(_file.name);
      print('fffff ${image.value}');
      print('fffff ${rr}');
      isPicked.value = true;
      backss.value=true;

    }
    if(image.value.path.isNotEmpty){

      Uint8List bytes = await image.value.readAsBytes();
      base64Image = base64Encode(bytes);
      log("imagess ${bytes}");
      print("imagess");
      log(base64Image!);
      print("imagess");

      update();

     }else {
      print("Image not Selected");
    }

  }



}
