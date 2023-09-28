import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:marquee_text/vertical_marquee_text.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
 class HomePage extends StatelessWidget {
   const HomePage({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         width: double.infinity,
         color: Colors.green,
         child: Column(
       children: [
       /// horizontal marquee
       MarqueeText(
         alwaysScroll: true,
       text: TextSpan(
         text: 'This is long long long text...',
       ),
       style: TextStyle(
         fontSize: 24,
         color: Colors.white,
       ),
       speed: 30,
     ),

     /// vertical marquee
     // VerticalMarqueeText(
     // text: TextSpan(
     // children: <InlineSpan>[
     // TextSpan(
     // text: '''
     //          This is long long long text...
     //          This is long long long text...
     //          This is long long long text...
     //          ''',
     // ),
     // ],
     // ),
     // style: TextStyle(
     // fontSize: 24,
     // color: Colors.white,
     // ),
     // speed: 30,
     // ),
     ],
     ),
     ),
     );
   }
 }





