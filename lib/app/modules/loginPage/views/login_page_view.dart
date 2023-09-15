import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmasjid_v1/app/modules/otp_page/controllers/otp_page_controller.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/Stextfield.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../../widgets/bgcontainer_register.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/login_page_controller.dart';
import 'forgetPassword.dart';

class LoginPageView extends GetView<LoginPageController> {
  LoginPageView({Key? key}) : super(key: key);

  final signctrl = Get.put<SignupPageController>(SignupPageController());
  final otpctrl = Get.put<OtpPageController>(OtpPageController());

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
                        "login".tr,
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
                      hint: "phone".tr,
                      prefixIcon: Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  signctrl.selectedCountry.value = value;
                                });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${signctrl.selectedCountry.value.flagEmoji} + ${signctrl.selectedCountry.value.phoneCode}",
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
                      hint: "email".tr,
                      prefixIcon: const Icon(Icons.email),
                    );
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
                            style:  TextStyle(
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
                      hint: "password".tr,
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
                  2.verticalSpace,
                  InkWell(
                    onTap: (){
                      print(controller.phoneLCtrl.value.text);
                      controller.showPhoneNumberField.value=false;
                      if (controller.phoneLCtrl.value.text.isEmpty) {
                        toast(
                            error: "Error",
                            msg: "Enter Phone Number ");
                        return;
                      }
                      otpctrl.forgetpassotp.value=true;
                      //  Get.to(ForgetPassword());
                      signctrl.forgetcheckuserValid();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stxt(text: "Forget Password ?", size: f1,weight: FontWeight.w500,
                          color: Color(0xffD9D9D9),),
                        25.horizontalSpace,
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (controller.emailLCtrl.value.text.isEmpty &&
                                controller.phoneLCtrl.value.text.isEmpty) {
                              toast(
                                  error: "Error",
                                  msg: "Enter Email Id or Phone Number ");
                              return;
                            }

                            if (controller.passwordLCtrl.value.text.isEmpty) {
                              toast(error: "Error", msg: "Enter Password");
                              return;
                            }
                            controller.showPhoneNumberField.value

                                ? controller.signUpUser():controller.signUpPhone(
                                signctrl.selectedCountry.value.phoneCode);
                            // String fakeApiToken = "${controller.getUserId.value.loginUser!.userId}";
                            // storeTokenLocally(fakeApiToken);
                            //   print("ff");
                            //  print(controller.getUserId.value.loginUser!.userId);
                            //   if(controller.getUserId.value.loginUser!.userId!= null) {
                            //
                            //      await  Get.offAllNamed(Routes.HOME);
                            //   }
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
                                  : "login".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary),
                            );
                          })),
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "don't_have_an_account?".tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SIGNUP_PAGE);

                              /// Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>()));
                            },
                            child: Text(
                              "register".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.secondary),
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