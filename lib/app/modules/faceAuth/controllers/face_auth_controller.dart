import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceAuthController extends GetxController {
  //TODO: Implement FaceAuthController
XFile? image;

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
       update();
     }

  }



}
