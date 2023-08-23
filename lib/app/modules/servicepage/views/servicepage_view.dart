import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';

import '../controllers/servicepage_controller.dart';

class ServicepageView extends GetView<ServicepageController> {
  const ServicepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Services",
      ),
      body: Working(),
    );
  }
}
