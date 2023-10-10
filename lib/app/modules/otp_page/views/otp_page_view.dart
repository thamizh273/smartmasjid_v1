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
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: BGContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
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

                        // Form(
                        //   key: controller.formKey.value,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Directionality(
                        //         // Specify direction if desired
                        //         textDirection: TextDirection.ltr,
                        //         child: Pinput(
                        //           length: 6,
                        //           controller: authctrl.pinController.value,
                        //           focusNode: controller.focusNode.value,
                        //           androidSmsAutofillMethod:
                        //           AndroidSmsAutofillMethod.smsUserConsentApi,
                        //           listenForMultipleSmsOnAndroid: true,
                        //           defaultPinTheme: defaultPinTheme,
                        //           // validator: (s) {
                        //           //   return s == '2222' ? null : 'Pin is incorrect';
                        //           // },
                        //           onClipboardFound: (value) {
                        //             log('onClipboardFound: $value');
                        //             authctrl.pinController.value.setText(value);
                        //             // controller.otpctrl.value=value;
                        //           },
                        //           hapticFeedbackType: HapticFeedbackType
                        //               .lightImpact,
                        //           onSubmitted: (value) {
                        //             controller.otpctrl.value = value;
                        //             value.isNotEmpty ? OtpPageController
                        //                 .instance.verifyOTP() : null;
                        //             log('onSubmitted: $value');
                        //           },
                        //           onCompleted: (pin) {
                        //             log('onCompleted: $pin');
                        //             authctrl.pinController.value.setText(pin);
                        //             pin.isNotEmpty ? OtpPageController.instance
                        //                 .verifyOTP() : null;
                        //             controller.otpctrl.value = pin;
                        //           },
                        //           // onChanged: (value) {
                        //           //   log('onChanged: $value');
                        //           // },
                        //           cursor: Column(
                        //             mainAxisAlignment: MainAxisAlignment.end,
                        //             children: [
                        //               Container(
                        //                 margin: const EdgeInsets.only(
                        //                     bottom: 9),
                        //                 width: 22,
                        //                 height: 1,
                        //                 color: focusedBorderColor,
                        //               ),
                        //             ],
                        //           ),
                        //           focusedPinTheme: defaultPinTheme.copyWith(
                        //             decoration: defaultPinTheme.decoration!
                        //                 .copyWith(
                        //               borderRadius: BorderRadius.circular(8),
                        //               border: Border.all(
                        //                   color: focusedBorderColor),
                        //             ),
                        //           ),
                        //           submittedPinTheme: defaultPinTheme.copyWith(
                        //             decoration: defaultPinTheme.decoration!
                        //                 .copyWith(
                        //               color: fillColor,
                        //               borderRadius: BorderRadius.circular(19),
                        //               border: Border.all(
                        //                   color: focusedBorderColor),
                        //             ),
                        //           ),
                        //           errorPinTheme: defaultPinTheme.copyBorderWith(
                        //             border: Border.all(color: Colors.redAccent),
                        //           ),
                        //         ),
                        //       ),
                        //       TextButton(
                        //         onPressed: () {
                        //           controller.focusNode.value.unfocus();
                        //           controller.formKey.value.currentState!
                        //               .validate();
                        //         },
                        //         child: Obx(() {
                        //           return Text('${authctrl.resendToken.value}');
                        //         }),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Obx(() {
                          return Pinput(
                            focusNode: controller.focusNode.value,
                            length: 6,
                            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                            listenForMultipleSmsOnAndroid: false,
                            controller: authctrl.pinController.value,
                            validator: (s) {
                             // return authctrl.errorinotp.value == true ?'Pin is incorrect':null ;
                            },
                           // onSubmitted: (pin) {
                           //   controller.otpctrl.value = pin;
                           //   OtpPageController.instance.verifyOTP();
                           // },
                            onCompleted: (pin) {
                              controller.otpctrl.value =  pin;
                              OtpPageController.instance.verifyOTP();

                             // OtpPageController.instance.verifyOTP();
                             // debugPrint('onCompleted: $pin');
                            },
                          );
                        }),

                        // OtpTextField(
                        //   // clearText: true,
                        //   showFieldAsBox: true,
                        //   //  autoFocus: true,
                        //   numberOfFields: 6,
                        //   fillColor: Colors.black.withOpacity(.1),
                        //   filled: true,
                        //   // onCodeChanged: (pin) {
                        //   //   print("Completed: " + pin);
                        //   // },
                        //   // onCodeChanged: (value) {
                        //   //   Controller.codes.value=value;
                        //   // },
                        //   onSubmit: (code) {
                        //     OtpPageController.instance.otp.value = code;
                        //     // OtpPageController.instance.verifyOTP(code);
                        //     print("otp is $code");
                        //   },
                        // ),
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
                            onPressed: () {
                           //   OtpPageController.instance.verifyOTP();
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
                            text: "Remaining Time: ${authctrl.secondsRemaining
                                .value } sec",
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


                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: List.generate(
                        //         controller.otpDigits.length,
                        //         (index) => SizedBox(
                        //           width:
                        //               MediaQuery.of(context).size.width * .13,
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //                 gradient: LinearGradient(colors: [
                        //                   hexStringToColor("818F93"),
                        //                   hexStringToColor("3B555C"),
                        //                 ]),
                        //                 borderRadius: BorderRadius.circular(8)),
                        //             child: TextField(
                        //               focusNode: controller.focusNodes[index],
                        //               onChanged: (value) => controller
                        //                   .onDigitChanged(index, value),
                        //               keyboardType: TextInputType.number,
                        //               textAlign: TextAlign.center,
                        //               maxLength: 1,
                        //               style: TextStyle(
                        //                   fontSize: 20.0,
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Theme.of(context)
                        //                       .colorScheme
                        //                       .primary),
                        //               decoration: InputDecoration(
                        //                   counterText: '',
                        //                   border: OutlineInputBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(8),
                        //                   ),
                        //                   focusedBorder: OutlineInputBorder(
                        //                     borderSide: BorderSide(
                        //                         color: Colors.grey.shade300),
                        //                     borderRadius:
                        //                         BorderRadius.circular(8),
                        //                   ),
                        //                   filled: true,
                        //                   fillColor: Colors.grey.shade300
                        //                       .withOpacity(0.7)),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     const Space(16),
                        //     Stxt(
                        //         text: ctrl.resendOtp.value.toString(),
                        //         size: f1),
                        //     TextButton(
                        //         style: TextButton.styleFrom(
                        //             backgroundColor:
                        //                 Theme.of(context).colorScheme.primary,
                        //             foregroundColor: Colors.white,
                        //             fixedSize: Size(120, 35)),
                        //         onPressed: () async {
                        //           ctrl.otp1.value =
                        //               await controller.otps.join();
                        //           if (ctrl.otp1.value.isNotEmpty) {
                        //             ctrl.signUpWithPhoneAndPassword();
                        //           }
                        //
                        //           // if (ctrl.otp1.value.isNotEmpty) {
                        //           //   ctrl.signUpWithEmailAndPassword();
                        //           //   ctrl.update();
                        //           //   Get.dialog(Padding(
                        //           //     padding:
                        //           //     EdgeInsets.symmetric(vertical: 20.h),
                        //           //     child: AlertDialog(
                        //           //       backgroundColor:
                        //           //       Get.theme.colorScheme.primary,
                        //           //       shape: RoundedRectangleBorder(
                        //           //           borderRadius:
                        //           //           BorderRadius.circular(10)),
                        //           //
                        //           //       // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
                        //           //       content: Stxt(
                        //           //         text: "OTP Verified successfully",
                        //           //         size: f3,
                        //           //         weight: FontWeight.bold,
                        //           //         color: Colors.white,
                        //           //         textAlign: TextAlign.center,
                        //           //       ),
                        //           //       icon: Icon(
                        //           //         Icons.check_circle,
                        //           //         size: 80.r,
                        //           //       ),
                        //           //       iconColor: Colors.green,
                        //           //       //iconPadding: EdgeInsets.all(20),
                        //           //     ),
                        //           //   ));
                        //           //   Future.delayed(Duration(seconds: 2), () {
                        //           //     Get.toNamed(Routes.MASJID_FINDER);
                        //           //   });
                        //           // }
                        //
                        //           // ctrl.createUserWithPhoneAndPassword();
                        //           ///
                        //           //  ctrl.signUpWithEmailAndPassword();
                        //           ctrl.update();
                        //
                        //           ///
                        //
                        //           //  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidFinder()));
                        //         },
                        //         child: Text(
                        //           "verify",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.w600,
                        //               fontSize: 17),
                        //         )),
                        //     TextButton(
                        //         onPressed: () {
                        //           // if (phoneNumber.isNotEmpty){
                        //           //   BlocProvider.of<AuthCubit>(context).
                        //           //   resendOTP(widget.phoneNumber);
                        //           // }
                        //           // else {
                        //           //   // Handle empty phoneNumber
                        //           // }
                        //         },
                        //         child: Text(
                        //           "Resend OTP",
                        //           style: TextStyle(
                        //               color: Theme.of(context)
                        //                   .colorScheme
                        //                   .secondary),
                        //         )),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
