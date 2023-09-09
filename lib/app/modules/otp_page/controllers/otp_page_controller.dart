import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/views/forgetPassword.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../signup_page/controllers/signup_page_controller.dart';

class OtpPageController extends GetxController {
  final signupctrl = Get.put(SignupPageController());
  final authctrl = Get.put(AuthenticationRespository());
  //final pinController = TextEditingController().obs;
  final focusNode = FocusNode().obs;
  final formKey = GlobalKey<FormState>().obs;


  static OtpPageController get instance =>Get.find();

     var otpctrl ="".obs;
     var forgetpassotp=false.obs;
  void verifyOTP() async{
    var isverified = await AuthenticationRespository.instance.verifyOtp(otpctrl.value);
    if( forgetpassotp.value==true){
      isverified?Get.to(ForgetPassword()):Get.back();
    }else{
      isverified?Get.toNamed(Routes.MASJID_FINDER):Get.back();
      isverified?authctrl.pinController.value.text="":Get.back();
    }


  }


  void resendCode() {
    //other code here
    authctrl.timer.cancel();
    authctrl.phoneAuthentication(
        "+${signupctrl.selectedCountry.value
            .phoneCode}${signupctrl.phoneCtrl.value
            .text.trim()}");
    authctrl.secondsRemaining.value = 120;
    authctrl.enableResend.value = false;

  }

  @override
  void dispose() {
    authctrl.timer.cancel();
   // authctrl.value.dispose();
    focusNode.value.dispose();
    super.dispose();
  }

  //TODO: Implement OtpPageController

  // Rx<TextEditingController> phoneCtrl = TextEditingController().obs;
  // List<String> otpDigits = List.filled(6, ''); // Change the number of digits as per your requirement
  // List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  // RxList otps=[].obs;
  // @override
  // void onInit() {
  //   RawKeyboard.instance.addListener(_onKeyPressed);
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   RawKeyboard.instance.removeListener(_onKeyPressed);
  //   super.onClose();
  // }
  //
  // void onDigitChanged(int index, String value) {
  //
  //     otpDigits[index] = value;
  //     otps.add(value);
  //
  //   // Automatically move focus to the next digit
  //   if (value.isNotEmpty && index < otpDigits.length - 1) {
  //     FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
  //   }
  // }
  //
  // void _onKeyPressed(RawKeyEvent event) {
  //   if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
  //     // Handle backspace key press
  //
  //       for (int i = otpDigits.length - 1; i >= 0; i--) {
  //         if (otpDigits[i].isNotEmpty) {
  //           otpDigits[i] = '';
  //           break;
  //         } else if (i > 0) {
  //           otpDigits[i] = '';
  //           FocusScope.of(Get.context!).requestFocus(focusNodes[i - 1]);
  //         }
  //       }
  //
  //   }
  // }
}
