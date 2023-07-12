import 'package:get/get.dart';

import '../controllers/request_masjid_controller.dart';

class RequestMasjidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestMasjidController>(
      () => RequestMasjidController(),
    );
  }
}
