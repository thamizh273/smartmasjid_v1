import 'package:get/get.dart';

import '../controllers/hadithpage_controller.dart';

class HadithpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadithpageController>(
      () => HadithpageController(),
    );
  }
}
