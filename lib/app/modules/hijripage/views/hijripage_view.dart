import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hijripage_controller.dart';

class HijripageView extends GetView<HijripageController> {
  const HijripageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HijripageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HijripageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
