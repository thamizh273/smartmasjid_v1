import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if(hexColor.length == 6) {
    hexColor ="FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}


final clr_red= Colors.red.shade700;
final clr_gray= Colors.grey;
final clr_yellow= Colors.yellow.shade700;
final clr_black= Colors.black87;
final clr_green= Colors.green;
final clr_bg= Color(0xffD8E4E8);
final clr_white= Colors.white;