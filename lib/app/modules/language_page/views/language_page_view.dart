import 'package:flutter/material.dart';

import '../../../../utils/localization/localization.dart';
import '../../../../widgets/bgcontainer.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/safa_dropdown.dart';
import '../../../../widgets/safa_dropdown2.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/language_page_controller.dart';

class LanguagePageView extends GetView<LanguagePageController> {
  LanguagePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGContainerAuth(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Container(
              constraints: BoxConstraints(minHeight: 200.h, maxHeight: 240.h),
              width: .9.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: EdgeInsets.all(25.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stxt(
                      text: "Choose Your Language".tr,
                      size: f5,
                      weight: FontWeight.w600,
                      maxLines: 1,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                      child: SafaDropdownButton2(
                        dropdownElevation: 10,
                        dropdownWidth: 260.w,
                        buttonHeight: 40.h,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        iconEnabledColor: Get.theme.colorScheme.primary,
                        buttonWidth: 270.w,
                        offset: Offset(0, -5),
                        onChanged: (String? newValue) {
                          // Find the corresponding Locale for the selected language
                          final selectedLocale =
                              controller.locale.firstWhere((item) {
                               if(item['name']==controller.locale[0]['name']){
                                 controller.langStore.write('selectedindex', 0);
                               }else if(item['name']==controller.locale[1]['name']){
                                 controller.langStore.write('selectedindex', 1);
                               }else if(item['name']==controller.locale[2]['name']){
                                 controller.langStore.write('selectedindex', 2);
                               }else if(item['name']==controller.locale[3]['name']){
                                 controller.langStore.write('selectedindex', 3);
                               }else if(item['name']==controller.locale[4]['name']){
                                 controller.langStore.write('selectedindex', 4);
                               }else if(item['name']==controller.locale[5]['name']){
                                 controller.langStore.write('selectedindex', 5);
                               }else if(item['name']==controller.locale[6]['name']){
                                 controller.langStore.write('selectedindex', 6);
                               }
                            return item['name'] == newValue;
                          })['locale'];
                          controller.updateLanguage(selectedLocale);
                          controller.selectedLang.value = newValue!;
                        },
                        hint: 'Select your language',
                        value: controller.selectedLang.value,
                        // Set the initial value to 'ENGLISH'
                        dropdownItems: controller.locale
                            .map((item) => item['name'] as String)
                            .toList(),
                      ),
                    ),

                    //     child: safa_dropdown(
                    //       isDense: false,
                    //
                    //       height: 160,
                    //       items: locale.map((item) => item['name'] as String).toList(),
                    //       onchanged: (String? newValue) {
                    //         // Convert the selected value to Locale
                    //         final selectedLocale = locale
                    //             .firstWhere(
                    //                 (item) => item['name'] == newValue)
                    //         ['locale'];
                    //         updateLanguage(selectedLocale);
                    //         controller.selectedLang.value=newValue!;
                    //       },
                    //       hinttext: 'Select your language',
                    //     ),
                    //
                    // ),
                    ///
                    // Padding(
                    //   padding:  EdgeInsets.only(top: 30.h,bottom: 8.h),
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.black,
                    //         width: 1.0,
                    //       ),
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     child: DropdownButton<Locale>(
                    //       underline: Container(),
                    //       isExpanded: true,
                    //       padding: EdgeInsets.all(0),
                    //       value: Get.locale,
                    //       onChanged: (newValue) {
                    //         updateLanguage(newValue!);
                    //       },
                    //       items: locale.map<DropdownMenuItem<Locale>>(
                    //             (item) {
                    //           return DropdownMenuItem<Locale>(
                    //             alignment : AlignmentDirectional.center,
                    //             value: item['locale'],
                    //             child: Text(item['name']),
                    //           );
                    //         },
                    //       ).toList(),
                    //
                    // ),
                    //   )),
                    ///
                    // safa_dropdown(
                    //   height: 160,
                    //   items: ["Tamil", "English", "Arabic", "Hindi"],
                    //   onchanged: (String) {},
                    //   hinttext: 'Select your language',
                    // ),
                    Space(16),
                    Text("you can change it from settings anytime".tr),
                    Space(16),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER_LOGIN);

                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterLogin()));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 30),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4.0,
                        ),
                        child: Stxt(
                          text: "submit".tr,
                          size: f3,
                          weight: FontWeight.w600,
                          maxLines: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
