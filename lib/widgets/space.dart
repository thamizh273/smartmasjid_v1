import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double px;

  const Space(this.px, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: px,
      height: px,
    );
  }
}