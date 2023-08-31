import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/masjidnearme_controller.dart';

class MasjidnearmeView extends GetView<MasjidnearmeController> {
  const MasjidnearmeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "masjid_near_me".tr,
      ),
      body: Working(),
    );
  }
}
