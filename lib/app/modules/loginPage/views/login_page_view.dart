import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/Stextfield.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/bgcontainer_register.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  LoginPageView({Key? key}) : super(key: key);

  final signctrl = Get.put<SignupPageController>(SignupPageController());

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
                        "Login",
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffB5C5CA)),
                      )),
                  16.verticalSpace,
                  Obx(() {
                    return !controller.showPhoneNumberField.value
                        ? Safa_textfield(
                      controller: controller.phoneLCtrl.value,
                      keyboardType: TextInputType.number,
                      width: .9,
                      hint: "Phone",
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 7, horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme:
                                const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  signctrl.selectedCountry.value =
                                      value;
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${signctrl.selectedCountry.value
                                  .flagEmoji} + ${signctrl
                                  .selectedCountry.value.phoneCode}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        : Safa_textfield(
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailLCtrl.value,
                      width: .9,
                      hint: "Email",
                      prefixIcon: const Icon(Icons.email),
                    );


                    // Center(
                    //   child: Container(
                    //     width: 325.w,
                    //     child: TextField(
                    //       style: TextStyle(
                    //           color: Theme
                    //               .of(context)
                    //               .colorScheme
                    //               .primary,
                    //           fontWeight: FontWeight.w600),
                    //       controller: controller.emailLCtrl.value,
                    //       keyboardType: TextInputType.emailAddress,
                    //       decoration: InputDecoration(
                    //         hintText: 'Email',
                    //         filled: true,
                    //         fillColor: Colors.grey.shade400,
                    //         prefixIcon: const Icon(Icons.email),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 16, vertical: 12),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  }),


                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25.w, bottom: 4.h),
                      child: GestureDetector(
                        onTap: () {
                          controller.showPhoneNumberField.value =
                          !controller.showPhoneNumberField.value;
                        },
                        child: Obx(() {
                          return Text(
                            controller.showPhoneNumberField.value
                                ? "Use Phone"
                                : "Use Email",
                            style: const TextStyle(
                              fontSize: f1,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffD9D9D9),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Obx(() {
                    return Safa_textfield(
                      controller: controller.passwordLCtrl.value,
                      obscureText: controller.obscureTextLpass.value,

                      width: .9,
                      hint: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.obscureTextLpass.value =
                          !controller.obscureTextLpass.value;
                          controller.update();
                        },
                        icon: Icon(
                          controller.obscureTextLpass.value
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    );
                  }),
                  8.verticalSpace,
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Center(
                  //     child: Container(
                  //       width: 325.w,
                  //       decoration: BoxDecoration(
                  //           gradient: LinearGradient(colors: [
                  //             hexStringToColor("818F93"),
                  //             hexStringToColor("3B555C"),
                  //           ]),
                  //           borderRadius: BorderRadius.circular(8)),
                  //       child: Obx(() {
                  //         return TextField(
                  //           style: TextStyle(
                  //               color: Theme
                  //                   .of(context)
                  //                   .colorScheme
                  //                   .primary,
                  //               fontWeight: FontWeight.w600),
                  //           obscureText: controller.obscureTextLpass.value,
                  //           controller: controller.passwordLCtrl.value,
                  //           decoration: InputDecoration(
                  //               hintText: 'Password',
                  //               filled: true,
                  //               fillColor: Colors.grey.shade400,
                  //               prefixIcon: Icon(Icons.lock_outline_rounded),
                  //               border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(8),
                  //               ),
                  //               focusedBorder: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 borderSide: const BorderSide(
                  //                   color: Colors.grey,
                  //                   // Change the border color for focused state
                  //                   width:
                  //                   2.0, // Change the border width for focused state
                  //                 ),
                  //               ),
                  //               contentPadding: EdgeInsets.symmetric(
                  //                   horizontal: 16, vertical: 12),
                  //               suffixIcon: IconButton(
                  //                 onPressed: () {
                  //                   controller.obscureTextLpass.value =
                  //                   !controller.obscureTextLpass.value;
                  //                   controller.update();
                  //                 },
                  //                 icon: Icon(
                  //                   controller.obscureTextLpass.value
                  //                       ? CupertinoIcons.eye_slash
                  //                       : CupertinoIcons.eye,
                  //                 ),
                  //               )),
                  //         );
                  //       }),
                  //     ),
                  //   ),
                  // ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: controller.isLoading.value
                            ? CupertinoActivityIndicator(
                            animating: true, radius: 15
                        )
                            : ElevatedButton(
                            onPressed: () async {
                              controller.signUpUser();
                              controller.update();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 40),
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary,
                              foregroundColor: Color(0xff11323B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 4.0,
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .primary),
                            )),
                      ),
                    );
                  }),
                  Spacer(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SIGNUP_PAGE);

                              /// Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .secondary),
                            )),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
