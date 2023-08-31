import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../controllers/archivepage_controller.dart';

class ArchivepageView extends GetView<ArchivepageController> {
  const ArchivepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: "archived_notifications".tr,),
    );
  }
}
