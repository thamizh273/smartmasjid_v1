import 'package:get/get.dart';

import '../controllers/inheritance_result_controller.dart';

class InheritanceResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InheritanceResultController>(
      () => InheritanceResultController(),
    );
  }
}
