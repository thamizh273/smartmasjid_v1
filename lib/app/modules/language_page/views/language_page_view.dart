import 'package:flutter/material.dart';

import '../../../../widgets/bgcontainer.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/safa_dropdown.dart';
import '../../../../widgets/safa_dropdown2.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/language_page_controller.dart';

class LanguagePageView extends GetView<LanguagePageController> {
  const LanguagePageView({Key? key}) : super(key: key);

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
                      child: Obx(() {
                        return SafaDropdownButton2(
                          
                          buttonDecoration: BoxDecoration( border: Border.all(color: Get.theme.colorScheme.primary,),borderRadius: BorderRadius.circular(10)),
                          offset: Offset(0, -5),
                          buttonHeight: 40.h,
                          // dropdownPadding: EdgeInsets.only(top: 10),

                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          iconEnabledColor: Get.theme.colorScheme.primary,
                          buttonWidth: 270.w,
                         dropdownWidth: 260.w,
                          hint: 'Select your language',
                         value: controller.selectedLang.value,
                          dropdownItems:  ["English", "Tamil", "Arabic", "Hindi"],
                          onChanged: (String? value) {
                            controller.selectedLang.value = value!;

                            print( controller.selectedLang.value);
                            controller.update();
                          },
                        );
                      }),
                    ),
                    // safa_dropdown(
                    //   height: 160,
                    //   items: ["Tamil", "English", "Arabic", "Hindi"],
                    //   onchanged: (String) {},
                    //   hinttext: 'Select your language',
                    // ),
                    Space(16),
                    Text("you can change it from settings anytime"),
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
                          "Submit",
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
