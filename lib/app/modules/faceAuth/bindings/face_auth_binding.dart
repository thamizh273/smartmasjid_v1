import 'package:get/get.dart';

import '../controllers/face_auth_controller.dart';

class FaceAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceAuthController>(
      () => FaceAuthController(),
    );
  }
}
