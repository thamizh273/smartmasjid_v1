import 'package:get/get.dart';

import '../controllers/hadithchapterdetail_controller.dart';

class HadithchapterdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadithchapterdetailController>(
      () => HadithchapterdetailController(),
    );
  }
}
