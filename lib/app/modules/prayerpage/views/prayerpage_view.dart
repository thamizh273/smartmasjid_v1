import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prayerpage_controller.dart';

class PrayerpageView extends GetView<PrayerpageController> {
  const PrayerpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrayerpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PrayerpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
