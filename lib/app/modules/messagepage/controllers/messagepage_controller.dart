import 'package:get/get.dart';

import '../../../routes/export.dart';

class MessagepageController extends GetxController {
  //TODO: Implement MessagepageController

  final count = 0.obs;
  var isLoadings = false.obs;
  final TextEditingController input = TextEditingController();

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
