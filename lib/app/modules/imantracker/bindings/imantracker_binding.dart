import 'package:get/get.dart';

import '../controllers/imantracker_controller.dart';

class ImantrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImantrackerController>(
      () => ImantrackerController(),
    );
  }
}
