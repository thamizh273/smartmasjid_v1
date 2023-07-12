import 'package:get/get.dart';

import '../controllers/quranpage_controller.dart';

class QuranpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuranpageController>(
      () => QuranpageController(),
    );
  }
}
