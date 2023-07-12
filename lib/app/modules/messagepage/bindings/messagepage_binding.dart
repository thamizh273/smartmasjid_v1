import 'package:get/get.dart';

import '../controllers/messagepage_controller.dart';

class MessagepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagepageController>(
      () => MessagepageController(),
    );
  }
}
