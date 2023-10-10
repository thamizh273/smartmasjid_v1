import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/working.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../../masjidhistory/controllers/masjidhistory_controller.dart';
import '../controllers/home_controller.dart';
import 'dart:math' as math;

class MasjidFacility extends StatelessWidget {
  MasjidFacility({super.key});

  final HomeController faccntrl = Get.put(HomeController());
  final facicntrl = Get.put(MasjidhistoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return facicntrl.isLoadings0.value?  DialogHelper.showLoading(): Scaffold(
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: facicntrl.getmasjidfacility.value
                          .getMasjidFacilitiesList!.length,
                      itemBuilder: (context, index) {
                        var facility = facicntrl.getmasjidfacility.value
                            .getMasjidFacilitiesList![index];
                        return ExpansionWidget(
                          titleBuilder: (double animationValue,
                              double easeInValue,
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
                                        final animationValue = faccntrl
                                            .isExpanded.value
                                            ? 1
                                            : 0;
                                        return Container(
                                          height: faccntrl.isExpanded.value
                                              ? 100
                                              : 50,
                                          // Adjust the height based on the state
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                8),
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
                                                    "assets/svg/${facility.facilityTitle!.toLowerCase()}.svg"),
                                                Space(16),
                                                Stxt(
                                                  text: "${facility
                                                      .facilityTitle}".tr,
                                                  size: f4,
                                                  weight: FontWeight.w600,
                                                  color: Get.theme.primaryColor,
                                                ),
                                                Spacer(),
                                                Obx(() {
                                                  final animationValue = faccntrl
                                                      .isExpanded.value ? 1 : 0;
                                                  return Transform.rotate(
                                                    angle: math.pi *
                                                        animationValue / 2,
                                                    child: Icon(
                                                      Icons.arrow_right,
                                                      size: 40,
                                                      color: Get.theme
                                                          .primaryColor,),
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
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: facility.nameList!.length,
                                      itemBuilder: (context, index) {
                                        var features = facility
                                            .nameList![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(4),
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor
                                                  .withOpacity(0.4),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8,
                                                  left: 8,
                                                  top: 4,
                                                  bottom: 4),
                                              child: Row(
                                                children: [
                                                  features.facilityName ==
                                                      "24/7 Surveillance camera (CCTV)"
                                                      ? SvgPicture.asset(
                                                      "assets/svg/surveillance camera (cctv).svg")
                                                      : SvgPicture
                                                      .asset(
                                                    "assets/svg/${features
                                                        .facilityName!
                                                        .toLowerCase()}.svg",),
                                                  Space(4),
                                                  Stxt(text: "${features
                                                      .facilityName}",
                                                    size: f3,
                                                    weight: FontWeight.w500,
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}