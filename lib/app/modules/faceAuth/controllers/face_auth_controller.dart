//
//
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:typed_data';
//
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
//
// class FaceAuthController extends GetxController {
//   //TODO: Implement FaceAuthController
//   Rx<XFile> image=XFile('').obs;
//  String? base64Image;
//  RxBool isPicked = false.obs;
//  RxBool backss = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//
//   void pickImage({required bool isCamera}) async {
//
//     XFile? _file;
//     if (isCamera) {
//       _file = await ImagePicker().pickImage(source: ImageSource.camera);
//     } else {
//       _file = await ImagePicker().pickImage(source: ImageSource.gallery);
//     }
//
//
//
//     if (_file != null) {
//       image.value = XFile(_file.path);
//       var rr = XFile(_file.name);
//       print('fffff ${image.value}');
//       print('fffff ${rr}');
//       isPicked.value = true;
//       backss.value=true;
//
//     }
//     if(image.value.path.isNotEmpty){
//
//       Uint8List bytes = await image.value.readAsBytes();
//       base64Image = base64Encode(bytes);
//       log("imagess ${bytes}");
//       print("imagess");
//       log(base64Image!);
//       print("imagess");
//
//       update();
//
//      }else {
//       print("Image not Selected");
//     }
//
//   }
//
//
//
// }
import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/export.dart';

class FaceAuthController extends GetxController {
  Rx<XFile> image = XFile('').obs;
  String? base64Image;
  RxBool isPicked = false.obs;
  RxBool backss = false.obs;

  // ... other methods and lifecycle hooks ...

  void pickImage({required bool isCamera}) async {
    XFile? _file;
    if (isCamera) {
      _file = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      _file = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if (_file != null) {
      // Perform image cropping
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),]
      );

      if (croppedFile != null) {
        _file = XFile(croppedFile.path);
      }
    }

    if (_file != null) {
      image.value = _file;
      isPicked.value = true;
      backss.value = true;

      Uint8List bytes = await image.value.readAsBytes();
      base64Image = base64Encode(bytes);
      update();
    } else {
      print("Image not Selected");
    }
  }
}
