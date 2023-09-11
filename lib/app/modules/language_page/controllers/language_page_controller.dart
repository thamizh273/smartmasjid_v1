import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/localization/localization.dart';
import '../../../routes/export.dart';
import '../../quranpage/model/quran_model.dart';

class LanguagePageController extends GetxController {
  //TODO: Implement LanguagePageController

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'Tamil(தமிழ்)', 'locale': const Locale('ta', 'IN')},
    {'name': 'Urdu(اردو)', 'locale': const Locale('ur', 'UR')},
    {'name': 'Hindi(हिंदी)', 'locale': const Locale('hi', 'IN')},
    // {'name': 'ಕನ್ನಡ', 'locale': const Locale('ka', 'IN')},
    {'name': 'Malayalam(മലയാളം)', 'locale': const Locale('ma', 'IN')},
    {'name': 'Telugu(తెలుగు)', 'locale': const Locale('te', 'IN')},
  ];
  RxString selectedLang="".obs;
  final langStore = GetStorage();
  RxInt selectedRadioIndex = 0.obs;
  @override
  void onInit() {

    selectedLang.value = langStore.read('selectedLang') ?? 'ENGLISH';
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
  updateLanguage(Locale locale) {
    Localization localization =
    Get.find(); // Retrieve the instance of Localization
    langStore.write('selectedLang', selectedLang.value);
    localization.savePreferredLocale(locale);
     print('locall${locale}');
    Get.updateLocale(locale);
  }
}
