import 'package:get/get.dart';

import '../controllers/qiblafinderpage_controller.dart';

class QiblafinderpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QiblafinderpageController>(
      () => QiblafinderpageController(),
    );
  }
}
