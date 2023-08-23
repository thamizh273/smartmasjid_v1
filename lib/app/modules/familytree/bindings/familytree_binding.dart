import 'package:get/get.dart';

import '../controllers/familytree_controller.dart';

class FamilytreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FamilytreeController>(
      () => FamilytreeController(),
    );
  }
}
