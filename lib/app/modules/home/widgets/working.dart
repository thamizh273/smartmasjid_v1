import 'package:flutter/material.dart';

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
            Image.asset("assets/images/sorry.png", width: 200,),
            Space(16),
            Image.asset("assets/images/We are working on it.png", width: 300,),
          ],
        ),
      ),
    );
  }
}
