import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/language_page/controllers/language_page_controller.dart';

import '../../home/controllers/home_controller.dart';

class SettingspageController extends GetxController {
  //TODO: Implement SettingspageController


  RxBool switchValue = false.obs;
  final langctl=Get.find<LanguagePageController>();

  @override
  void onInit() {
    langctl.selectedRadioIndex.value = langctl.langStore.read('selectedindex') ?? 0;
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
