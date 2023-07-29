import 'package:get/get.dart';

import 'package:smartmasjid_v1/app/modules/profilePage/controllers/edit_profile_controller.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
    // Get.lazyPut<ProfilePageController>(
    //   () => ProfilePageController(),
    // );
  }
}
