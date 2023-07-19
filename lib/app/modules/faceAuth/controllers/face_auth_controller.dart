

import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceAuthController extends GetxController {
  //TODO: Implement FaceAuthController
 XFile? image;
 String? base64Image;

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


  void pickImage() async {
    final ImagePicker _picker= ImagePicker();
     image= await _picker.pickImage(source: ImageSource.gallery);

    if(image!=null){
      List<int> imageBytes = await image!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      print("imagess");
      print(base64Image);
      print("imagess");
      update();

     }

  }



}
