import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notificationpage_controller.dart';

class NotificationpageView extends GetView<NotificationpageController> {
  const NotificationpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationpageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotificationpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
