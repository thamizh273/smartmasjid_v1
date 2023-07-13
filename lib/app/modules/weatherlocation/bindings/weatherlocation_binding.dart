import 'package:get/get.dart';

import '../controllers/weatherlocation_controller.dart';

class WeatherlocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherlocationController>(
      () => WeatherlocationController(),
    );
  }
}
