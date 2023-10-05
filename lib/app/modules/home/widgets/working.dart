import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../widgets/space.dart';


class Working extends StatelessWidget {
  const Working({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Space(16),
            Image.asset("assets/images/Code typing-bro 1.png"),
            Space(16),
            Image.asset("assets/images/sorry.png", width: 200, color: Get.theme.hoverColor,),
            Space(16),
            Image.asset("assets/images/We are working on it.png", width: 300, color: Get.theme.hoverColor,),
          ],
        ),
      ),
    );
  }
}
