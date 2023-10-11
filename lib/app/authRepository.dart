import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/error.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/rest_call_controller/rest_call_controller.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';

import '../data/local/my_shared_pref.dart';
import '../global.dart';
import 'modules/register_login/Model/loginGmailModel.dart';

class AuthenticationRespository extends GetxController {
  static AuthenticationRespository get instance => Get.find();
  final auth_ = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationid = "".obs;
  final pinController = TextEditingController().obs;
  var logingmaildata = LoginGmailModel().obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString guid = "".obs;
  RxString gemail = "".obs;
  RxString gname = "".obs;
  final _restCallController = Get.put(restCallController());
  RxBool gsignBool = false.obs;
  RxInt resendToken = 0.obs;
  RxInt secondsRemaining = 120.obs;
  RxBool enableResend = false.obs;
  RxBool gsignhidetextfield = false.obs;
  late Timer timer;
  RxBool errorinotp=false.obs;

  @override
  void onReady() {
    // TODO: implement onReady

    firebaseUser = Rx<User?>(auth_.currentUser);
    firebaseUser.bindStream(auth_.userChanges());

    //ever(firebaseUser, (callback) => setInitialScreen);
    super.onReady();
  }



  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  // setInitialScreen(User? user) {
  //   user == null
  //       ? Get.offAllNamed(Routes.SPLASH_SCREEN)
  //       : Get.offAllNamed(Routes.HOME);
  // }

  void phoneAuthentication(phoneno) async {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      enableResend.value = false;
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer.cancel();
      }
    });
    await auth_.verifyPhoneNumber(
      phoneNumber: phoneno,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (credential) async {
        pinController.value.setText(credential.smsCode.toString());
        await auth_.signInWithCredential(credential);
      },
      verificationFailed: (error) {
        if (error == "invalid-phone-number") {
          toast(error: "Error", msg: 'The provided phone number is not valid');
        } else {
          toast(error: "Failed", msg: 'Maximum OTP reached, Try again later');
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationid.value = verificationId;
        resendToken.value = forceResendingToken!;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationid.value = verificationId;
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    var credentails;
    try {
      errorinotp.value=false;
       credentails = await auth_.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationid.value, smsCode: otp));
      // if (credentails.user != null) {
      //   return  toast(error: "user is signed in", msg: "OTP verification successful");
      //   // OTP verification successful, user is signed in
      // } else {
      //   // OTP verification failed
      //   return  toast(error: "Error", msg: "OTP verification failed");
      // }

    } catch (e) {
      errorinotp.value=true;
      if (pinController.value.length == 0) {
      return  toast(error: "Error", msg: "Enter 6-digit Otp");
    }


  toast(error: "Error", msg: "Invalid Otp");

    }

    return credentails.user != null ? true : false;
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(
          credential);
      guid.value = userCredential.user!.uid;
      gemail.value = userCredential.user!.email!;
      gname.value = userCredential.user!.displayName!;
      // print("$uid");
      // Get.toNamed(Routes.MASJID_FINDER);
      // Once signed in, return the UserCredential
      return userCredential;
    } on FirebaseAuthException catch (e) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw e.message.toString();
    } catch (e) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      print('Unexpected error occurred: $e');
      throw e.toString();
    }
  }

  authId() async {
    log("rrrrrrrrrr${guid.value}");
    var header = """
query Login_With_Gmail(\$authId: String, \$deviceId: String!) {
  Login_With_Gmail(auth_id_: \$authId, device_id: \$deviceId) {
    masjid_id
    message
    refresh_token
    token
    user_id
  }
}
    """;

    var body = {
      "authId": "${guid.value}",
      "deviceId": "${MySharedPref.getFcmToken()}",
    };
    var res = await _restCallController.gql_query(header, body);
    log("wwww${res}");

    if (res["ERROR"] == "Please Complete The Registration Process For Masjid Membership") {

      Get.toNamed(Routes.SIGNUP_PAGE);
      if(res.toString().contains("ERROR")){
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
        toast(error: "Error", msg: "${res["ERROR"]}");
      }
      return;
    }
    if (res["ERROR"] == "Request Not Approved") {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      if(res.toString().contains("ERROR")){
        toast(error: "Error", msg: "${res["ERROR"]}");
      }
      return ;
    }
    // if(res.toString().contains("ERROR")){
    //  if(res['ERROR']=="Masjid Registration Pending"){
    //     Get.toNamed(Routes.MASJID_FINDER);
    //  }
    //  if(res['ERROR']=="Masjid Approval Pending"){
    //    return;
    //  }
    // }

    if (res["Login_With_Gmail"]["message"] == "Authentication Successfully") {
      logingmaildata.value = loginGmailModelFromJson(json.encode(res));
      var hh = res["Login_With_Gmail"]["message"];
      toast(error: "SUCCESS", msg: "${hh}");
      await Get.offAllNamed(Routes.HOME, arguments: [
        logingmaildata.value.loginWithGmail!.userId,
        logingmaildata.value.loginWithGmail!.masjidId,
        logingmaildata.value.loginWithGmail!.token
      ]);
    }

    // if (res.toString().contains("SUCCESS")) {
    //   var hh = res["SUCCESS"]["Register_User"]["message"];
    //   toast(error: "SUCCESS", msg: "${hh}");
    //   Get.offAllNamed(Routes.MASJID_REQUEST);
    // } else if(res.toString().contains('ERROR')){
    //
    // }
    return res;
  }


// Future<UserCredential> signInWithGoogle() async {
//     try {
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//
//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       // Once signed in, return the UserCredential
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch(_){
//
//     }
//   }
}
