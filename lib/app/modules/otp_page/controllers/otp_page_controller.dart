import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/export.dart';

class OtpPageController extends GetxController {
  //TODO: Implement OtpPageController

  Rx<TextEditingController> phoneCtrl = TextEditingController().obs;
  List<String> otpDigits = List.filled(6, ''); // Change the number of digits as per your requirement
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  @override
  void onInit() {
    RawKeyboard.instance.addListener(_onKeyPressed);
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {
    RawKeyboard.instance.removeListener(_onKeyPressed);
    super.onClose();
  }

  void onDigitChanged(int index, String value) {

      otpDigits[index] = value;


    // Automatically move focus to the next digit
    if (value.isNotEmpty && index < otpDigits.length - 1) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
    }
  }

  void _onKeyPressed(RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
      // Handle backspace key press

        for (int i = otpDigits.length - 1; i >= 0; i--) {
          if (otpDigits[i].isNotEmpty) {
            otpDigits[i] = '';
            break;
          } else if (i > 0) {
            otpDigits[i] = '';
            FocusScope.of(Get.context!).requestFocus(focusNodes[i - 1]);
          }
        }

    }
  }
}
