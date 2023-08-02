import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../../global.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../home/controllers/home_controller.dart';

class ProfilePageController extends GetxController {
  //TODO: Implement ProfilePageController
  static HomeController get homectrl => Get.find();
  final _restcallController = Get.put(restCallController());
 RxBool isLoading =false.obs;
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

}
