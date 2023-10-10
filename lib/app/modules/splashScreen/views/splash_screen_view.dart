
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smartmasjid_v1/app/modules/guestmode/controllers/guestmode_controller.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';


class SplashScreenView extends StatefulWidget {
  SplashScreenView({Key? key}) : super(key: key);
  static HomeController  homectrl = Get.find<HomeController>();
  final   guestctrl = Get.put(GuestmodeController());


  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      // if( ctrl.getUserData.value.getUserById!.id==null){return Get.offAllNamed(Routes.LANGUAGE_PAGE);}
      if(SplashScreenView.homectrl.box1.read('fruits')!=null){
          Get.offAllNamed(Routes.HOME);
      } else if(widget.guestctrl.guesttoken.read('guest')!=null){
        Get.offAllNamed(Routes.GUESTMODE);
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
        "assets/lottie/finalsplash.json",
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
