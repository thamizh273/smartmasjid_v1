import 'dart:developer';

import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/bgcontainer.dart';
import '../../../routes/export.dart';
import '../controllers/otp_page_controller.dart';

class OtpPageView extends GetView<OtpPageController> {
  OtpPageView({Key? key}) : super(key: key);


  final authctrl = Get.put(AuthenticationRespository());
  final signupctrl = Get.put(SignupPageController());


  @override
  Widget build(BuildContext context) {

    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(

      width: 45.w,
      height: 45.h,
      textStyle:  TextStyle(
        fontSize: 18.sp,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),

      decoration: BoxDecoration(
        color: Get.theme.focusColor,
        borderRadius: BorderRadius.circular(8),
      //  border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: BGContainer(
        child: Center(
          child:  Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 400.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lottie/otpverify.json",
                        repeat: false, height: 200, width: 200),
                    Stxt(text: 'otp_sent_to_your_mobile_number'.tr, size: f3 , color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,weight: FontWeight.w600,textAlign: TextAlign.center,),

                    const SizedBox(
                      height: 20,
                    ),

                    Obx(() {
                      return Pinput(
                        focusNode: controller.focusNode.value,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                        listenForMultipleSmsOnAndroid: false,
                        controller: authctrl.pinController.value,
                        onCompleted: (pin) {
                          controller.otpctrl.value =  pin;
                          OtpPageController.instance.update();
                          OtpPageController.instance.verifyOTP();
                          OtpPageController.instance.update();
                        },
                      );
                    }),
                    10.verticalSpace,

                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                            Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            foregroundColor: Colors.white,
                            fixedSize: Size(120, 35)),
                        onPressed: ()  {
                        },
                        child: Text(
                          "verify".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Get.theme.colorScheme.secondary,),
                        )),
                    Obx(() {
                      return Stxt(
                        text: "Remaining Time: ${authctrl.secondsRemaining.value} sec",
                        size: f3,
                        weight: FontWeight.w500,
                        color: Get.theme.colorScheme.secondary,);
                    }),
                    10.verticalSpace,
                    Obx(() {
                      return SButton(ontap: () {
                        authctrl.enableResend.value ? controller
                            .resendCode() : null;
                      },
                          text: "resend_otp".tr,
                          height: 35,
                          width: 120,
                          txtsize: f2,
                          color: Colors.transparent,
                          txtClr: authctrl.enableResend.value ?Get.theme.colorScheme.secondary:Get.theme.colorScheme.secondary.withOpacity(.8),rad: 3);

                    }),


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
