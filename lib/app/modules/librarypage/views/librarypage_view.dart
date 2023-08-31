import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/librarypage_controller.dart';

class LibrarypageView extends GetView<LibrarypageController> {
  const LibrarypageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "library".tr,
      ),
      body: Working(),
    );
  }
}
