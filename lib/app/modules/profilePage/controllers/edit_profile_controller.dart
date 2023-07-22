import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';

import '../../../routes/export.dart';

class EditProfileController extends GetxController {
  static HomeController get homectrl => Get.find();

  //TODO: Implement EditProfileController
  var selectedDate = DateTime.now().obs;
  var dobController = TextEditingController();
  var firstnamectrl=TextEditingController(text: "${homectrl.getUserData.value.getUserById!.firstName}");
  var lastnamectrl=TextEditingController(text: "${homectrl.getUserData.value.getUserById!.lastName}");
  var mobilenumberctrl=TextEditingController(text: "${homectrl.getUserData.value.getUserById!.phoneNumber}");
  var emailctrl=TextEditingController(text: "${homectrl.getUserData.value.getUserById!.emailId}");
  @override
  void onInit() {

    super.onInit();
    dobController.text = "${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}";

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
  DateTime sixtyYearsAgo = DateTime.now().subtract(Duration(days: 60 * 365)); // Subtracting 60 years (approximation)

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
      dobController.text = "${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}";

    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(sixtyYearsAgo) &&
        day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }

}
