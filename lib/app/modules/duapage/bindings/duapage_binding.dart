import 'package:get/get.dart';

import '../controllers/duapage_controller.dart';

class DuapageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DuapageController>(
      () => DuapageController(),
    );
  }
}
