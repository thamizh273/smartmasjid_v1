import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/weatherpage_controller.dart';

class WeatherpageView extends GetView<WeatherpageController> {
  const WeatherpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WeatherpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
