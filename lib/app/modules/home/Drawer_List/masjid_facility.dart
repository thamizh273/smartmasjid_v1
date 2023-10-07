import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../controllers/home_controller.dart';
import 'dart:math' as math;

class MasjidFacility extends StatelessWidget {
  MasjidFacility({super.key});

  final HomeController faccntrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "facilities".tr,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Stxt(text: "Masjid-e-Nooraniyah",
                      size: f3,
                      weight: FontWeight.w600,
                      color: Get.theme.hoverColor,),
                    Space(4),
                    Stxt(text: "facilities_are_shown_here".tr,
                      size: f3,
                      weight: FontWeight.w600,
                      color: Get.theme.hoverColor,),
                  ],
                ),
                20.verticalSpace,
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(animated: true),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/svg/prayerfac.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "prayer_facilities".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl.isExpanded.value ? 1 : 0;
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        })
                                        // faccntrl.isExpanded.value? Icon(Icons.arrow_drop_down, size: 40): Icon(Icons.arrow_right, size: 40),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/svg/refreshfac.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "refresh_facilities".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Space(8),
                                        Image.asset(
                                            "assets/images/appearancefac.png"),
                                        Space(16),
                                        Stxt(
                                          text: "appearance".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Space(8),
                                        SvgPicture.asset(
                                            "assets/svg/jamath.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "jamath_facilities".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Space(8),
                                        SvgPicture.asset(
                                            "assets/svg/bookfac.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "education".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Space(8),
                                        SvgPicture.asset(
                                            "assets/svg/womenfac.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "womens_facilities".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Space(8),
                                        SvgPicture.asset("assets/svg/cctv.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "technical_facilities".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ExpansionWidget(
                  titleBuilder: (double animationValue, double easeInValue,
                      bool isExpanded,
                      dynamic Function({bool animated}) toggleFunction) {
                    return InkWell(
                      onTap: () => toggleFunction(),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(() {
                                final animationValue = faccntrl.isExpanded.value
                                    ? 1
                                    : 0;
                                return Container(
                                  height: faccntrl.isExpanded.value ? 100 : 50,
                                  // Adjust the height based on the state
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(0, 2),
                                        color: Get.theme.shadowColor,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Space(8),
                                        SvgPicture.asset(
                                            "assets/svg/handshake.svg"),
                                        Space(16),
                                        Stxt(
                                          text: "providing_facilities".tr,
                                          size: f4,
                                          weight: FontWeight.w600,
                                          color: Get.theme.primaryColor,
                                        ),
                                        Spacer(),
                                        Obx(() {
                                          final animationValue = faccntrl
                                              .isExpanded.value
                                              ? 1
                                              : 0; // Adjust the animation value based on state
                                          return Transform.rotate(
                                            angle: math.pi * animationValue / 2,
                                            child: Icon(
                                                Icons.arrow_right, size: 40, color: Get.theme.primaryColor,),
                                            alignment: Alignment.center,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  content: Container(decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/prayer halls.svg"),
                                      Space(4),
                                      Stxt(text: "Prayer Halls",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/jummahfac.svg"),
                                      Space(4),
                                      Stxt(text: "Jummah Khutbah",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fully carpeted.svg"),
                                      Space(4),
                                      Stxt(text: "Fully Carpeted",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                              Space(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/audio system for salah.svg"),
                                      Space(4),
                                      Stxt(text: "Audio System",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/eidfac.svg"),
                                      Space(6),
                                      Stxt(text: "Arrangement for Eid Prayers",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/air conditioned (ac).svg"),
                                      Space(6),
                                      Stxt(text: "Air Conditioned (AC)",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, left: 8, top: 4, bottom: 4),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/svg/fans.svg"),
                                      Space(6),
                                      Stxt(text: "Fan & Light",
                                        size: f3,
                                        weight: FontWeight.w500,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}