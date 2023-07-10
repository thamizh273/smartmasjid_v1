import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../global.dart';

SizedBox SButton({ String? text,double? height,double? txtsize,double? width,Widget? child,double? pad,double? rad,Color? color,Color? txtClr,  required void Function() ontap}) {

  return SizedBox(
    width: width??140, height:height ??45,
    child: ElevatedButton(

      onPressed: ()=>ontap(),
      child: child??Stxt(text: text!, size:txtsize ??f3,color:txtClr),
      style: ElevatedButton.styleFrom(
              backgroundColor:color??Colors.white,
          padding: EdgeInsets.all(pad??5),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(rad??10))),
    ),
  );
}

