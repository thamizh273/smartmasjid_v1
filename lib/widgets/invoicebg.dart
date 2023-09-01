import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InvoiceBG extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const InvoiceBG({Key? key, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/memberreceipt.png'),
              // fit: BoxFit.fitHeight,
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