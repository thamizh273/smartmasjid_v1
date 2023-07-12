import 'package:get/get.dart';

import '../controllers/specialdayspage_controller.dart';

class SpecialdayspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialdayspageController>(
      () => SpecialdayspageController(),
    );
  }
}
