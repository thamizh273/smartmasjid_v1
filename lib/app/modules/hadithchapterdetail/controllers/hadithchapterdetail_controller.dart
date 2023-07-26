import 'package:get/get.dart';

import '../../../routes/export.dart';
import '../views/hadithchapterdetail_view.dart';

class HadithchapterdetailController extends GetxController {
  //TODO: Implement HadithchapterdetailController

  double screenWidth = Get.width;
  double screenHeight = Get.height;

  final List<PopupMenuItemData> popupMenuItems = [
  PopupMenuItemData("Bookmark", "assets/images/bookmark.png"),
  PopupMenuItemData("Bookmark", "assets/images/bookmark.png"),
  PopupMenuItemData("Bookmark", "assets/images/bookmark.png"),
  PopupMenuItemData("Bookmark", "assets/images/bookmark.png"),
  ];



  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

class PopupMenuItemData {
  final String title;
  final String image;

  PopupMenuItemData(this.title, this.image,);
}
