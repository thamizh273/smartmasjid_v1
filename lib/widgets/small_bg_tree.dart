import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BGtree extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final String? text;
  const BGtree({Key? key, required this.child, this.padding, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          width: 115,
          height: 115,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/familytxt.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Align(
            child: Text("hi"),
          ),
        ),
        Container(
          padding: padding,
          child: child,
        ),
      ],
    );
  }
}