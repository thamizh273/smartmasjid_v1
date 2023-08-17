import 'package:get/get.dart';

import '../controllers/mymasjidpage_controller.dart';

class MymasjidpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MymasjidpageController>(
      () => MymasjidpageController(),
    );
  }
}
