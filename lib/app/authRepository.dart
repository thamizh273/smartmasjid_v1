import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';

import '../global.dart';

class AuthenticationRespository extends GetxController {
  static AuthenticationRespository get instance => Get.find();
  final auth_ = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationid = "".obs;
  final pinController = TextEditingController().obs;

  @override
  void onReady() {
    // TODO: implement onReady

    firebaseUser = Rx<User?>(auth_.currentUser);
    firebaseUser.bindStream(auth_.userChanges());
  //  ever(firebaseUser, (callback) => setInitialScreen);
    super.onReady();
  }

  // setInitialScreen(User? user) {
  //   user == null
  //       ? Get.offAllNamed(Routes.SPLASH_SCREEN)
  //       : Get.offAllNamed(Routes.HOME);
  // }

  void phoneAuthentication(phoneno) async {
    await auth_.verifyPhoneNumber(
      phoneNumber: phoneno,
      verificationCompleted: (credential) async {
        pinController.value.setText(credential.smsCode.toString());
        await auth_.signInWithCredential(credential);
      },
      verificationFailed: (error) {
        if (error == "invalid-phone-number") {
          toast(error: "Error", msg: 'The provided phone number is not valid');
        } else {
          toast(error: "Error", msg: 'Something went wrong. Try again.');
        }
        ;
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationid.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationid.value = verificationId;
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    var credentails = await auth_.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationid.value, smsCode: otp));
    return credentails.user != null ? true : false;
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //
  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     // Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch(_){
  //     const ex= T
  //   }
  // }
}
