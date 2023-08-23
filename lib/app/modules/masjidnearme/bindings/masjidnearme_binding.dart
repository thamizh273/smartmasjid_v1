import 'package:get/get.dart';

import '../controllers/masjidnearme_controller.dart';

class MasjidnearmeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasjidnearmeController>(
      () => MasjidnearmeController(),
    );
  }
}
