import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/addweather_controller.dart';

class AddweatherView extends GetView<AddweatherController> {
  const AddweatherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddweatherView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddweatherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
