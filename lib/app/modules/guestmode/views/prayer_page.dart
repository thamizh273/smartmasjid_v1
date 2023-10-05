

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:smartmasjid_v1/app/modules/guestmode/controllers/guestmode_controller.dart';
import '../../../routes/export.dart';


class PrayerPage extends StatelessWidget {
  PrayerPage({Key? key}) : super(key: key);
  final ctrl = Get.put(GuestmodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0.0),
            ),
          ),
          backgroundColor: Get.theme.primaryColor,
          leading: IconButton(
            icon: Image.asset(
              'assets/images/back_icon.png',
              scale: 2,
            ), onPressed: () {
            Navigator.pop(context);
          },
          ),
          title: Stxt(
              text: "prayer_time".tr,
              size: f4,
              weight: FontWeight.bold,
              color: Colors.white),


          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/mobile_vibration.svg',

                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {

                },
                icon: const Icon(
                  Icons.alarm,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stxt(
                text: 'farz_prayer_time'.tr,
                size: f4,
                weight: FontWeight.bold,
                color: Get.theme.hoverColor,
              ),
              Space(16),
              SizedBox(
                height: 280.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    String prayerName = '';
                    String prayerTime = '';
                    String prayerIcon = "";
                    switch (index) {
                      case 0:
                        prayerName = 'Fajr';
                        prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.fajr!;
                        prayerIcon = "assets/icons/fajr_icon.svg";
                        break;
                      case 1:
                        prayerName = 'Dhuhr';
                        prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.dhuhr!;
                        prayerIcon = "assets/icons/dhuhr_icon.svg";
                        break;
                      case 2:
                        prayerName = 'Asr';
                        prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.asr!;
                        prayerIcon = "assets/icons/asr.svg";
                        break;
                      case 3:
                        prayerName = 'Maghrib';
                        prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.maghrib!;
                        prayerIcon = "assets/icons/magrib.svg";
                        break;
                      case 4:
                        prayerName = 'Isha';
                        prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.isha!;
                        prayerIcon = "assets/icons/isha.svg";
                        break;
                      default:
                        break;
                    }
                    DateTime time = DateFormat("HH:mm").parse(prayerTime);
                    String prayerTime12 = DateFormat("h:mm a").format(time);
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 8,
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                borderRadius:
                                BorderRadius.horizontal(left: Radius.circular(10))),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: SvgPicture.asset(prayerIcon, height: 20, width: 20, color:Get.theme.primaryColor ,),),
                              Stxt(
                                text: prayerName,
                                size: f3,
                                weight: FontWeight.bold,
                                color: Get.theme.primaryColor,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stxt(
                                  text: prayerTime12,
                                  size: f3,
                                  weight: FontWeight.bold,
                                  color: Get.theme.primaryColor
                              ),

                            ],
                          ),
                          12.horizontalSpace,
                          Container(
                            width: 8,
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                borderRadius:
                                BorderRadius.horizontal(right: Radius.circular(10))),
                          )
                        ],
                      ),
                    );
                  }

                ),
              ),
              Stxt(
                text: 'prohibited_prayer_time'.tr,
                size: f4,
                weight: FontWeight.bold,
                color: Get.theme.hoverColor,
              ),
              Space(16),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index){
                      String prayerName = '';
                      String prayerTime = '';
                      String prayerIcon = "";
                      switch (index) {
                        case 0:
                          prayerName = 'Sunrise';
                          prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.sunrise!;
                          prayerIcon = "assets/icons/dhuhr_icon.svg";
                          break;
                        case 1:
                          prayerName = 'Sunset';
                          prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.sunset!;
                          prayerIcon = "assets/icons/fajr_icon.svg";
                          break;
                        case 2:
                          prayerName = 'Imsak';
                          prayerTime = ctrl.guestprayertime.value.getPrayerTimeGuest!.prayer!.imsak!;
                          prayerIcon = "assets/icons/asr.svg";
                          break;
                        default:
                          break;
                      }
                      DateTime time = DateFormat("HH:mm").parse(prayerTime);
                      String prayerTime12 = DateFormat("h:mm a").format(time);
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 8,
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.6),
                                  borderRadius:
                                  BorderRadius.horizontal(left: Radius.circular(10))),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SvgPicture.asset(prayerIcon, height: 20, width: 20, color:Colors.red ,),),
                                Stxt(
                                  text: prayerName,
                                  size: f3,
                                  weight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Stxt(
                                    text: prayerTime12,
                                    size: f3,
                                    weight: FontWeight.bold,
                                    color: Colors.red
                                ),

                              ],
                            ),
                            12.horizontalSpace,
                            Container(
                              width: 8,
                              decoration: BoxDecoration(
                                  color:  Colors.red.withOpacity(0.6),
                                  borderRadius:
                                  BorderRadius.horizontal(right: Radius.circular(10))),
                            )
                          ],
                        ),
                      );
                    }

                ),
              )
            ],
          ),
        )
    );
  }
}
