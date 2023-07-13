import 'package:get/get.dart';

import '../controllers/addweather_controller.dart';

class AddweatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddweatherController>(
      () => AddweatherController(),
    );
  }
}
