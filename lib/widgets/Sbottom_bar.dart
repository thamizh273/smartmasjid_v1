import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartmasjid_v1/widgets/space.dart';

import '../app/routes/app_pages.dart';


class SbottomBar extends StatelessWidget {
  const SbottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FrostedBottomBar(
        width: 330.w,
        opacity: .8,
        sigmaX: 10,
        sigmaY: 10,
        bottomBarColor: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(500),
    duration: const Duration(milliseconds: 800),
    hideOnScroll: true,
        body: (BuildContext context, ScrollController controller) {
          return Container();
    }, child:  Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/svg/masjidbot.svg"),
          Space(8),
          GestureDetector(
              onTap: (){
                Get.toNamed(Routes.QURANPAGE);
              },
              child: SvgPicture.asset("assets/svg/quranbot.svg")),
          Space(8),
          SvgPicture.asset("assets/svg/homebot.svg"),
          Space(8),
          SvgPicture.asset("assets/svg/mediabot.svg"),
          Space(8),
          SvgPicture.asset("assets/svg/donatebot.svg"),
        ],
      ),
    ),

    ),
    );
  }
}
