import 'package:get/get.dart';

import '../controllers/audioplayer_controller.dart';

class AudioplayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioplayerController>(
      () => AudioplayerController(),
    );
  }
}
