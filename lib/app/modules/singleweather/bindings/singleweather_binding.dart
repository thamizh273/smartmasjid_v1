import 'package:get/get.dart';

import '../controllers/singleweather_controller.dart';

class SingleweatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleweatherController>(
      () => SingleweatherController(),
    );
  }
}
