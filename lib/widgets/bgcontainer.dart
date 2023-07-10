import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BGContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const BGContainer({Key? key, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(isDarkMode ? 'assets/images/masnew_dark.png' : 'assets/images/bgnew.png'),
              fit: BoxFit.cover,
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