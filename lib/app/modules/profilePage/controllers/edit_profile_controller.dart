import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/views/profile_page_view.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/app/rest_call_controller/rest_call_controller.dart';

import '../../../../utils/localization/localization.dart';
import '../../../authRepository.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../home/Model/getUserModel.dart';
import '../../language_page/controllers/language_page_controller.dart';

class EditProfileController extends GetxController {
  static HomeController get homectrl => Get.find();
  static AuthenticationRespository get authen => Get.find();

  RxBool isLoading = false.obs;
  RxBool isLoadingLogout = false.obs;
  RxBool isLoadingPic = false.obs;
  final _restcallController = Get.put(restCallController());
  final lanctrl = Get.put(LanguagePageController());
  Rx<XFile> image = XFile('').obs;
  String? base64Image;
  RxString name= "${homectrl.getUserData.value.getUserById!.firstName}" "${homectrl.getUserData.value.getUserById!.lastName}".obs;
  RxBool isPicked = false.obs;
  RxBool dummy = false.obs;
  RxBool ontap =false.obs;
  //TODO: Implement EditProfileController
  var selectedDate = DateTime.now().obs;
  var dobController = TextEditingController();
  var doorNoctrl = TextEditingController(
      text: homectrl.getUserData.value.getUserById!.address![0].doorNo);
  var streetctrl = TextEditingController(
      text: homectrl.getUserData.value.getUserById!.address![0].streetName);
  var districctrl = TextEditingController(
      text: homectrl.getUserData.value.getUserById!.address![0].district);
  var statectrl = TextEditingController(
      text: homectrl.getUserData.value.getUserById!.address![0].state);
  var pincodectrl = TextEditingController(
      text: homectrl.getUserData.value.getUserById!.address![0].pincode);
  var areactrl = TextEditingController(
      text: homectrl.getUserData.value.getUserById!.address![0].area);
  var firstnamectrl = TextEditingController(
      text: "${homectrl.getUserData.value.getUserById!.firstName}");
  var lastnamectrl = TextEditingController(
      text: "${homectrl.getUserData.value.getUserById!.lastName}");
  var mobilenumberctrl = TextEditingController(
      text: "${homectrl.getUserData.value.getUserById!.phoneNumber}");
  var emailctrl = TextEditingController(
      text: "${homectrl.getUserData.value.getUserById!.emailId}");

  @override
  void onInit() {
   // homectrl.getUserDetails(homectrl.getUserData.value.getUserById!.id);
   homectrl.getUserDetails(homectrl.getUserData.value.getUserById!.id,"${homectrl.box1.read('token')}");
    super.onInit();
    dobController.text =
        "${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dobController.dispose();

    super.onClose();
  }

  void pickImage({required bool isCamera}) async {
    XFile? _file;
    if (isCamera) {
      _file = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      _file = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (_file != null) {
      // Perform image cropping
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: _file.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),]
      );

      if (croppedFile != null) {
        _file = XFile(croppedFile.path);
      }
    }
    if (_file != null) {
      image.value = _file;
      isPicked.value = true;


      Uint8List bytes = await image.value.readAsBytes();
      base64Image = base64Encode(bytes);
      updateProfilePic(base64Image);
      update();
    } else {
      print("Image not Selected");
    }
    // if (_file != null) {
    //   image.value = XFile(_file.path);
    //   var rr = XFile(_file.name);
    //   print('fffff ${image.value}');
    //   print('fffff ${rr}');
    //   isPicked.value = true;
    // }
    // if (image.value.path.isNotEmpty) {
    //   Uint8List bytes = await image.value.readAsBytes();
    //   base64Image = base64Encode(bytes);
    //   log("imagess ${bytes}");
    //   print("imagess");
    //   log(base64Image!);
    //   print("imagess");
    //   updateProfilePic(base64Image);
    //   update();
    // } else {
    //   toast(error: "Failed", msg: "Image not Selected");
    //   print("Image not Selected");
    // }
  }
  logout() async {
    isLoadingLogout.value = true;

    var header =
    """mutation Log_Out_User(\$userId: ID!) {
  Log_Out_User(user_id_: \$userId) {
    message
    user_id
  }
}""";
    var body = {
      "userId": "${homectrl.getUserData.value.getUserById!.id}",
    };
    var res = await _restcallController.gql_mutation(header, body);
    log(json.encode(res));
    // homectrl.getUserData.value.getUserById!.profileImage = base64images;
    // homectrl.update();
    await GoogleSignIn().signOut();
    await authen.auth_.signOut();

    homectrl.box1.remove('fruits');
    homectrl.box1.remove('masjidId');
    homectrl.box1.remove('token');
    // lanctrl.langStore.remove('selectedindex');
    // lanctrl.langStore.remove('selectedLang');
  //  lanctrl.selectedRadioIndex.value=0;

    lanctrl.update();
      // Convert to a regular List before updating GetStorage

      update(); // Notify GetX that the state has changed

    homectrl.getUserData.value.getUserById!.id='';
    homectrl.getUserData.value.getUserById!.liveStatus=false;
    homectrl.getUserData.value.getUserById=null;

    homectrl.update();

    isLoadingLogout.value = false;
    if (res.toString().contains("SUCCESS")) {
      var hh = res["SUCCESS"]["Log_Out_User"]['message'];

      toast(error: "SUCCESS", msg: "${hh}");
      Get.offAllNamed(AppPages.INITIAL);
    }
    return ;
  }

  DateTime sixtyYearsAgo = DateTime.now().subtract(
      Duration(days: 60 * 365)); // Subtracting 60 years (approximation)

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: sixtyYearsAgo,
        lastDate: DateTime.now(),
        //initialEntryMode: DatePickerEntryMode.input,
        // initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select DOB',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'DOB',
        fieldHintText: 'Month/Date/Year',
        selectableDayPredicate: disableDate);
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      dobController.text =
          "${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}";
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(sixtyYearsAgo) && day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }

  updateProfilePic(String? base64images) async {
    isLoadingPic.value = true;
    var header =
        """ mutation Mutation(\$masjidId: ID, \$userId: String, \$profileImage: String) {
      Update_User(masjid_id: \$masjidId, user_id: \$userId, profile_image: \$profileImage)
    }""";
    var body = {
      "masjidId": "${homectrl.getUserData.value.getUserById!.masjidId!.id}",
      "userId": "${homectrl.getUserData.value.getUserById!.id}",
      "profileImage": "$base64images"
    };
    var res = await _restcallController.gql_mutation(header, body);
    print(json.encode(res));
    homectrl.getUserData.value.getUserById!.profileImage = base64images;
    homectrl.update();

    isLoadingPic.value = false;
    if (res.toString().contains("SUCCESS")) {
      var hh = res["SUCCESS"]["Update_User"];
      toast(error: "SUCCESS", msg: "${hh}");
    }
    return res;
  }

  updateProfile() async {
    isLoading.value = true;
    var header = """
    mutation Mutation(\$masjidId: ID, \$userId: String, \$firstName: String, \$lastName: String, \$phoneNumber: String, \$emailId: String, \$language: String, \$post: String, \$editAddress: edit_address) {
  Update_User(masjid_id: \$masjidId, user_id: \$userId, first_name: \$firstName, last_name: \$lastName, phone_number: \$phoneNumber, email_id: \$emailId, language: \$language, post: \$post, edit_address: \$editAddress)
}
     """;
    var body = {
      "masjidId": "${homectrl.getUserData.value.getUserById!.masjidId!.id}",
      "userId": "${homectrl.getUserData.value.getUserById!.id}",
      "firstName": "${firstnamectrl.text}",
      "lastName": "${lastnamectrl.text}",
      "phoneNumber": "",
      "emailId": "",
      "language": "",
      "post": "",
      "editAddress": {
        "address_type": "",
        "area": "${areactrl.text}",
        "country": "",
        "district": "${districctrl.text}",
        "door_no": "${doorNoctrl.text}",
        "pincode": "${pincodectrl.text}",
        "state": "${statectrl.text}",
        "street_name": "${streetctrl.text}"
      }
    };
    var res = await _restcallController.gql_mutation(header, body);
    print(json.encode(res));

  
    // homectrl.update();

    isLoading.value = false;
    homectrl.getUserData.value.getUserById!.firstName =  firstnamectrl.text;
    name.value =  firstnamectrl.text+lastnamectrl.text;

    homectrl.getUserData.value.getUserById!.lastName = lastnamectrl.text;
    homectrl.getUserData.value.getUserById!.address![0].streetName =
        streetctrl.text;
    homectrl.getUserData.value.getUserById!.address![0].doorNo =
        doorNoctrl.text;
    homectrl.getUserData.value.getUserById!.address![0].area = areactrl.text;
    homectrl.getUserData.value.getUserById!.address![0].district =
        districctrl.text;
    homectrl.getUserData.value.getUserById!.address![0].state = statectrl.text;
    homectrl.getUserData.value.getUserById!.address![0].pincode =
        pincodectrl.text;

    homectrl.refresh();
    homectrl.update();


    if (res.toString().contains("SUCCESS")) {

      var hh = res["SUCCESS"]["Update_User"];
      toast(error: "SUCCESS", msg: "${hh}");
    Get.close(1);


    }
    return res;
  }
}
