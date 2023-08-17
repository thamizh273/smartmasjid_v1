import 'package:get/get.dart';

import '../controllers/donationpage_controller.dart';

class DonationpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationpageController>(
      () => DonationpageController(),
    );
  }
}
