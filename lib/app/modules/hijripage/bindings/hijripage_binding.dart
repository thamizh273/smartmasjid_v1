import 'package:get/get.dart';

import '../controllers/hijripage_controller.dart';

class HijripageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HijripageController>(
      () => HijripageController(),
    );
  }
}
