import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartmasjid_v1/app/modules/masjidFinder/controllers/masjid_finder_controller.dart';

import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';
import 'package:smartmasjid_v1/app/rest_call_controller/rest_call_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../authRepository.dart';
import '../../../routes/app_pages.dart';

class RegisterLoginController extends GetxController {
  static RegisterLoginController get instance => Get.find();
  static AuthenticationRespository get instance1 => Get.find();

  final  masjidctrl =Get.put(MasjidFinderController());

  //TODO: Implement RegisterLoginController

  var googleSignIn = GoogleSignIn();
  var displayUseName = "";
  var isGoogleSign=false.obs;
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
Future<void>googleSignIns() async{
    try{
      isGoogleSign.value=true;
      await AuthenticationRespository.instance.signInWithGoogle();
      await AuthenticationRespository.instance.authId();

      //await masjidctrl.loginGmail("");
      isGoogleSign.value=false;

    }catch(e){
      isGoogleSign.value=false;
      toast(error: "Error", msg: "${e.toString()}");

    }
}

//   loginGmail() async {
//     print('${instance1.uid}');
//     var header = """
// mutation Mutation(\$authId: String, \$language: String, \$userType: String) {
//   Login_With_Gmail(auth_id_: \$authId, language_: \$language, user_type_: \$userType) {
//     message
//     refresh_token
//     token
//     user_id
//   }
// }
//     """;
//
//     var body = {
//       "authId": "dgfdgfh",
//       "language": "",
//     };
//     var res = await _restCallController.gql_mutation(header, body);
//     print("wwww${res}");
//     if(res.toString().contains("ERROR")){
//       Get.toNamed(Routes.MASJID_FINDER);
//     }
//     // if (res.toString().contains("SUCCESS")) {
//     //   var hh = res["SUCCESS"]["Register_User"]["message"];
//     //   toast(error: "SUCCESS", msg: "${hh}");
//     //   Get.offAllNamed(Routes.MASJID_REQUEST);
//     // } else if(res.toString().contains('ERROR')){
//     //
//     // }
//     return res;
//   }
  // Future<UserCredential> signInWithGoogles() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  // void signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     displayUseName = googleUser!.displayName!;
  //     update();
  //     print(displayUseName);
  //     Get.offNamed(Routes.HOME);
  //   } catch (e) {
  //     toast(error: "Error", msg: e.toString());
  //   }
  //   // Trigger the authentication flow
  // }

// void signOut() async {
//   await _auth.signOut();
//   await _googleSignIn.signOut();
//
// }

// void signOutGoogle() async {
//   await _googleSignIn.signOut();
//   _loggedIn.value = false;
// }
}
