import 'package:get/get.dart';

import '../../../routes/export.dart';

class DuapageController extends GetxController {
  //TODO: Implement DuapageController

  var isExpanded = false.obs;
  ScrollController scrollController = ScrollController();


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
