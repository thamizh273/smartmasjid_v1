

import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartmasjid_v1/app/authRepository.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../loginPage/controllers/login_page_controller.dart';
import '../model/checkUserModel.dart';

class SignupPageController extends GetxController {
  //TODO: Implement SignupPageController
  static SignupPageController get instance =>Get.find();
  static AuthenticationRespository get instance2 => Get.find();
    var checkuserData=CheckUserModel().obs;
  final _restCallController = Get.put(restCallController());
  final _logincontrl = Get.put(LoginPageController());

  @override
  void onInit() {
    // TODO: implement onInit
    print("ppppp${instance2.gemail.value}");
    print("ppppppp${instance2.gname.value}");
    super.onInit();
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
  Rx<TextEditingController> firstNameCtrl = TextEditingController().obs;
  Rx<TextEditingController> middleCtrl = TextEditingController().obs;
  Rx<TextEditingController> lastNameCtrl = TextEditingController().obs;
  RxBool obscureTextpass = true.obs;
  RxBool obscureTextcpass = true.obs;
  RxBool isLoadingscheckuser = true.obs;

//  RxInt resendOtp = 0.obs;
//  var verificationid = "".obs;
  //RxString otp1 = "".obs;

  // late var uids;


 void phoneAuthentication(String phoneno ){
   AuthenticationRespository.instance.phoneAuthentication(phoneno);
 }
  checkuserValid() async {
   print("${emailCtrl.value.text}");
   print("+${selectedCountry.value.phoneCode}${phoneCtrl.value.text}");
    isLoadingscheckuser.value = true;
    var header = """
query Query(\$emailId: String, \$phoneNumber: String) {
  Check_User_Valid_Verification(email_id_: \$emailId, phone_number_: \$phoneNumber)
}
    """;

    var body = {
      "emailId":instance2.gsignBool.isTrue?instance2.gname.value:"${emailCtrl.value.text}",
      "phoneNumber": "+${selectedCountry.value.phoneCode}${phoneCtrl.value.text}"
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data sign ${json.encode(res)}");
    isLoadingscheckuser.value = false;
  checkuserData.value = checkUserModelFromJson(json.encode(res));
    if(res.toString().contains("Please use a different email or phone number to proceed")){
      toast(error: "Error", msg: res["Check_User_Valid_Verification"]);

      return  ;
    }else if(instance2.gsignBool.isTrue){
      Get.toNamed(Routes.MASJID_FINDER);
    }
    else if(res.toString().contains("The provided email address or phone number is available for registration")){
      phoneAuthentication("+${selectedCountry.value.phoneCode}${phoneCtrl.value.text.trim()}");
      Get.toNamed(Routes.OTP_PAGE);
    }
    // else{
    //   phoneAuthentication("+${selectedCountry.value.phoneCode}${phoneCtrl.value.text.trim()}");
    //   Get.toNamed(Routes.OTP_PAGE);
    //
    // }
   update();



  }
  forgetcheckuserValid() async {
    print("+${selectedCountry.value.phoneCode}${_logincontrl.phoneLCtrl.value.text}");
    isLoadingscheckuser.value = true;
    var header = """
query Query(\$emailId: String, \$phoneNumber: String) {
  Check_User_Valid_Verification(email_id_: \$emailId, phone_number_: \$phoneNumber)
}
    """;

    var body = {
      "emailId": "qwe",
      "phoneNumber": "+${selectedCountry.value.phoneCode}${_logincontrl.phoneLCtrl.value.text}"
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data sign ${json.encode(res)}");
    isLoadingscheckuser.value = false;
  checkuserData.value = checkUserModelFromJson(json.encode(res));
    if(res.toString().contains("Please use a different email or phone number to proceed")){
      toast(error: "Error", msg: "Otp sent your Mobile no");
      phoneAuthentication("+${selectedCountry.value.phoneCode}${_logincontrl.phoneLCtrl.value.text.trim()}");
      
      Get.toNamed(Routes.OTP_PAGE);
      return  ;
    } else{

     toast(error: 'Error', msg: "User Not Fount");

    }
   update();



  }

// Future<UserCredential?> createUserWithPhoneAndPassword() async {
//   print(otp1.value);
//   try {
//     final AuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: '${verificationid.value}',
//       // Pass the verification ID received in the codeSent callback
//       smsCode: '${otp1.value}', // Pass the SMS code entered by the user
//     );
//
//     final UserCredential userCredential =
//     await firebaseAuth.signInWithCredential(credential);
//
//
//     return userCredential;
//   } on FirebaseAuthException catch (error) {
//     Get.snackbar("Error", error.toString());
//     // Handle error
//     print('Error signing up: $error');
//     return null;
//   }
// }
//
//
// Future<void> verifyPhoneNumber() async {
//   if (selectedCountry.value.countryCode == 'IN'){
//
//   }
//   print("ssss ${selectedCountry.value.phoneCode}${phoneCtrl.value.text}");
//   try {
//     await firebaseAuth.verifyPhoneNumber(
//       phoneNumber: "+${selectedCountry.value.phoneCode}${phoneCtrl.value
//           .text}",
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Automatic verification (e.g., using a test phone number)
//         final UserCredential userCredential =
//         await firebaseAuth.signInWithCredential(credential);
//       final  uids = userCredential.user?.uid;
//
//         if (uids != null) {
//
//         } else {
//           // OTP verification failed, show an error message and stay on the same page
//           Get.snackbar(
//             'Error',
//             'Invalid OTP. Please try again.',
//             snackPosition: SnackPosition.BOTTOM,
//           );
//         }
//
//         // UID retrieved successfully, do something with it
//         print('User UID: $uids');
//       },
//
//       verificationFailed: (FirebaseAuthException e) {
//         // Verification failed
//         print('Verification failed: $e');
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         resendOtp.value = resendToken!;
//         verificationid.value = verificationId;
//         // Save the verification ID and resend token for later use
//         // e.g., store it in a variable
//         print('Verification ID: $verificationId');
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-retrieval timeout
//         // You can handle it manually or ignore it for automatic verification
//         print('Auto-retrieval timeout: $verificationId');
//       },
//     );
//   } catch (error) {
//     // Handle error
//     print('Error verifying phone number: $error');
//   }
// }
//
//
// void signUpWithPhoneAndPassword() async {
//   final userCredential = await createUserWithPhoneAndPassword();
//
//   if (userCredential != null) {
//
//       Get.dialog(Padding(
//         padding:
//         EdgeInsets.symmetric(vertical: 20.h),
//         child: AlertDialog(
//           backgroundColor:
//           Get.theme.colorScheme.primary,
//           shape: RoundedRectangleBorder(
//               borderRadius:
//               BorderRadius.circular(10)),
//
//           // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
//           content: Stxt(
//             text: "OTP Verified successfully",
//             size: f3,
//             weight: FontWeight.bold,
//             color: Colors.white,
//             textAlign: TextAlign.center,
//           ),
//           icon: Icon(
//             Icons.check_circle,
//             size: 80.r,
//           ),
//           iconColor: Colors.green,
//           //iconPadding: EdgeInsets.all(20),
//         ),
//       ));
//       Future.delayed(Duration(seconds: 2), () {
//         Get.toNamed(Routes.MASJID_FINDER);
//       });
//
//     // OTP verification successful, navigate to the homepage
//     // Replace `HOME` with the actual route name for your homepage
//   } else {
//     // OTP verification failed, show an error message and stay on the same page
//     Get.snackbar(
//       'Error',
//       'Invalid OTP. Please try again.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }
}

///
