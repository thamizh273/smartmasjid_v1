import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/zakathpage_controller.dart';

class ZakathpageView extends GetView<ZakathpageController> {
  const ZakathpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZakathpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ZakathpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
