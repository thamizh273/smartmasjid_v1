import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';

class MembershipController extends GetxController {
  //TODO: Implement MembershipController

  final count = 0.obs;

  RxBool switchValue = false.obs;
  String? value;
  final isChecked = false.obs;
  final isCheckeddue = false.obs;
  final isCheckedother = false.obs;
  var fontFamily = "upi".obs;


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

  void increment() => count.value++;




}
