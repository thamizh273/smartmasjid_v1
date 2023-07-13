import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/messagepage_controller.dart';

class MessagepageView extends GetView<MessagepageController> {
  const MessagepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: 'Messages',
        action: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh, color: Colors.white,))
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/messages.svg"),
            Space(16),
            Text("No Messages Yet,"),
            Text("Start your Conversation")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        backgroundColor:Theme.of(context).primaryColor,
        onPressed: (){},
      ),
    );
  }
}
