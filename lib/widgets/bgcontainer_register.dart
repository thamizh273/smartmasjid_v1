import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BGContainerRegister extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Widget? image;
   BGContainerRegister({Key? key, required this.child, this.padding, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: Get.theme.colorScheme.primary,
      height:MediaQuery.sizeOf(context).height,
      width:MediaQuery.sizeOf(context).width,
      padding: padding,
      child: Column(
        children: [
          image??Image.asset('assets/images/login_img.png',height: .23.sh,width: 1.sw,fit: BoxFit.fill,),
          child,
        ],
      ),
    );
  }
}