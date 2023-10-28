import 'package:get/get.dart';

import '../controllers/inheritance_controller.dart';

class InheritanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InheritanceController>(
      () => InheritanceController(),
    );
  }
}
