import 'package:flutter/material.dart';

import '../../../../widgets/bgcontainer.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/safa_dropdown.dart';
import '../../../../widgets/safa_dropdown2.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/language_page_controller.dart';

class LanguagePageView extends GetView<LanguagePageController> {
   LanguagePageView({Key? key}) : super(key: key);
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'മലയാളം', 'locale': Locale('ma', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BGContainerAuth(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: .35.sh,
              width: .9.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
              child: Padding(
                padding:  EdgeInsets.all(25.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Choose Your Language",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(top: 30.h,bottom: 8.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButton<Locale>(
                          underline: Container(),
                          isExpanded: true,
                          padding: EdgeInsets.all(0),


                          value: Get.locale,
                          onChanged: (newValue) {
                            updateLanguage(newValue!);
                          },
                          items: locale.map<DropdownMenuItem<Locale>>(
                                (item) {
                              return DropdownMenuItem<Locale>(
                                alignment : AlignmentDirectional.center,
                                value: item['locale'],
                                child: Text(item['name']),
                              );
                            },
                          ).toList(),

                    ),
                      )),
                    // safa_dropdown(
                    //   height: 160,
                    //   items: ["Tamil", "English", "Arabic", "Hindi"],
                    //   onchanged: (String) {},
                    //   hinttext: 'Select your language',
                    // ),
                    Space(16),
                    Text("yccitfsa".tr),
                    Space(16),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER_LOGIN);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterLogin()));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 30),
                          backgroundColor:
                          Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          foregroundColor:
                          Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4.0,
                        ),
                        child: Text(
                          "Submit".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        )),
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
