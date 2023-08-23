import 'package:get/get.dart';

import '../controllers/servicepage_controller.dart';

class ServicepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicepageController>(
      () => ServicepageController(),
    );
  }
}
