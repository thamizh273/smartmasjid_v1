import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/widgets/appBar.dart';
import '../../home/widgets/working.dart';
import '../controllers/familytree_controller.dart';

class FamilytreeView extends GetView<FamilytreeController> {
  const FamilytreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Family Tree",
      ),
      body: Working(),
    );
  }
}
