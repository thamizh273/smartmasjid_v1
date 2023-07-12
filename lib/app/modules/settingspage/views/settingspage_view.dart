import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settingspage_controller.dart';

class SettingspageView extends GetView<SettingspageController> {
  const SettingspageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingspageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SettingspageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
