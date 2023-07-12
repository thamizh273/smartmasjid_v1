import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/qiblafinderpage_controller.dart';

class QiblafinderpageView extends GetView<QiblafinderpageController> {
  const QiblafinderpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QiblafinderpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QiblafinderpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
