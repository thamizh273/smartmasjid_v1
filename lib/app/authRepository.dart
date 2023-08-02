import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/error.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/rest_call_controller/rest_call_controller.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';

import '../global.dart';

class AuthenticationRespository extends GetxController {
  static AuthenticationRespository get instance => Get.find();
  final auth_ = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationid = "".obs;
  final pinController = TextEditingController().obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
      String guid ="";
      String gemail ="";
      String gname ="";
  final _restCallController = Get.put(restCallController());
  @override
  void onReady() {
    // TODO: implement onReady

    firebaseUser = Rx<User?>(auth_.currentUser);
    firebaseUser.bindStream(auth_.userChanges());

    //ever(firebaseUser, (callback) => setInitialScreen);
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
      UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
       guid = userCredential.user!.uid;
       gemail = userCredential.user!.email!;
       gname = userCredential.user!.displayName!;
     // print("$uid");
     // Get.toNamed(Routes.MASJID_FINDER);
      // Once signed in, return the UserCredential
      return userCredential;

    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw e.message.toString();
    } catch (e) {
      print('Unexpected error occurred: $e');
      throw e.toString();
    }

  }

  authId() async {

    var header = """
mutation Mutation(\$authId: String) {
  Login_With_Gmail(auth_id_: \$authId) {
    message
    refresh_token
    token
    user_id
  }
}
    """;

    var body = {
      "authId": "${guid}",
    };
    var res = await _restCallController.gql_mutation(header, body);
    print("wwww${res}");
    if(res.toString().contains("ERROR")){
     if(res['ERROR']=="Masjid Registration Pending"){
        Get.toNamed(Routes.MASJID_FINDER);
     }
     if(res['ERROR']=="Masjid Approval Pending"){
       return;
     }
    }

    if (res.toString().contains("SUCCESS")) {
      var hh = res["SUCCESS"]["Login_With_Gmail"]["message"];
      toast(error: "SUCCESS", msg: "${hh}");
      Get.offAllNamed(Routes.HOME);
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
