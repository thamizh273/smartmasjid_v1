import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed( Duration(seconds: 4), ()   {

      Get.offAllNamed(Routes.LANGUAGE_PAGE);
    });
    return

      Scaffold(
      body:
        SizedBox(
          height: context.height,
          child: Lottie.asset(
            "assets/lottie/splash.json",
            repeat: false,
            height: context.height,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        )

    );


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
