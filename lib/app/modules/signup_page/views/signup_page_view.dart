import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/bgcontainer_register.dart';
import '../../../routes/export.dart';
import '../controllers/signup_page_controller.dart';

class SignupPageView extends GetView<SignupPageController> {
  SignupPageView({Key? key}) : super(key: key);
  final  formkey_ = GlobalKey<FormState>();
  final singncmtrl = Get.put(SignupPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff11323B),
      body: Stack(
        children: [
          BGContainerRegister(child: Container()),
          Form(
            key: formkey_,
            child: SafeArea(
              child: Column(
                children: [
                Flexible(
                child: Center(
                  child: SizedBox(
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView(

                        children: [
                          Text(
                            "register".tr,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Color(0xffB5C5CA)),
                          ),
                          18.verticalSpace,
                          Safa_textfield(
                            vert: true,
                            hint: 'firstname'.tr,
                            width: .9,
                            controller: controller.firstNameCtrl.value,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          12.horizontalSpace,
                          Safa_textfield(
                            vert: true,
                            prefixIcon: const Icon(Icons.person),
                            controller: controller.lastNameCtrl.value,
                            hint: 'lastname'.tr,
                            width: .9,
                          ),
                          SignupPageController.instance2.gsignBool.isTrue?Container(): Safa_textfield(
                            readOnly: SignupPageController.instance2.gsignBool.isTrue?true:false,
                            hint: 'email'.tr,
                            width: .9,
                            controller: controller.emailCtrl.value,
                            prefixIcon: const Icon(Icons.mail),
                          ),
                          Obx(() {
                            return Safa_textfield(
                              vert: true,

                              keyboardType: TextInputType.number,
                              hint: 'phone'.tr,
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
                            return SignupPageController.instance2.gsignBool.isTrue?Container(): Safa_textfield(
                                vert: true,
                                hint: 'password'.tr,
                                width: .9,
                                obscureText: controller.obscureTextpass.value,
                                controller: controller.passwordCtrl.value,
                                prefixIcon: const Icon(Icons.lock_outline_rounded),
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
                            return SignupPageController.instance2.gsignBool.isTrue?Container(): Safa_textfield(
                                vert: true,
                                hint: 'confirm_password'.tr,
                                width: .9,
                                obscureText: controller.obscureTextcpass.value,
                                controller: controller.passCtrl.value,
                                prefixIcon: const Icon(Icons.lock_outline_rounded),
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
                                if(controller.lastNameCtrl.value.text.isEmpty){
                                  toast(error: "Error", msg: "Enter Lastname name",);
                                  return;
                                }

                                if(SignupPageController.instance2.gsignBool.isTrue?controller.passwordCtrl.value.text.isNotEmpty:controller.emailCtrl.value.text.isEmpty){
                                  toast(error: "Error", msg: "Enter the Email Id",);

                                  return;
                                }
                                if (SignupPageController.instance2.gsignBool.isTrue?controller.passwordCtrl.value.text.isNotEmpty:!GetUtils.isEmail(controller.emailCtrl.value.text)
                                ){ toast(error: "Error", msg: "Enter valid Email Id",);

                                return;}

                                if(controller.phoneCtrl.value.text.isEmpty){
                                  toast(error: "Error", msg: "Enter Phone number",);

                                  return;
                                }
                                if(SignupPageController.instance2.gsignBool.isTrue?controller.passwordCtrl.value.text.isNotEmpty:controller.passwordCtrl.value.text.isEmpty){
                                  toast(error: "Error", msg: "Enter Password",);

                                  return;
                                }
                                if(SignupPageController.instance2.gsignBool.isTrue?controller.passwordCtrl.value.text.isNotEmpty:controller.passwordCtrl.value.length<=7){
                                  toast(error: "Error", msg: "Password must be 8 digit",);

                                  return;
                                }
                                if(SignupPageController.instance2.gsignBool.isTrue?controller.passwordCtrl.value.text.isNotEmpty:controller.passCtrl.value.text.isEmpty){
                                  toast(error: "Error", msg: "Enter the Confirm Password",);

                                  return;
                                }
                                if(SignupPageController.instance2.gsignBool.isTrue?controller.passwordCtrl.value.text.isNotEmpty:(controller.passwordCtrl.value.text!=controller.passCtrl.value.text)){
                                  toast(error: "Error", msg: "Enter the Password not match",);

                                  return;
                                }
                                //  if(SignupPageController.instance2.gsignBool.isTrue){

                                if(formkey_.currentState!.validate()){
                                  controller.checkuserValid();
                                }
                                //   }

                                // controller.verifyPhoneNumber();

                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40),
                                backgroundColor: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                                foregroundColor: const Color(0xff11323B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4.0,
                              ),
                              child: Text(
                                "submit".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .primary),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.OTP_PAGE);
                  },
                  child: Text(
                    "already_have_an_account".tr,
                    style:
                    TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .secondary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN_PAGE);
                        //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text(
                        "login".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary),
                      )),
                ),
                Space(8)
              ],
        ),
            ),
          ),
        ],
      ),
    );
  }
}
