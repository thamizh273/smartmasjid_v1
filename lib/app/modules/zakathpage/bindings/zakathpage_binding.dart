import 'package:get/get.dart';

import '../controllers/zakathpage_controller.dart';

class ZakathpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZakathpageController>(
      () => ZakathpageController(),
    );
  }
}
