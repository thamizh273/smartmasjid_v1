import 'package:get/get.dart';

import '../controllers/prayerdetailspage_controller.dart';

class PrayerdetailspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerdetailspageController>(
      () => PrayerdetailspageController(),
    );
  }
}
