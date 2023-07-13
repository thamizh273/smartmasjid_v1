import 'package:get/get.dart';

import '../controllers/sliderdot_controller.dart';

class SliderdotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SliderdotController>(
      () => SliderdotController(),
    );
  }
}
