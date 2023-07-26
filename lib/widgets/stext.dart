import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Stxt extends StatelessWidget {
  const Stxt({
    Key? key,
    this.weight,
    this.color,
    this.textAlign,
    required this.text,
    required this.size,
    this.maxLines,
    this.pad, this.family,
  }) : super(key: key);
  final String text;

  final FontWeight? weight;
  final Color? color;
  final double size;
  final EdgeInsetsGeometry? pad;
  final int? maxLines;
  final String? family;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pad ?? EdgeInsets.zero,
      child: AutoSizeText(
        text,
        style: TextStyle(
          fontWeight: weight,
          color: color,
          fontSize: size,
          fontFamily: family??'Rubik',
        ),
        textAlign: textAlign,
        maxLines: maxLines ?? null,
      ),
    );
  }
}

class stxtN extends StatelessWidget {
  const stxtN({
    Key? key,
    this.weight,
    this.color,
    this.textAlign,
    required this.text,
    required this.size,
    this.maxLines,
  }) : super(key: key);
  final String text;

  final FontWeight? weight;
  final Color? color;
  final double size;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: weight,
        color: color,
        fontSize: size,
        fontFamily: 'Rubik',
      ),
      textAlign: textAlign,
      maxLines: maxLines ?? null,
    );
  }
}
