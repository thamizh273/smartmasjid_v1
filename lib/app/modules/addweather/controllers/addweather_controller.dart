import 'package:get/get.dart';

import '../../../routes/export.dart';

class AddweatherController extends GetxController {
  //TODO: Implement AddweatherController

  final count = 0.obs;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  RxString searchQuery = ''.obs;

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
