import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../global.dart';

SizedBox SButton({ String? text,double? height,double? txtsize,double? width,Widget? child,Widget? suffix,Widget? prefix,double? pad,double? rad,Color? color,Color? txtClr,  required Function() ontap}) {

  return SizedBox(
    width: width??140, height:height ??45,
    child: ElevatedButton(

      onPressed: ()=>ontap(),
      style: ElevatedButton.styleFrom(
              backgroundColor:color??Colors.white,
              foregroundColor:color??Colors.black87,
          padding: EdgeInsets.all(pad??5),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(rad??10))),
      child: Row(
        mainAxisAlignment: prefix==null?MainAxisAlignment.center:MainAxisAlignment.start,
        children: [
          (prefix==null?0:5).horizontalSpace,
          prefix??Container(),
          (prefix==null?0:8).horizontalSpace,
          child??Stxt(text: text!, size:txtsize ??f3,color:txtClr??Colors.black87,weight: FontWeight.w500,textAlign: TextAlign.center,),
          (prefix==null?0:5).horizontalSpace,
          suffix??Container(),
        ],
      ),
    ),
  );
}

