import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FamilyBG extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const FamilyBG({Key? key, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.7,
              image: AssetImage('assets/images/familytree.png'),
              fit: BoxFit.fitHeight,
            ),
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