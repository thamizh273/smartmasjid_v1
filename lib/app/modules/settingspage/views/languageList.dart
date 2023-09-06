import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/settingspage/controllers/settingspage_controller.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';

import '../../../routes/export.dart';
import '../../language_page/controllers/language_page_controller.dart';

class LanguageList extends GetView<SettingspageController> {
  LanguageList({super.key});

final langCtrl=Get.put(LanguagePageController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: "language".tr),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: langCtrl.locale.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: ListTile(
              onTap: () {
                langCtrl.selectedRadioIndex.value = index;
                final selectedLocale = langCtrl.locale[index]['locale'];
                print("ssssssss ${selectedLocale}");
                langCtrl.updateLanguage(selectedLocale);
                langCtrl.selectedLang.value = langCtrl.locale[index]["name"];
                langCtrl.update();
                langCtrl.langStore.write('selectedindex', index);
              },
              splashColor: Get.theme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              tileColor:clr_white,
              title: Stxt(text: "${langCtrl.locale[index]['name']}", size: f2,color: Get.theme.primaryColor,weight: FontWeight.bold,),
              leading: Obx(() {
                return IgnorePointer(
                  child: Transform.scale(
                      scale: 1.3,
                      child: Radio(
                          activeColor: Get.theme.primaryColor,
                          // title: Text("Amiri"),
                          value: index,
                          groupValue: langCtrl.selectedRadioIndex.value,
                          onChanged: (groupValue) {
                           // controller.selectedRadioIndex.value = groupValue!;
                          })),
                );
              }),

            ),
          );
        },
      ),
    );
  }
}
