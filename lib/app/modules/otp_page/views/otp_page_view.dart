import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';
import 'package:smartmasjid_v1/widgets/bgcontainer.dart';

import '../../../../utils/color_utils.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/otp_page_controller.dart';

class OtpPageView extends StatelessWidget {
  OtpPageView({Key? key}) : super(key: key);

  final Controller = Get.put(OtpPageController());
  final Controller1 = Get.put(AuthenticationRespository());

  @override
  Widget build(BuildContext context) {
    var otp;
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
                        Text(
                          "OTP has been sent to your mobile \n number.Please Enter it Below",
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
// // <<<<<<< Updated upstream
// //
// //                         // Obx(() {
// //                         //   return Pinput(
// //                         //     length: 6,
// //                         //     androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
// //                         //     listenForMultipleSmsOnAndroid: true,
// //                         //     controller: Controller1.pinController.value,
// //                         //     onCompleted: (pin) {
// //                         //       OtpPageController.instance.verifyOTP(pin);
// //                         //       debugPrint('onCompleted: $pin');
// //                         //     },
// //                         //   );
// //                         // }),
// // =======
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: List.generate(
//                                 controller.otpDigits.length,
//                                 (index) => SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * .13,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         gradient: LinearGradient(colors: [
//                                           hexStringToColor("818F93"),
//                                           hexStringToColor("3B555C"),
//                                         ]),
//                                         borderRadius: BorderRadius.circular(8)),
//                                     child: TextField(
//                                       focusNode: controller.focusNodes[index],
//                                       onChanged: (value) => controller
//                                           .onDigitChanged(index, value),
//                                       keyboardType: TextInputType.number,
//                                       textAlign: TextAlign.center,
//                                       maxLength: 1,
//                                       style: TextStyle(
//                                           fontSize: 20.0,
//                                           fontWeight: FontWeight.w600,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary),
//                                       decoration: InputDecoration(
//                                           counterText: '',
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.grey.shade300),
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           filled: true,
//                                           fillColor: Colors.grey.shade300
//                                               .withOpacity(0.7)),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const Space(16),
// //                             BlocConsumer<AuthCubit, AuthState>(
// //                               listener: (context, state) {
// //                                 if(state is AuthLoggedInState) {
// //                                   Navigator.popUntil(context, (route) => route.isFirst);
// //                                   Navigator.pushReplacement(context, CupertinoPageRoute(
// //                                       builder: (context) => MasjidFinder()));
// //                                 }
// //                                 else if (state is AuthErrorState){
// //                                   ScaffoldMessenger.of(context).showSnackBar(
// //                                       SnackBar(
// //                                         backgroundColor: Colors.red,
// //                                         content: Text(state.error),
// //                                         duration: Duration(milliseconds: 2000),
// //                                       )
// //                                   );
// //                                 }
// //                               },
// //                               builder: (context, state) {
// //                                 if(state is AuthLoadingState) {
// //                                   return Center(
// //                                     child: CircularProgressIndicator(),
// //                                   );
// //                                 }
// //                                 return TextButton(
// //                               style: TextButton.styleFrom(
// //                                   backgroundColor: Theme.of(context).colorScheme.primary,
// //                                   foregroundColor: Colors.white,
// //                                   fixedSize: Size(120, 35)
// //                               ),
// //                               onPressed: ()  async{
// //                                 String otp = otpDigits.join();
// //                                 print('Entered OTP: $otp');
// //                                 BlocProvider.of<AuthCubit>(context).
// //                                 verifyOTP(otpDigits.join());
// //                               },
// //                               child: const Text('Verify ', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
// //                             );
// //   },
// // ),
//                             Stxt(
//                                 text: ctrl.resendOtp.value.toString(),
//                                 size: f1),
//                             TextButton(
//                                 style: TextButton.styleFrom(
//                                     backgroundColor:
//                                         Theme.of(context).colorScheme.primary,
//                                     foregroundColor: Colors.white,
//                                     fixedSize: Size(120, 35)),
//                                 onPressed: () async {
//                                   Get.toNamed(Routes.MASJID_FINDER);
//                                   ctrl.otp1.value =
//                                       await controller.otps.join();
//                                   if (ctrl.otp1.value.isNotEmpty) {
//                                     ctrl.signUpWithPhoneAndPassword();
//                                   }
//
//
//                                   // if (ctrl.otp1.value.isNotEmpty) {
//                                   //   ctrl.signUpWithEmailAndPassword();
//                                   //   ctrl.update();
//                                   //   Get.dialog(Padding(
//                                   //     padding:
//                                   //     EdgeInsets.symmetric(vertical: 20.h),
//                                   //     child: AlertDialog(
//                                   //       backgroundColor:
//                                   //       Get.theme.colorScheme.primary,
//                                   //       shape: RoundedRectangleBorder(
//                                   //           borderRadius:
//                                   //           BorderRadius.circular(10)),
//                                   //
//                                   //       // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
//                                   //       content: Stxt(
//                                   //         text: "OTP Verified successfully",
//                                   //         size: f3,
//                                   //         weight: FontWeight.bold,
//                                   //         color: Colors.white,
//                                   //         textAlign: TextAlign.center,
//                                   //       ),
//                                   //       icon: Icon(
//                                   //         Icons.check_circle,
//                                   //         size: 80.r,
//                                   //       ),
//                                   //       iconColor: Colors.green,
//                                   //       //iconPadding: EdgeInsets.all(20),
//                                   //     ),
//                                   //   ));
//                                   //   Future.delayed(Duration(seconds: 2), () {
//                                   //     Get.toNamed(Routes.MASJID_FINDER);
//                                   //   });
//                                   // }



                          OtpTextField(

                            // clearText: true,
                            showFieldAsBox: true,
                            //  autoFocus: true,
                            numberOfFields: 6,
                            fillColor: Colors.black.withOpacity(.1),
                            filled: true,
                            // onCodeChanged: (pin) {
                            //   print("Completed: " + pin);
                            // },
                            // onCodeChanged: (value) {
                            //   Controller.codes.value=value;
                            // },
                            onSubmit: (code) {
                              OtpPageController.instance.verifyOTP(code);
                              print("otp is $code");
                            },
                          ),

                    TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  fixedSize: Size(120, 35)),onPressed: () {


                          //OtpPageController.instance.verifyOTP(Controller.codes.value);
                    },
                                  child: Text(
                                "verify",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              )),

                    TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                "Resend OTP",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              )),

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
