import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prayertimes_controller.dart';

class PrayertimesView extends GetView<PrayertimesController> {
  const PrayertimesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrayertimesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PrayertimesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
