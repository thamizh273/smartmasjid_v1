import 'package:get/get.dart';

import '../controllers/librarypage_controller.dart';

class LibrarypageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LibrarypageController>(
      () => LibrarypageController(),
    );
  }
}
