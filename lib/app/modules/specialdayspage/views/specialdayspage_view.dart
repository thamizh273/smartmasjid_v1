import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/specialdayspage_controller.dart';

class SpecialdayspageView extends GetView<SpecialdayspageController> {
  const SpecialdayspageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpecialdayspageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpecialdayspageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
