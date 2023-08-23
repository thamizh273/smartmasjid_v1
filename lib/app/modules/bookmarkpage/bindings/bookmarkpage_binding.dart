import 'package:get/get.dart';

import '../controllers/bookmarkpage_controller.dart';

class BookmarkpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarkpageController>(
      () => BookmarkpageController(),
    );
  }
}
