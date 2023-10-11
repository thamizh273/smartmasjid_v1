import 'package:smartmasjid_v1/app/modules/language_page/controllers/language_page_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';


class SettingspageController extends GetxController {
  //TODO: Implement SettingspageController


  RxBool switchValue = ThemeService().isSavedDarkMode().obs;
  final langctl=Get.find<LanguagePageController>();
    var load=false.obs;
    loading(){
      load.value=true;
      update();
      Future.delayed(Duration(milliseconds: 200),() async{
       load.value=false;
       update();
      });
    }
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
