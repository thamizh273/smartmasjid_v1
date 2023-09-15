import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartmasjid_v1/app/modules/language_page/controllers/language_page_controller.dart';
import 'package:smartmasjid_v1/app/modules/signup_page/controllers/signup_page_controller.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../authRepository.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../faceAuth/controllers/face_auth_controller.dart';
import '../Model/masjidFinderModel.dart';

class MasjidFinderController extends GetxController {
  final _signctrl = Get.put<SignupPageController>(SignupPageController());

  static AuthenticationRespository get instance1 => Get.find();
  final _langctrl = Get.find<LanguagePageController>();
  final _restCallController = Get.put(restCallController());
  final _faceAuthctrl = Get.put(FaceAuthController());
  var masjidListdata = MasjidFinderModel().obs;
  // var uid = FirebaseAuth.instance.currentUser;

  // RxList filteredMasjidList = [].obs;
  //TODO: Implement MasjidFinderController
  // var seller_list_model=SelllerListModel().obs;
  @override
  void onInit() {
   // log("dddddvv${uid[0]}jjjj");
 //   print("dddddvv${uid[0].value}jjjjj");
    //filteredMasjidList = masjidListdata.value.getMasjidFilter.obs;
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

  FocusNode searchFocusNode = FocusNode();
  Rx<TextEditingController> searchctrl_ = TextEditingController().obs;
  RxString selectedCountry = ''.obs;
  RxString selectedState = ''.obs;
  RxString selectedCity = ''.obs;

  RxBool isLoading = false.obs;

  RxString searchQuery = ''.obs;

  // List<Masjid> masjidList = [
  //   Masjid(name: 'Masjid-e-Nooraniah', location: 'Muthiyalpet', imagePath: 'assets/images/masjidselc.png'),
  //   Masjid(name: 'Masjid Al-Falah', location: 'New Town', imagePath: 'assets/images/masjidselc.png'),
  //   Masjid(name: 'Masjid Al-Huda', location: 'City Center', imagePath: 'assets/images/masjidselc.png'),
  //   Masjid(name: 'Masjid Al-Hakh', location: 'City Center', imagePath: 'assets/images/masjidselc.png'),
  // ];

  //
  // RxList<GetMasjidFilter> filterMasjidsByName(String query) {
  //   return masjidList.where((masjid) => masjid.name.toLowerCase().contains(query.toLowerCase())).toList().obs;
  // }

  masjidFinder_get(String value,masjidId) async {
    masjidListdata.value.getMasjidFilter = null;
    isLoading.value = true;
    var header = """
query Get_masjid_filter(\$searchBy: String, \$id: String) {
  get_masjid_filter(search_by: \$searchBy, id_: \$id) {
    area
    id
    masjid_image
    masjid_name
    pin_code
    city
    district
    state
  }
}
    """;
    var body = {
      "searchBy": "${value}",
      "id": "${masjidId}"
    };
    var res = await _restCallController.gql_query(header, body);
    print("lllll");
    log(json.encode(res));
    print("lllll");

    isLoading.value = false;
    update();
    masjidListdata.value = masjidFinderModelFromJson(json.encode(res));

    update();
  }

  signUpComplete(String? id) async {
    var header = """
mutation Mutation(\$masjidid: String, \$profileImage: String, \$firstName: String, \$lastName: String, \$phoneNumber: String, \$emailId: String, \$passWord: String, \$language: String, \$userType: String, \$authUid: String, \$addAddress: edit_address) {
  Register_User(masjidid: \$masjidid, profile_image: \$profileImage, first_name: \$firstName, last_name: \$lastName, phone_number: \$phoneNumber, email_id: \$emailId, pass_word: \$passWord, language: \$language, user_type: \$userType, auth_uid_: \$authUid, add_address: \$addAddress) {
    message
    user_id
  }
}
    """;

    var body = {
      "masjidid": "${id}",
      "profileImage": "${_faceAuthctrl.base64Image}",
      "firstName": _signctrl.firstNameCtrl.value.text,
      "lastName": _signctrl.lastNameCtrl.value.text,
      "emailId": "${_signctrl.emailCtrl.value.text}",
      "passWord": _signctrl.passwordCtrl.value.text,
      "language": _langctrl.selectedLang.value,
      "userType": "member",
      "authUid": "",
      "phoneNumber":
          "+${_signctrl.selectedCountry.value.phoneCode}${_signctrl.phoneCtrl.value.text}",
      "addAddress": {
        "address_type": "primary",
        "area": "",
        "country": "",
        "district": "",
        "door_no": "",
        "pincode": "",
        "state": "",
        "street_name": ""
      }
    };
    var res = await _restCallController.gql_mutation(header, body);

    if (res.toString().contains("SUCCESS")) {
      var hh = res["SUCCESS"]["Register_User"]["message"];
      toast(error: "SUCCESS", msg: "${hh}");
      Get.offAllNamed(Routes.MASJID_REQUEST);
    }
    return;
  }

  loginGmail(String? id) async {
    log('ss${instance1.guid.value}');
    print('ss${instance1.guid.value}');
    log('ss${instance1.gemail}');
    print('ss${instance1.gemail}');
    log('ss${instance1.gname}');
    print('ss${instance1.gname}');
    log('ss${id}');
    print('ss${_langctrl.selectedLang.value}');
    log('ss${_langctrl.selectedLang.value}');
    var header = """
query Login_With_Gmail(\$authId: String, \$language: String, \$userName: String, \$gmail: String, \$userType: String, \$masjidid: String, \$deviceId: String!) {
  Login_With_Gmail(auth_id_: \$authId, language_: \$language, user_name_: \$userName, gmail_: \$gmail, user_type_: \$userType, masjidid_: \$masjidid, device_id: \$deviceId) {
    masjid_id
    message
    refresh_token
    token
    user_id
  }
}
    """;

    var body = {
      "authId": "${instance1.guid.value}",
      "language": "${_langctrl.selectedLang.value}",
      "userType": "member",
      "masjidid": "${id}",
      "gmail": "${instance1.gemail}",
      "userName": "${instance1.gname}",
      "deviceId": "${MySharedPref.getFcmToken()}",
    };
    var res = await _restCallController.gql_query(header, body);
    log("wwww${json.encode(res)}");

    if (res.toString().contains("Login_With_Gmail")) {
      var hh = res["Login_With_Gmail"]["message"];
      toast(error: "SUCCESS", msg: "${hh}");
      Get.offAllNamed(Routes.MASJID_REQUEST);

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
}
