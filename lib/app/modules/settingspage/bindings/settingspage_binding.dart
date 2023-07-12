import 'package:get/get.dart';

import '../controllers/settingspage_controller.dart';

class SettingspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingspageController>(
      () => SettingspageController(),
    );
  }
}
