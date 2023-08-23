import 'package:get/get.dart';

import '../controllers/activitiespage_controller.dart';

class ActivitiespageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivitiespageController>(
      () => ActivitiespageController(),
    );
  }
}
