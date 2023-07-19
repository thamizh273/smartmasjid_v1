import 'package:get/get.dart';

import '../controllers/masjidhistory_controller.dart';

class MasjidhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasjidhistoryController>(
      () => MasjidhistoryController(),
    );
  }
}
