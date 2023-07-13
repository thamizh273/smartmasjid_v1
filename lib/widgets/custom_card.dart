import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry?  margin;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final bool shadow, topCurve, border, bottomCurve, animated;
  final double radius;
  final double? width, height;
  final onTap;
  final BoxConstraints? constraints;
  const CustomCard({Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.width,
    this.onTap,
    this.constraints,
    this.height,
    this.shadow = true,
    this.border = true,
    this.topCurve = false,
    this.animated = true,
    this.bottomCurve = false,
    this.color,
    this.radius = 10.0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //duration: const Duration(milliseconds: 100),
      constraints: constraints,
      // width: width,
      // height: height,
      margin: margin,
      decoration: BoxDecoration(
          // color: color ?? Theme.of(context).backgroundColor,
          // border: border ? Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.7)) : null,
          boxShadow: shadow ? [
            // BoxShadow(
            //     color: Theme.of(context).shadowColor, spreadRadius: 2.5, blurRadius: 2.5, offset: Offset(0, 3))
          ] : null,
          borderRadius: topCurve ? BorderRadius.only(
            topRight: Radius.circular(radius),
            topLeft: Radius.circular(radius),
          ):bottomCurve ? BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ): BorderRadius.circular(radius)),
      child: ClipRRect(
          borderRadius: topCurve ? BorderRadius.only(
            topRight: Radius.circular(radius),
            topLeft: Radius.circular(radius),
          ): BorderRadius.circular(radius),
          child: Material(color: Colors.transparent ,child: InkWell(
              hoverColor: Colors.transparent,

              onTap: onTap,
              child: Padding(
                padding: padding,
                child: child,
              )))),
    );
  }
}
