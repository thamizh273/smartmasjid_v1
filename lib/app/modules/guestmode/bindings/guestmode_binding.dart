import 'package:get/get.dart';

import '../controllers/guestmode_controller.dart';

class GuestmodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuestmodeController>(
      () => GuestmodeController(),
    );
  }
}
