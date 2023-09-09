import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/Stextfield.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/bgcontainer_register.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/login_page_controller.dart';

class ForgetPassword extends GetView<LoginPageController> {
  ForgetPassword({Key? key}) : super(key: key);

  final signctrl = Get.put<SignupPageController>(SignupPageController());

  // storeTokenLocally(String apiToken) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('api_token', apiToken);
  //   Get.offAll(Routes.HOME); // Navigate to the HomeScreen after login
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGContainerRegister(
        child: SingleChildScrollView(
            child: SizedBox(
              height: .77.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  80.verticalSpace,
                  Center(
                      child: Text(
                        "Change Password".tr,
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffB5C5CA)),
                      )),
                  16.verticalSpace,

                  Obx(() {
                    return Safa_textfield(
                        hint: 'Enter New Password'.tr,
                        width: .9,
                        obscureText: controller.reobscureTextpass.value,
                        controller: controller.repasswordLCtrl.value,
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.reobscureTextpass.value =
                            !controller.reobscureTextpass.value;
                            controller.update();
                          },
                          icon: Icon(
                            controller.reobscureTextpass.value
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                          ),
                        )
                    );
                  }),
                  5.verticalSpace,
                  Obx(() {
                    return Safa_textfield(
                        hint: 'confirm_password'.tr,
                        width: .9,
                        obscureText: controller.reConfirmobscureTextpass.value,
                        controller: controller.reConfirmpasswordLCtrl.value,
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.reConfirmobscureTextpass.value =
                            !controller.reConfirmobscureTextpass.value;
                            controller.update();
                          },
                          icon: Icon(
                            controller.reConfirmobscureTextpass.value
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                          ),
                        )
                    );
                  }),

                  8.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (controller.repasswordLCtrl.value.text.isEmpty) {
                              toast(
                                  error: "Error",
                                  msg: "Enter new Password ");
                              return;
                            }

                            if (controller.repasswordLCtrl.value.text!=controller.reConfirmpasswordLCtrl.value.text) {
                              toast(error: "Error", msg: "Confirm Password Not match");
                             return;
                            }
                           controller.updatePassword();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 40),
                            backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                            foregroundColor: Color(0xff11323B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4.0,
                          ),
                          child: Obx(() {
                            return Text(
                              (controller.isLoading.value &&
                                  controller.isLoading1.value)
                                  ? "wait".tr
                                  : "Reset".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary),
                            );
                          })),
                    ),
                  ),
                  //
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: GestureDetector(
                  //           onTap: () {
                  //             Get.toNamed(Routes.SIGNUP_PAGE);
                  //
                  //             /// Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>()));
                  //           },
                  //           child: Text(
                  //             "back".tr,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Theme.of(context).colorScheme.secondary),
                  //           )),
                  //     ),
                  //     10.verticalSpace,
                  //   ],
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
