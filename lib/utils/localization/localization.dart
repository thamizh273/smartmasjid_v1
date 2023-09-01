import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/modules/language_page/controllers/language_page_controller.dart';
import '../../app/routes/export.dart';
import 'en_us_translation.dart';
import 'fr_FR_translation.dart';
import 'hi_IN_translation.dart';
import 'kn_IN_translation.dart';
import 'ma_IN_translation.dart';
import 'ta_IN_translation.dart';
import 'te_IN_translation.dart';


class Localization extends Translations {
  final langCtrl=Get.put(LanguagePageController());
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs, 'ta_IN': taIN, 'fr_FR': frFR, 'hi_IN': hiIN, "kn_IN": knIN, 'ma_IN': maIN, 'te_IN': teIN,
      };
  Locale getPreferredLocale() {
    final storedLanguageCode = langCtrl.langStore.read('languageCode');
    final storedCountryCode = langCtrl.langStore.read('countryCode');
    if (storedLanguageCode != null && storedCountryCode != null) {
      return Locale(storedLanguageCode, storedCountryCode);
    }else {
      return Locale('en', 'US'); // Return English as the default locale
    }// Return null if the preferred locale is not set yet
  }

  // Method to save the preferred locale in GetStorage
  void savePreferredLocale(Locale locale) {

    langCtrl.langStore.write('languageCode', locale.languageCode);
    langCtrl.langStore.write('countryCode', locale.countryCode);
  }
  // void clearPreferredLocale() {
  //
  //   langCtrl.langStore.remove('languageCode');
  //   langCtrl.langStore.remove('countryCode');
  // }

}

