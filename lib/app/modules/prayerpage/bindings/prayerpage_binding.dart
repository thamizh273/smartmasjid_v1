import 'package:get/get.dart';

import '../controllers/prayerpage_controller.dart';

class PrayerpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerpageController>(
      () => PrayerpageController(),
    );
  }
}
