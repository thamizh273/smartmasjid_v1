import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

class BGContainerAuth extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  BGContainerAuth({Key? key, required this.child, this.padding, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height:MediaQuery.sizeOf(context).height,
      width:MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: color??Get.theme.colorScheme.primary,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Get.theme.colorScheme.primary.withOpacity(0.8), BlendMode.srcATop),
          image: AssetImage("assets/images/bg_img.png",),
          fit: BoxFit.fill,
        //  image: AssetImage(isDarkMode ? 'assets/images/masnew_dark.png' : 'assets/images/bgauth.png'),
        //  image: AssetImage( 'assets/images/masnew_dark.png'),
         // fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: padding,
        child: child,
      ),
    );
  }
}