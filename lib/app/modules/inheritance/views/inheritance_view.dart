import 'dart:ffi';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

import '../../../routes/app_pages.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/inheritance_controller.dart';

class InheritanceView extends GetView<InheritanceController> {
  InheritanceView({Key? key}) : super(key: key);

  final List<GlobalKey<ExpansionTileCardState>> cardKeys =
      List.generate(29, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "Inheritance".tr,
          action: [
            IconButton(onPressed: () {}, icon: Icon(Icons.info_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.save_outlined))
          ],
        ),
        body: ListView(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            children: [
              const Stxt(
                text:
                    "Please ensure that you enter all the required details truthfully, before clicking on the 'calculate' button at the bottom to obtain your result",
                size: f2,
                textAlign: TextAlign.center,
              ),
              15.verticalSpace,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 29,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.primaryColor),
                      ),
                      child: Obx(() {
                        return ExpansionTileCard(
                          expandedTextColor: Colors.black,
                          onExpansionChanged: (value) {
                            if (value) {
                              // Close any previously opened card
                              if (controller.openExpansionIndex!.value != -1) {
                                controller.expand[controller
                                    .openExpansionIndex!.value] = false;
                              }
                              controller.openExpansionIndex!.value =
                                  index; // Set the currently open card
                            } else {
                              controller.openExpansionIndex!.value =
                                  -1; // Reset open card when collapsed
                            }
                            controller.expand[index] = value;

                            print(value);
                          },
                          initialPadding: EdgeInsets.all(0),
                          contentPadding: EdgeInsets.only(
                              left: 10,
                              right: controller.expand[index] ? 0 : 10),
                          finalPadding: const EdgeInsets.only(bottom: 0),
                          key: cardKeys[index],
                          title: Row(
                            children: [
                              SizedBox(
                                width: controller.expand[index] ? 135 : null,
                                child: Stxt(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text:
                                      "${controller.relativeNameList[index]["name"]}",
                                  size: f3,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              5.horizontalSpace,
                              Icon(
                                controller.expand[index]
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down_circle,
                                color: theme.hoverColor,
                                size: 18,
                              )
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              controller.expand[index]
                                  ? IconButton(
                                      onPressed: () {
                                        controller.decrement(index);
                                      },
                                      icon: const Icon(Icons.remove_circle),
                                      color: theme.hoverColor,
                                    )
                                  : SizedBox(),
                              Container(
                                  height: 35.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: theme.primaryColor),
                                  ),
                                  child: Center(
                                    child: Stxt(
                                      text: '${controller.count[index]}',
                                      size: f3,
                                      weight: FontWeight.bold,
                                    ),
                                  )),
                              //  Safa_textfield(fillColor: theme.scaffoldBackgroundColor,hint: "",width: .15,contentHPad: 10,length:2,height: 38,readOnly: true,),
                              controller.expand[index]
                                  ? IconButton(
                                      onPressed: () {
                                        controller.increment(index);
                                      },
                                      icon: const Icon(Icons.add_circle),
                                      color: theme.primaryColor,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          children: controller.expand[index]
                              ? <Widget>[
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 10.0,
                                      ),
                                      child: Stxt(
                                          text:
                                              "${controller.relativeNameList[index]["descrp"]}",
                                          size: f2),
                                    ),
                                  )
                                ]
                              : [],
                        );
                      }));
                },
              ),
              10.verticalSpace,
              SButton(
                  ontap: () {
                    controller.calculate();
                    Get.toNamed(
                      Routes.INHERITANCE_RESULT,
                      arguments: [
                        controller.count[1],
                        controller.wifeShareFraction.value,
                        controller.husband.value.toStringAsFixed(2),
                        controller.husbandShareFraction.value,
                        controller.wife.value,
                        controller.count[2],
                        controller.sonShareFraction.value,
                        controller.son.value.toStringAsFixed(2),
                        controller.count[3],
                        controller.daughterShareFraction.value,
                        controller.daughter.value.toStringAsFixed(2),
                      ],
                    );
                  },
                  text: "Calculate",
                  color: theme.primaryColor,
                  txtClr: theme.focusColor),
              20.verticalSpace,
            ]));
  }
}
