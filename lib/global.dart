import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

const f1 = 12.0;
const f0 = 10.0;
const f2 = 14.0;
const f3 = 16.0;
const f4 = 18.0;
const f5 = 20.0;

toast({required String error, required String msg}) {
  Get.snackbar("", "",
      backgroundColor: Get.theme.primaryColor.withOpacity(.8),
      titleText:  Stxt(
        text: "${error}".toUpperCase(),
        size: f2,
        weight: FontWeight.bold,
        color: Get.theme.colorScheme.primary,
      ),
      messageText: Stxt(
        text: "${msg}",
        size: f2,
        weight: FontWeight.w500,
        color: Colors.white,
      ));
}
