import 'package:flutter/material.dart';

class SliderdotView extends StatelessWidget {
  SliderdotView(bool);

  @override
  Widget build(BuildContext context) {
    var isActive;
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 5,
      height: 5,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white70,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
