import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/messagepage_controller.dart';

class MessagepageView extends GetView<MessagepageController> {
  const MessagepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MessagepageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MessagepageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
