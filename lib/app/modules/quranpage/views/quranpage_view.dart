import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quranpage_controller.dart';

class QuranpageView extends GetView<QuranpageController> {
  const QuranpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuranpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuranpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
