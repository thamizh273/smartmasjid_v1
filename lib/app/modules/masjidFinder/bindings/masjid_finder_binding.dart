import 'package:get/get.dart';

import '../controllers/masjid_finder_controller.dart';

class MasjidFinderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasjidFinderController>(
      () => MasjidFinderController(),
    );
  }
}
