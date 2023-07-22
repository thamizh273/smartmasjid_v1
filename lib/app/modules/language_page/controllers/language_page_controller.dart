import 'package:get/get.dart';

class LanguagePageController extends GetxController {
  //TODO: Implement LanguagePageController

  RxString selectedLang="".obs;
  @override
  void onInit() {
    selectedLang.value="ENGLISH";
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

}
