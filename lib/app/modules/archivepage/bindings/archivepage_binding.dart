import 'package:get/get.dart';

import '../controllers/archivepage_controller.dart';

class ArchivepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArchivepageController>(
      () => ArchivepageController(),
    );
  }
}
