import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/bgcontainer_register.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../routes/export.dart';
import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  SignupPageView({Key? key}) : super(key: key);
  final GlobalKey<FormState> form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: form,
        child: BGContainerRegister(
          child: SingleChildScrollView(
              child: SizedBox(
                height: .77.sh,
                child: Column(
                  children: [
                    30.verticalSpace,
                    const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Color(0xffB5C5CA)),
                    ),
                    18.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Safa_textfield(
                          controller: controller.firstNameCtrl.value,
                          hint: ' First Name',
                          width: .43,
                        ),
                        12.horizontalSpace,
                         Safa_textfield(
                          controller: controller.lastNameCtrl.value,
                          hint: ' Last Name',
                          width: .43,
                        ),
                      ],
                    ),
                    Safa_textfield(
                      hint: 'Email',
                      width: .9,
                      controller: controller.emailCtrl.value,
                      prefixIcon: Icon(Icons.mail),
                    ),
                    Obx(() {
                      return Safa_textfield(
                        keyboardType: TextInputType.number,
                        hint: 'Phone',
                        width: .9,
                        controller: controller.phoneCtrl.value,
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 550,
                                  ),
                                  onSelect: (value) {
                                    controller.selectedCountry.value = value;
                                  });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${controller.selectedCountry.value
                                    .flagEmoji} + ${controller.selectedCountry
                                    .value.phoneCode}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff11323B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: controller.phoneCtrl.value.text.length == 10
                            ? Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                            : null,
                      );
                    }),
                    Obx(() {
                      return Safa_textfield(
                          hint: 'Password',
                          width: .9,
                          obscureText: controller.obscureTextpass.value,
                          controller: controller.passwordCtrl.value,
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.obscureTextpass.value =
                              !controller.obscureTextpass.value;
                              controller.update();
                            },
                            icon: Icon(
                              controller.obscureTextpass.value
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                            ),
                          )
                      );
                    }),
                    Obx(() {
                      return Safa_textfield(
                          hint: 'Confirm Password',
                          width: .9,
                          obscureText: controller.obscureTextcpass.value,
                          controller: controller.passCtrl.value,
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.obscureTextcpass.value =
                              !controller.obscureTextcpass.value;
                              controller.update();
                            },
                            icon: Icon(
                              controller.obscureTextcpass.value
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                            ),
                          )
                      );
                    }),
                    8.verticalSpace,
                    ElevatedButton(
                        onPressed: () {
                          // // Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpPage(phoneNumber: '',)));
                          // FirebaseAuth auth = FirebaseAuth.instance;
                          // try{
                          //   UserCredential credential = await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
                          //
                          //   FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set(
                          //       {
                          //         'email': email.text,
                          //         // 'phone': phoneController.text,
                          //       }, SetOptions(merge: true));
                          //
                          //  // // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          // //  //   return OtpPage(phoneNumber: '+91' + phoneController.text,);
                          //  // // }));
                          ///
                          controller.verifyPhoneNumber();

                          Get.toNamed(Routes.OTP_PAGE);
                          // Get.dialog(Padding(
                          //   padding:  EdgeInsets.symmetric(vertical: 20.h),
                          //   child: AlertDialog(
                          //     backgroundColor: Get.theme.colorScheme.primary,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10)),
                          //
                          //
                          //    // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
                          //     content: Stxt(
                          //       text: "OTP Verified successfully",
                          //       size: f3,
                          //       weight: FontWeight.bold,
                          //       color: Colors.white,
                          //       textAlign: TextAlign.center,
                          //     ),
                          //     icon: Icon(
                          //       Icons.check_circle,
                          //       size: 80.r,
                          //     ),
                          //     iconColor: Colors.green,
                          //     //iconPadding: EdgeInsets.all(20),
                          //   ),
                          // ));

                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     transitionDuration: Duration(milliseconds: 500), // Set the duration of the transition animation
                          //     pageBuilder: (_, __, ___) => OtpPage(phoneNumber: '+91' + phoneController.text,), // Destination screen
                          //     transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                          //       return SlideTransition(
                          //         position: Tween<Offset>(
                          //           begin: Offset(1.0, 0.0), // Start position of the screen (slide from right)
                          //           end: Offset.zero, // End position of the screen (slide to center)
                          //         ).animate(animation),
                          //         child: child,
                          //       );
                          //     },
                          //   ),
                          // );
                          ///
                          // } catch (error){
                          //   print('error');
                          //   print(error);
                          //
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to signup')));
                          // }
                          // String phoneNumber = "+91" + phoneController.text;
                          // BlocProvider.of<AuthCubit>(context).
                          // sendOTP(phoneNumber);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 40),
                          backgroundColor: Theme
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
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary),
                        )),
                  Spacer(),
                    Text(
                      "Have an account?",
                      style:
                      TextStyle(color: Theme
                          .of(context)
                          .colorScheme
                          .secondary),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 6.h,bottom: 20.h),
                      child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.LOGIN_PAGE);
                            //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary),
                          )),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
