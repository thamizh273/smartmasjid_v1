import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/activitiespage_controller.dart';

class ActivitiespageView extends GetView<ActivitiespageController> {
  const ActivitiespageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "activities".tr,
      ),
      body: Working(),
    );
  }
}
