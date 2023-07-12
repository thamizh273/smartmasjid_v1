import 'package:get/get.dart';

import '../controllers/prayertimes_controller.dart';

class PrayertimesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayertimesController>(
      () => PrayertimesController(),
    );
  }
}
