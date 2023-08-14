import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../controllers/prayerdetailspage_controller.dart';

class PrayerdetailspageView extends StatelessWidget {
  PrayerdetailspageView({Key? key}) : super(key: key);
  final PrayerdetailspageController c = Get.put(PrayerdetailspageController());
  final HomeController homectrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery
              .of(context)
              .size
              .height,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          scrollPhysics: BouncingScrollPhysics(),
          onPageChanged: (index, reason) {
            c.currentPage.value = index;
            // Do something on page change
            print('Page changed to index $index');
          },
        ),
        items: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 230.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/fajrdet.png"
                      ),
                      fit: BoxFit.cover,
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space(50),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                    "assets/svg/backnew.svg"),
                                onTap: () {
                                  Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (_) => HomeView()));
                                },
                              ),
                            ],
                          ),
                          Space(32),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Stxt(
                                  weight: FontWeight.w500,
                                  text: "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayHijriDate}",
                                  size: f3,
                                  color: Colors.white,
                                );
                              }),
                            ],
                          ),
                          Space(16),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2),
                            child: Obx(() {
                              return Stxt(
                                text:
                                '${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!
                                    .todayPrayerList![c
                                    .currentPage.value].prayerName}',
                                size: f5,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              );
                            }),
                          ),
                          Space(8),
                          Obx(() {
                            return Stxt(
                              text:
                              "${DateFormat('hh:mm a').format(DateTime.parse(
                                  "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayPrayerList![c.currentPage.value]
                                      .startTime}").toLocal())}",

                              // "${DateFormat.jm().format(DateTime.now())}",
                              size: 20,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            );
                          }),
                          Obx(() {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Stxt(
                                text:
                                "${homectrl.prayerDetailRT(0)}",
                                size: f2,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                textAlign: TextAlign.end,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Raqat",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/svg/fajrsunnathnw.svg"),
              ),
              SizedBox(height: 8),
              Text(
                "Benefits of Fajr",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Space(8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "* If you start your day with prayers, then Allah Almighty protects you all day. "
                      "In the hadith, Prophet Muhammad (SAW) said: “Whoever offers the Morning Prayer, "
                      "he is under the protection of Allah, the Mighty and Sublime” (Ibn Majah).",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* Fajr prayer ensures that we begin the day with light and with life. "
                      "Early morning sets the tone and energy for the whole day, "
                      "and by beginning the day in the best possible way.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
          Obx(() {
            return homectrl.prayerTimeData.value.getTodayMasjidPrayerTime!
                .todayPrayerList![c.currentPage.value].prayerName == "Dhuhr"
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 230.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/duhrdet.png"
                        ),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Space(50),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(10.0),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: SvgPicture.asset(
                                      "assets/svg/backnew.svg"),
                                  onTap: () {
                                    Navigator.of(context).pop(MaterialPageRoute(
                                        builder: (_) => HomeView()));
                                  },
                                ),
                              ],
                            ),
                            Space(32),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  return Stxt(
                                    weight: FontWeight.w500,
                                    text: "${homectrl.prayerTimeData.value
                                        .getTodayMasjidPrayerTime!
                                        .todayHijriDate}",
                                    size: f3,
                                    color: Colors.white,
                                  );
                                }),
                              ],
                            ),
                            Space(16),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 2),
                              child: Obx(() {
                                return Stxt(
                                  text:
                                  '${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayPrayerList![c.currentPage.value]
                                      .prayerName}',
                                  size: f5,
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                );
                              }),
                            ),
                            Space(8),
                            Obx(() {
                              return Stxt(
                                text:
                                "${DateFormat('hh:mm a').format(DateTime.parse(
                                    "${homectrl.prayerTimeData.value
                                        .getTodayMasjidPrayerTime!
                                        .todayPrayerList![c.currentPage.value]
                                        .startTime}").toLocal())}",
                                // "${DateFormat.jm().format(DateTime.now())}",
                                size: 20,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              );
                            }),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Stxt(
                                  text:
                                  "${homectrl.prayerDetailRT(1)}",
                                  size: f2,
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.end,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Raqat",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/duhrsunnath.svg"),
                ),
                SizedBox(height: 8),
                Text(
                  "Benefits of Dhuhr",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Space(8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "* Zuhr prayer is the time when the gates of Heaven are opened for the Muslims. During the Zuhr hour, the gates of heaven are opened. So, "
                        "it is important to do good deeds at this time and offering Salah is the most important at that time.",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, bottom: 16),
                  child: Text(
                    "*Allah Almighty showers His blessings on those who offer Zuhr prayers at the time.",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 230.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/jummahdet.png"
                        ),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Space(50),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(10.0),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: SvgPicture.asset(
                                      "assets/svg/backnew.svg"),
                                  onTap: () {
                                    Navigator.of(context).pop(MaterialPageRoute(
                                        builder: (_) => HomeView()));
                                  },
                                ),
                              ],
                            ),
                            Space(32),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Stxt(
                                  weight: FontWeight.w500,
                                  text: "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayHijriDate}",
                                  size: f3,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Space(16),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 2),
                              child: Stxt(
                                text:
                                '${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!
                                    .todayPrayerList![c.currentPage.value]
                                    .prayerName}',
                                size: f5,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Space(8),
                            Stxt(
                              text:
                              "${DateFormat('hh:mm a').format(DateTime.parse(
                                  "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayPrayerList![c.currentPage.value]
                                      .startTime}").toLocal())}",
                              // "${DateFormat.jm().format(DateTime.now())}",
                              size: 20,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Stxt(
                                text:
                                "${homectrl.prayerDetailRT(1)}",
                                size: f2,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Raqat",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/jummahsunnath.svg"),
                ),
                SizedBox(height: 8),
                Text(
                  "Benefits of Jummah",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Space(8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "* Jummah (Friday) is the most important day of the week because Muslims assemble for congregational Prayer on Friday.",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* Before the Friday prayer, Muslims listen to a lecture meant to provide them with essential information about Islam, Prophets, and Allah Almighty.",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* There is one day among the seven days in Islam that Allah has declared to be very important.",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            );
          }),


          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 230.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/asrdet.png"
                      ),
                      fit: BoxFit.cover,
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space(50),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                    "assets/svg/backnew.svg"),
                                onTap: () {
                                  Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (_) => HomeView()));
                                },
                              ),
                            ],
                          ),
                          Space(32),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Stxt(
                                weight: FontWeight.w500,
                                text: "${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!.todayHijriDate}",
                                size: f3,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Space(16),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2),
                            child: Obx(() {
                              return Stxt(
                                text:
                                '${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!
                                    .todayPrayerList![c.currentPage.value]
                                    .prayerName}',
                                size: f5,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              );
                            }),
                          ),
                          Space(8),
                          Obx(() {
                            return Stxt(
                              text:
                              "${DateFormat('hh:mm a').format(DateTime.parse(
                                  "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayPrayerList![c.currentPage.value]
                                      .startTime}").toLocal())}",
                              // "${DateFormat.jm().format(DateTime.now())}",
                              size: 20,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Stxt(
                              text:
                              "${homectrl.prayerDetailRT(2)}",
                              size: f2,
                              color: Colors.white,
                              weight: FontWeight.bold,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Raqat",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/svg/asrsunnath.svg"),
              ),
              SizedBox(height: 8),
              Text(
                "Benefits of Asr",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Space(8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "* One of the greatest blessings for every Muslim is to enter into Paradise. Whoever offers the Fajr and Asr prayers enters the Jannah.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* Asr prayer saves from the Hell and opens the door of Jannah.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* Those who offer Asr prayer will give you success in life as well as in the Hereafter.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 230.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/magribdet.png"
                      ),
                      fit: BoxFit.cover,
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space(50),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                    "assets/svg/backnew.svg"),
                                onTap: () {
                                  Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (_) => HomeView()));
                                },
                              ),
                            ],
                          ),
                          Space(32),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Stxt(
                                weight: FontWeight.w500,
                                text: "${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!.todayHijriDate}",
                                size: f3,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Space(16),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2),
                            child: Obx(() {
                              return Stxt(
                                text:
                                '${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!
                                    .todayPrayerList![c.currentPage.value]
                                    .prayerName}',
                                size: f5,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              );
                            }),
                          ),
                          Space(8),
                          Obx(() {
                            return Stxt(
                              text:
                              "${DateFormat('hh:mm a').format(DateTime.parse(
                                  "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayPrayerList![c.currentPage.value]
                                      .startTime}").toLocal())}",
                              // "${DateFormat.jm().format(DateTime.now())}",
                              size: 20,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Stxt(
                              text:
                              "${homectrl.prayerDetailRT(3)}",
                              size: f2,
                              color: Colors.white,
                              weight: FontWeight.bold,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Raqat",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/svg/magribsunnath.svg"),
              ),
              SizedBox(height: 8),
              Text(
                "Benefits of Maghrib",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Space(8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "* Allah Almighty showers all His blessings and rewards on those who offer Maghrib prayer.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* Allah (SWT) will fulfill all your wishes and Duas.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* Allah Almighty will give you success in wealth and family.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 230.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/ishadet.png"
                      ),
                      fit: BoxFit.cover,
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Space(50),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(
                                    "assets/svg/backnew.svg"),
                                onTap: () {
                                  Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (_) => HomeView()));
                                },
                              ),
                            ],
                          ),
                          Space(32),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Stxt(
                                  weight: FontWeight.w500,
                                  text: "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayHijriDate}",
                                  size: f3,
                                  color: Colors.white,
                                );
                              }),
                            ],
                          ),
                          Space(16),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2),
                            child: Obx(() {
                              return Stxt(
                                text:
                                '${homectrl.prayerTimeData.value
                                    .getTodayMasjidPrayerTime!
                                    .todayPrayerList![c.currentPage.value]
                                    .prayerName}',
                                size: f5,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              );
                            }),
                          ),
                          Space(8),
                          Obx(() {
                            return Stxt(
                              text:
                              "${DateFormat('hh:mm a').format(DateTime.parse(
                                  "${homectrl.prayerTimeData.value
                                      .getTodayMasjidPrayerTime!
                                      .todayPrayerList![c.currentPage.value]
                                      .startTime}").toLocal())}",
                              // "${DateFormat.jm().format(DateTime.now())}",
                              size: 20,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Obx(() {

                              return Stxt(
                                text:
                                "${homectrl.prayerDetailRT(4)}",
                                size: f2,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                textAlign: TextAlign.end,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Raqat",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/svg/ishasunnath.svg"),
              ),
              SizedBox(height: 8),
              Text(
                "Benefits of Isha",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Space(8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "* If you offer Isha prayer, Allah will reward you to worship Allah for half night. "
                      "It is a great blessing for you. So, make sure to never miss the Isha prayer.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* Try to make more dua’s after the Isha prayer, Allah listen dua’s and will shower His blessings on you.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Text(
                  "* If you offer the prayer before going to sleep, you have a more peaceful night. So, try to offer Isha prayer regularly.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
