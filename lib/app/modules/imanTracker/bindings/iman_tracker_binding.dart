import 'package:get/get.dart';

import '../controllers/iman_tracker_controller.dart';

class ImanTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImanTrackerController>(
      () => ImanTrackerController(),
    );
  }
}
