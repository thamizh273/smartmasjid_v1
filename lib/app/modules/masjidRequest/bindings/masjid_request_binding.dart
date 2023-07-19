import 'package:get/get.dart';

import '../controllers/masjid_request_controller.dart';

class MasjidRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasjidRequestController>(
      () => MasjidRequestController(),
    );
  }
}
