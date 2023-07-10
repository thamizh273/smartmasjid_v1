import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/export.dart';

class SignupPageController extends GetxController {
  //TODO: Implement SignupPageController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Rx<Country> selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  ).obs;

  Rx<TextEditingController> emailCtrl = TextEditingController().obs;
  Rx<TextEditingController> phoneCtrl = TextEditingController().obs;
  Rx<TextEditingController> passwordCtrl = TextEditingController().obs;
  Rx<TextEditingController> passCtrl = TextEditingController().obs;
  RxBool obscureTextpass = true.obs;
  RxBool obscureTextcpass = true.obs;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> createUserWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: emailCtrl.value.text,
        password: passCtrl.value.text,
      );

      return userCredential;
    } catch (error) {
      // Handle error
      print('Error signing up: $error');
      return null;
    }
  }

  void signUpWithEmailAndPassword() async {
    final userCredential = await createUserWithEmailAndPassword();

    if (userCredential != null) {
      final uid = userCredential.user?.uid;
      if (uid != null) {
        // UID retrieved successfully, do something with it
        print('User UID: $uid');
      }
      // Sign-up successful, navigate to the next screen
      // You can use Get.to or Navigator.push for navigation
    } else {
      // Sign-up failed, show an error message
      Get.snackbar(
        'Error',
        'Failed to sign up. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    update();
  }
}
