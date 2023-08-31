import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/mediapage_controller.dart';

class MediapageView extends GetView<MediapageController> {
  const MediapageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "media".tr,
      ),
      body: Working(),
    );
  }
}
