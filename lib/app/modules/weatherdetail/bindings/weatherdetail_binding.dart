import 'package:get/get.dart';

import '../controllers/weatherdetail_controller.dart';

class WeatherdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherdetailController>(
      () => WeatherdetailController(),
    );
  }
}
