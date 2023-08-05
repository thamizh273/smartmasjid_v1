
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../Model/GetUserIDModel.dart';
import '../Model/logineithmobileNo.dart';

class LoginPageController extends GetxController {
  //TODO: Implement LoginPageController
  final _restCallController = Get.put(restCallController());

  Rx<TextEditingController> emailLCtrl = TextEditingController().obs;
  Rx<TextEditingController> phoneLCtrl = TextEditingController().obs;
  Rx<TextEditingController> passwordLCtrl = TextEditingController().obs;

  RxBool obscureTextLpass = true.obs;
  RxBool showPhoneNumberField = true.obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;

  var getUserId = GetUserIdModel().obs;
  var getUserIdMobile = GetUserIdPhoneModel().obs;



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






  signUpUser() async {
    print("mail");
    isLoading.value=true;
    //masjidListdata.value.getMasjidFilter=null;

    var header = """
query Login_User(\$password: String, \$byEmail: String) {
  Login_User(password_: \$password, by_email: \$byEmail) {
    message
    refresh_token
    token
    user_id
  }
}
    """;
    var body = {
      "byEmail": "${emailLCtrl.value.text}",
      "password": "${passwordLCtrl.value.text}"
    };

    // {
    //   "password": "${passwordLCtrl.value.text}",
    //   "byEmail": "${emailLCtrl.value.text}",
    //   "byPhone": "${phoneLCtrl.value.text}"
    // };
    var res = await _restCallController.gql_query(header, body);
      isLoading.value=false;
    getUserId.value=getUserIdModelFromJson(json.encode(res));

   // print("ttttt");
   //      log(json.encode(res));
   //  print("ttttt");
   //         update();

      if(res.toString().contains("Login_User"))  {
        var hh =res["Login_User"]["message"];
         toast(error: "SUCCESS", msg: "${hh}");
        print("ff");
        print( getUserId.value.loginUser!.userId);

     await Get.offAllNamed(Routes.HOME,arguments: [ getUserId.value.loginUser!.userId]);
        // print("ff");
        // print(getUserId.value.loginUser!.userId);
    }






  }
  signUpPhone(String phoneCode) async {
    print("phone");
    isLoading1.value=true;
    //masjidListdata.value.getMasjidFilter=null;

    var header = """
query Login_User(\$password: String, \$byPhone: String) {
  Login_User(password_: \$password, by_phone: \$byPhone) {
    message
    refresh_token
    token
    user_id
  }
}
    """;
    var body = {
      "byPhone": "+${phoneCode}${phoneLCtrl.value.text}",
      "password": "${passwordLCtrl.value.text}"
    };

    var res = await _restCallController.gql_query(header, body);
      isLoading1.value=false;
    getUserIdMobile.value=getUserIdPhoneModelFromJson(json.encode(res));

   print("ttttt");
        log(json.encode(res));
    print("ttttt");
           update();

      if(res.toString().contains("Login_User"))  {
        var hh =res["Login_User"]["message"];
         toast(error: "SUCCESS", msg: "${hh}");
       // print("ff");
      //  print( getUserId.value.loginUser!.userId);
     await Get.offAllNamed(Routes.HOME,arguments: [getUserIdMobile.value.loginUser!.userId]);

   }






  }







  //
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  // Future<UserCredential?> signInWithEmailAndPassword() async {
  //   try {
  //     final UserCredential userCredential =
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //       email: emailLCtrl.value.text,
  //       password: passwordLCtrl.value.text,
  //     );
  //
  //     return userCredential;
  //   }on FirebaseAuthException catch (e) {
  //     String errorMessage = '';
  //
  //     switch (e.code) {
  //       case 'user-not-found':
  //         errorMessage = 'User not found. Please check your email.';
  //         break;
  //       case 'wrong-password':
  //         errorMessage = 'Wrong password. Please try again.';
  //         break;
  //       case 'invalid-email':
  //         errorMessage = 'Invalid email address. Please enter a valid email.';
  //         break;
  //       default:
  //         errorMessage = 'An error occurred while signing in. Please try again later.';
  //     }
  //     Get.snackbar(
  //       'Sign In Error',
  //       errorMessage,
  //       snackPosition: SnackPosition.BOTTOM,
  //       margin: EdgeInsets.only(bottom: 15),
  //    // backgroundColor: Colors.redAccent.withOpacity(.3)
  //      titleText: Stxt(text: "Sign In Error", size: f3,color: Colors.red ,weight: FontWeight.bold,),
  //    messageText: Stxt(text: errorMessage, size: f2,color: Colors.white ,),
  //     //  colorText: Colors.red
  //     );
  //
  //     print('Error signing in: ${e.code}');
  //     return null;
  //   } catch (error) {
  //     // Handle error
  //     print('Error signing in: $error');
  //     return null;
  //   }
  // }
  //
  // void signInWithEmailPassword() async {
  //   final userCredential = await signInWithEmailAndPassword();
  //
  //   if (userCredential != null) {
  //     final uid = userCredential.user?.uid;
  //     if (uid != null) {
  //       // UID retrieved successfully, do something with it
  //       print('User UID: $uid');
  //     }
  //     Get.snackbar(
  //       'Success',
  //       'Sucessfully login',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     Get.toNamed(Routes.HOME);
  //     // Sign-in successful, navigate to the next screen
  //     // You can use Get.to or Navigator.push for navigation
  //   } else {
  //     print('Sign-in failed, show an error message')  ;
  //     // Get.snackbar(
  //     //   'Error',
  //     //   'Failed to sign in. Please check your credentials.',
  //     //   snackPosition: SnackPosition.BOTTOM,
  //     // );
  //   }
  // }
}

