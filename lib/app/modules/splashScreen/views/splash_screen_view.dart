import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({Key? key}) : super(key: key);
  static HomeController  homectrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 4), () {
      homectrl.update();
      // if( ctrl.getUserData.value.getUserById!.id==null){return Get.offAllNamed(Routes.LANGUAGE_PAGE);}
      if(homectrl.getUserData.value.getUserById != null){
        if ( (homectrl.getUserData.value.getUserById != null)&& homectrl.getUserData.value.getUserById!.liveStatus==true ) {
          Get.toNamed(Routes.HOME);
        }
      }
      else {
        Get.offAllNamed(Routes.LANGUAGE_PAGE);
      }
    });
    return Scaffold(
        body: SizedBox(
      height: context.height,
      child: Lottie.asset(
        "assets/lottie/splash.json",
        repeat: false,
        height: context.height,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ));

    //   Scaffold(
    //
    //   body: Container(
    //     color: Get.theme.colorScheme.primary,
    //     child: Center(
    //       child:
    //         AnimatedBuilder(animation: controller.animationController, builder: (context, child) {
    //           return Transform.scale(
    //             scale: controller.scaleAnimation.value,
    //             child: child,
    //           );
    //         },child: SvgPicture.asset('assets/svg/slogo.svg'),)
    //
    //
    //
    //     ),
    //   ),
    // );
  }
}
