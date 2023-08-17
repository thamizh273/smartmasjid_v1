import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../../masjidFinder/controllers/masjid_finder_controller.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  SplashScreenView({Key? key}) : super(key: key);
  static HomeController  homectrl = Get.find<HomeController>();


  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {

      // if( ctrl.getUserData.value.getUserById!.id==null){return Get.offAllNamed(Routes.LANGUAGE_PAGE);}
      if(SplashScreenView.homectrl.box1.read('fruits')!=null){

          Get.toNamed(Routes.HOME);

      }
      else {
        print("dddddd ${SplashScreenView.homectrl.box1.read('fruits')}");
        Get.offAllNamed(Routes.LANGUAGE_PAGE);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



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
