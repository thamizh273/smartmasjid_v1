
import 'package:firebase_auth/firebase_auth.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';

class LoginPageController extends GetxController {
  //TODO: Implement LoginPageController


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
  Rx<TextEditingController> emailLCtrl = TextEditingController().obs;
  Rx<TextEditingController> phoneLCtrl = TextEditingController().obs;
  Rx<TextEditingController> passwordLCtrl = TextEditingController().obs;

  RxBool obscureTextLpass = true.obs;
  RxBool showPhoneNumberField = true.obs;



  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailLCtrl.value.text,
        password: passwordLCtrl.value.text,
      );

      return userCredential;
    }on FirebaseAuthException catch (e) {
      String errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User not found. Please check your email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address. Please enter a valid email.';
          break;
        default:
          errorMessage = 'An error occurred while signing in. Please try again later.';
      }

      Get.snackbar(
        'Sign In Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 15),
     // backgroundColor: Colors.redAccent.withOpacity(.3)
       titleText: Stxt(text: "Sign In Error", size: f3,color: Colors.red ,weight: FontWeight.bold,),
     messageText: Stxt(text: errorMessage, size: f2,color: Colors.white ,),
      //  colorText: Colors.red
      );

      print('Error signing in: ${e.code}');
      return null;
    } catch (error) {
      // Handle error
      print('Error signing in: $error');
      return null;
    }
  }

  void signInWithEmailPassword() async {
    final userCredential = await signInWithEmailAndPassword();

    if (userCredential != null) {
      final uid = userCredential.user?.uid;
      if (uid != null) {
        // UID retrieved successfully, do something with it
        print('User UID: $uid');
      }
      Get.snackbar(
        'Success',
        'Sucessfully login',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed(Routes.HOME);
      // Sign-in successful, navigate to the next screen
      // You can use Get.to or Navigator.push for navigation
    } else {
      print('Sign-in failed, show an error message')  ;
      // Get.snackbar(
      //   'Error',
      //   'Failed to sign in. Please check your credentials.',
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }
  }
}

