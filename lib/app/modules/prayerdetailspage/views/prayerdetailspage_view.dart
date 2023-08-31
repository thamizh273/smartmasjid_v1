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
          SingleChildScrollView(
            child: Column(
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
                  "raqat".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/fajrsunnathnw.svg"),
                ),
                SizedBox(height: 8),
                Text(
                  "benefits_of_fajr".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Space(8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "if_you_start_your_day_with_prayers_then_Allah_Almighty_protects_you_all_day."
                        "in_the_hadith_Prophet_Muhammad_(SAW)said: 'Whoever_offers_the_Morning_Prayer_he_is_under_the_protection_of_Allah_the_Mighty_and_Sublime'_(Ibn_Majah)".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,),textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* fajr_prayer_ensures_that_we_begin_the_day_with_light_and_with_life."
                        "Early_morning_sets_the_tone_and_energy_for_the_whole_day,"
                        "and_by_beginning_the_day_in_the_best_possible_way.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return homectrl.prayerTimeData.value.getTodayMasjidPrayerTime!
                .todayPrayerList![c.currentPage.value].prayerName == "Dhuhr"
                ? SingleChildScrollView(
                  child: Column(
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
                    "raqat".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/svg/duhrsunnath.svg"),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "benefits_of_dhuhr".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Space(8),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "* Zuhr_prayer_is_the_time_when_the_gates_of_Heaven_are_opened_for_the_Muslims._During_the_Zuhr_hour,_the_gates_of_heaven_are_opened._So,"
                          "it_is_important_to_do_good_deeds_at_this_time_and_offering_Salah_is_the_most_important_at_that_time.".tr,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 16),
                    child: Text(
                      "*Allah_Almighty_showers_His_blessings_on_those_who_offer_Zuhr_prayers_at_the_time.".tr,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
                ) : SingleChildScrollView(
                  child: Column(
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
                    "raqat".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/svg/jummahsunnath.svg"),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "benefits_of_jummah".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Space(8),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "* Jummah_(Friday)_is_the_most_important_day_of_the_week_because_Muslims_assemble_for_congregational_Prayer_on_Friday.".tr,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 16),
                    child: Text(
                      "* Before_the_Friday_prayer,_Muslims_listen_to_a_lecture_meant_to_provide_them_with_essential_information_about_Islam,_Prophets,_and_Allah_Almighty.".tr,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 16),
                    child: Text(
                      "* There_is_one_day_among_the_seven_days_in_Islam_that_Allah_has_declared_to_be_very_important.".tr,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
              ],
            ),
                );
          }),


          SingleChildScrollView(
            child: Column(
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
                  "raqat".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/asrsunnath.svg"),
                ),
                SizedBox(height: 8),
                Text(
                  "benefits_of_asr".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Space(8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "* One_of_the_greatest_blessings_for_every_Muslim_is_to_enter_into_Paradise._Whoever_offers_the_Fajr_and_Asr_prayers_enters_the_Jannah.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* Asr_prayer_saves_from_the_Hell_and_opens_the_door_of_Jannah.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* Those_who_offer_Asr_prayer_will_give_you_success_in_life_as_well_as_in_the_Hereafter.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
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
                  "raqat".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/magribsunnath.svg"),
                ),
                SizedBox(height: 8),
                Text(
                  "benefits_of_maghrib".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Space(8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "* Allah_Almighty_showers_all_His_blessings_and_rewards_on_those_who_offer_Maghrib_prayer.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* Allah_(SWT)_will_fulfill_all_your_wishes_and_Duas.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* Allah_Almighty_will_give_you_success_in_wealth_and_family.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
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
                  "raqat".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/ishasunnath.svg"),
                ),
                SizedBox(height: 8),
                Text(
                  "benefits_of_isha".tr,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Space(8),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "* If_you_offer_Isha_prayer,_Allah_will_reward_you_to_worship_Allah_for_half_night."
                        "It_is_a_great_blessing_for_you._So,_make_sure_to_never_miss_the_Isha_prayer.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* Try_to_make_more_dua’s_after_the_Isha_prayer,_Allah_listens_dua’s_and_will_shower_His_blessings_on_you.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                  child: Text(
                    "* If_you_offer_the_prayer_before_going_to_sleep,_you_have_a_more_peaceful_night._So,_try_to_offer_Isha_prayer_regularly.".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
