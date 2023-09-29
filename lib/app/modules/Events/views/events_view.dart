import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../routes/export.dart';
import '../controllers/events_controller.dart';

class EventsView extends StatelessWidget {
   EventsView({Key? key}) : super(key: key);
  final homectrl=Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(tittle: "events".tr),
        body: Obx(() {
          return homectrl.isloadingEvent.value?loading(context): Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stxt(
                  text: 'upcoming_events'.tr,
                  size: f2,
                  weight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    scrollDirection: Axis.vertical,
                    itemCount: homectrl.eventsData.value.getMasjidEvents!.length,
                    itemBuilder: (context, index) {
                      var data=homectrl.eventsData.value.getMasjidEvents![index];
                      var image=base64Decode(data.image.toString());
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 5),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),

                                  child: Container(
                                    color: Colors.grey.shade300,
                                    child: data.image==null?Image.asset(
                                      'assets/images/event_img.png',
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: .35.sw,
                                    ):
                                    Image(image: MemoryImage(image,

                                    ), fit: BoxFit.cover,
                                      height: 100,
                                      width: .35.sw,),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: .5.sw,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: Text(
                                          '${data.description}',
                                          style: TextStyle(
                                              fontSize: f1,
                                              color: Get.theme.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                       Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_sharp,
                                              size: f2,
                                            ),
                                            Stxt(
                                              text: "${data.masjidId!.masjidName}",
                                              size: f0,
                                            )
                                          ],
                                        ),
                                      ),
                                       Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_sharp,
                                            size: f2,
                                          ),
                                          5.horizontalSpace,
                                          Stxt(
                                            text:  DateFormat('MMM d, y - h:mm a').format(DateTime.parse("${data.startTime!.toLocal()}")),
                                            size: f0,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: Get.theme.hoverColor),
                                              color: Colors.white
                                            ),
                                            child: Row(
                                              children: [
                                                2.horizontalSpace,
                                                Icon(Icons.notifications_active, size: 15,),
                                                3.horizontalSpace,
                                                Stxt(text: 'Notify me'.tr,
                                                        size: f1,
                                                        color: Get.theme.hoverColor, weight: FontWeight.bold,),
                                              ],
                                            ),

                                          ),
                                          // SButton(
                                          //     prefix: Icon(
                                          //       Icons.notifications_active,
                                          //       size: f2, color: clr_white,),
                                          //
                                          //     pad: 2.0,
                                          //     rad: 5.0,
                                          //     color: Theme
                                          //         .of(context)
                                          //         .primaryColor,
                                          //     child: Stxt(text: 'notify'.tr,
                                          //       size: f1,
                                          //       color: clr_white,),
                                          //     height: 30.h,
                                          //     width: 90.w,
                                          //     ontap: () {}),
                                          Space(16),
                                          SButton(
                                              pad: 2.0,
                                              rad: 5.0,
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor,
                                              child: Stxt(text: 'Book Now',
                                                size: f1,
                                                color: clr_white,),
                                              height: 30.h,
                                              width: 80.w,
                                              ontap: () {}),
                                        ],
                                      ),
                                      // Container(
                                      //
                                      //   width: 200,
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.end,
                                      //     children: [
                                      //       SButton(
                                      //
                                      //           pad: 0.0,
                                      //           rad: 5.0,
                                      //
                                      //           child:
                                      //           Stxt(text: 'Notify Me', size: f0),
                                      //           height: 20,
                                      //           width: 80),
                                      //     ],
                                      //   ),
                                      // ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        })
    );
  }
}
