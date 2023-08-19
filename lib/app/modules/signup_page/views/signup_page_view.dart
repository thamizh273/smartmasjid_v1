import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/bgcontainer_register.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/bgcontainer_auth.dart';
import '../../../routes/export.dart';
import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  SignupPageView({Key? key}) : super(key: key);
  final  formkey_ = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Form(
        key: formkey_,
        child: BGContainerRegister(
          child: Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: .74.sh,
                  child: Column(
                    children: [

                      const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xffB5C5CA)),
                      ),
                      18.verticalSpace,

                      Safa_textfield(
                        hint: 'First Name',
                        width: .9,
                        controller: controller.firstNameCtrl.value,
                        prefixIcon: Icon(Icons.person),
                      ),

                      12.horizontalSpace,
                      Safa_textfield(
                        prefixIcon: Icon(Icons.person),
                        controller: controller.lastNameCtrl.value,
                        hint: ' Last Name',
                        width: .9,
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

                            if(controller.firstNameCtrl.value.text.isEmpty){
                              toast(error: "Error", msg: "Enter First name",);
                              return;
                            }

                            if(controller.emailCtrl.value.text.isEmpty){
                              toast(error: "Error", msg: "Enter the Email Id",);

                              return;
                            }
                            if (!GetUtils.isEmail(controller.emailCtrl.value.text)
                            ){ toast(error: "Error", msg: "Enter valid Email Id",);

                            return;}

                            if(controller.phoneCtrl.value.text.isEmpty){
                              toast(error: "Error", msg: "Enter Phone number",);

                              return;
                            }
                            if(controller.passwordCtrl.value.text.isEmpty){
                              toast(error: "Error", msg: "Enter Password",);

                              return;
                            }
                            if(controller.passwordCtrl.value.length<=7){
                              toast(error: "Error", msg: "Password must be 8 digit",);

                              return;
                            }
                            if(controller.passCtrl.value.text.isEmpty){
                              toast(error: "Error", msg: "Enter the Confirm Password",);

                              return;
                            }
                            if(controller.passwordCtrl.value.text!=controller.passCtrl.value.text){
                              toast(error: "Error", msg: "Enter the Password not match",);

                              return;
                            }
                            if(formkey_.currentState!.validate()){
                              SignupPageController.instance.phoneAuthentication("+${controller.selectedCountry.value.phoneCode}${controller.phoneCtrl.value.text.trim()}");
                            }
                            // controller.verifyPhoneNumber();
                            Get.toNamed(Routes.OTP_PAGE);
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
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.OTP_PAGE);
                        },
                        child: Text(
                          "Have an account?",
                          style:
                          TextStyle(color: Theme
                              .of(context)
                              .colorScheme
                              .secondary),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 6.h,bottom: 25.h),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
