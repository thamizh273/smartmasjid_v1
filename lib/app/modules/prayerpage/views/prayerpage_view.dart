import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../routes/export.dart';
import '../controllers/prayerpage_controller.dart';

class PrayerpageView extends StatelessWidget {
  PrayerpageView({Key? key}) : super(key: key);
  final ctrl = Get.put(PrayerpageController());

  // List getdata = [
  //   'assets/icons/fajr_icon.svg',
  //   'assets/icons/fajr_icon.svg',
  //   'assets/icons/fajr_icon.svg',
  //   'assets/icons/fajr_icon.svg',
  //   'assets/icons/fajr_icon.svg',
  //   'assets/icons/fajr_icon.svg'
  // ];

  List<Map<String, dynamic>> getdata = [
    {
      "name": 'fajr',
      'icon': 'assets/icons/fajr_icon.svg',
      'start': '10:52',
      "end": "12:14"
    },
    {
      "name": 'Dhuhr',
      'icon': 'assets/icons/dhuhr_icon.svg',
      'start': '10:52',
      "end": "12:14"
    },
    {
      "name": 'Asr',
      'icon': 'assets/icons/asr.svg',
      'start': '10:52',
      "end": "12:14",
      "remaining": "12:14:50",
    },
    {
      "name": 'Magrib',
      'icon': 'assets/icons/magrib.svg',
      'start': '10:52',
      "end": "12:14"
    },
    {
      "name": 'Isha',
      'icon': 'assets/icons/isha.svg',
      'start': '10:52',
      "end": "12:14"
    },
    {
      "name": 'Isha',
      'icon': 'assets/icons/isha.svg',
      'start': '10:52',
      "end": "12:14"
    },
  ];
  List<Map<String, dynamic>> getdataProhibited = [
    {
      "name": 'Sunrise',
      'icon': 'assets/icons/fajr_icon.svg',
      'start': '10:52',
      "end": "12:14"
    },
    {
      "name": 'Noon',
      'icon': 'assets/icons/dhuhr_icon.svg',
      'start': '10:52',
      "end": "12:14"
    },
    {
      "name": 'Sunset',
      'icon': 'assets/icons/magrib.svg',
      'start': '10:52',
      "end": "12:14"
    },
  ];

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
              text: "Prayer Time",
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Stxt(
                text: 'Farz Prayer Time',
                size: f4,
                weight: FontWeight.bold,
                color: Get.theme.primaryColor,
              ),
              // for(var prayertime in ctrl.prayerpageData.value
              //     .getMasjidPrayerTimeFilter!)
              //   PrayerCard(
              //     prayerName: prayertime.prayerName.toString(),
              //     icon: getdata[prayertime.prayerName!.length + 1]["icon"],
              //     start_time: DateFormat('hh:mm a').format(
              //         DateTime.parse("${prayertime.startTime}")),
              //     endTime: DateFormat('hh:mm a').format(
              //         DateTime.parse("${prayertime.endTime}")),
              //     colors: Color(0xffA8A8A8),
              //     remainingTime: getdata[0]["remaining"],
              //     txtClr: Colors.black.withOpacity(.8),
              //   ),


              Obx(() {
                return ctrl.isLoading.value?loading(context): Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ctrl.prayerpageData.value
                        .getMasjidPrayerTimeFilter!
                        .length, itemBuilder: (context, index) {
                    var prayertime = ctrl.prayerpageData.value
                        .getMasjidPrayerTimeFilter![index];
              print(prayertime.startTime);
              print("llllllll");

                     ctrl.rrr.value=prayertime.startTime!;
                    return

                      PrayerCard(
                      prayerName: prayertime.prayerName.toString(),
                      icon: getdata[index]["icon"],
                      start_time: DateFormat('hh:mm a').format(DateTime.parse("${prayertime.startTime}").toLocal()),
                      endTime: DateFormat('hh:mm a').format(DateTime.parse("${prayertime.endTime}").toLocal()),
                      colors: Color(0xffA8A8A8),
                       remainingTime: prayertime.prayerStatus=="future"? ctrl.remainTime():"null",
                      txtClr: Colors.black.withOpacity(.8),
                    );
                  },),
                );
              }),

              // PrayerCard(
              //   prayerName: k['name'],
              //   icon: k['icon'],
              //   start_time: k['start'],
              //   endTime: k['end'],
              //   colors: Color(0xffA8A8A8),
              //   remainingTime: k['remaining'],
              //   txtClr: Colors.black.withOpacity(.8),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Stxt(
                  text: 'Prohibited Prayer Time',
                  size: f4,
                  weight: FontWeight.bold,
                  color: Get.theme.primaryColor,
                ),
              ),
              for (var i in getdataProhibited)
                PrayerCard(
                  prayerName: i['name'],
                  icon: i['icon'],
                  start_time: i['start'],
                  endTime: i['end'],
                  colors: Color(0xffC91717),
                ),
            ],
          ),
        ));
  }
}

class PrayerCard extends StatelessWidget {
   PrayerCard({
    super.key,
    required this.prayerName,
    required this.icon,
    required this.start_time,
    required this.endTime,
    this.remainingTime,
    required this.colors,
    this.txtClr,
  });

  final String prayerName;
  final String icon;
  final String start_time;
  final String endTime;
  final String? remainingTime;
  final Color colors;
  final Color? txtClr;
  final ctrl = Get.put(PrayerpageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 45,
      decoration: BoxDecoration(
          color: colors.withOpacity(.25),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 8,
            decoration: BoxDecoration(
                color: colors,
                borderRadius:
                BorderRadius.horizontal(left: Radius.circular(10))),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(
                  icon,
                  color: txtClr ?? colors,
                  height: 20,
                  width: 20,
                ),
              ),
              Stxt(
                text: prayerName,
                size: f3,
                weight: FontWeight.bold,
                color: txtClr ?? colors,
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stxt(
                text: "${start_time} - ${endTime}",
                size: f3,
                weight: FontWeight.bold,
                color: txtClr ?? colors,
              ),
            remainingTime =="null"?Container()  :Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green.shade50),
                child:  Stxt(
                  text: 'Remaining time : ${remainingTime}',
                  size: f0,
                  color: Colors.green,
                ),
              )

            ],
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 8,
            decoration: BoxDecoration(
                color: colors,
                borderRadius:
                BorderRadius.horizontal(right: Radius.circular(10))),
          )
        ],
      ),
    );
  }
}
