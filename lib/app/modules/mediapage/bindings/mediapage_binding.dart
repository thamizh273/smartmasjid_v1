import 'package:get/get.dart';

import '../controllers/mediapage_controller.dart';

class MediapageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediapageController>(
      () => MediapageController(),
    );
  }
}
