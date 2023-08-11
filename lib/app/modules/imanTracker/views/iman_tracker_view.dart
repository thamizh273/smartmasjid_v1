import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/controllers/iman_tracker_controller.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/safa_dropdown2.dart';

import '../../../routes/export.dart';

class ImanTrackerView extends GetView<ImanTrackerController> {
  ImanTrackerView({Key? key}) : super(key: key);

  // final controller =Get.put(ImanTrackerController());
  List prayerList = [
    {"icon": "fajr_icon", "name": "Fajr"},
    {"icon": "dhuhr_icon", "name": "Dhuhr"},
    {"icon": "asr", "name": "Asr"},
    {"icon": "magrib", "name": "Magrib"},
    {"icon": "isha", "name": "Isha"}
  ];
  List quranList = [
    {"icon": "read_quran", "name": "Read Quran"},
    {"icon": "memorize_quran", "name": "Memorize Quran"},
  ];
  final theme = Get.theme;
  Map<String, double> dataMap = {
    "Completed": 5,
    "Partial": 3,
    "Not Reading": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "Iman Tracker",
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(2),
              controller: controller.tabctrl,
              tabs: controller.myTabs,
              onTap: (v) {
                log('wwwwwww $v');
              },
            ),
          ),
          height: 80.h,
        ),
        body: TabBarView(
          controller: controller.tabctrl,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    10.verticalSpace,
                    SizedBox(
                        child:

                        FlutterDatePickerTimeline(
                          // initialFocusedDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                          unselectedItemTextStyle:
                          TextStyle(fontWeight: FontWeight.w500),
                          selectedItemBackgroundColor: Get.theme.primaryColor,
                          unselectedItemWidth: 45,
                          startDate: DateTime(DateTime
                              .now()
                              .year, DateTime
                              .now()
                              .month, 2).toUtc(),
                          // endDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 2).toUtc().subtract(Duration(days: 1)),
                          endDate: DateTime.now().toUtc(),
                          initialSelectedDate: DateTime.now().toUtc(),
                          onSelectedDateChange: (dateTime) {
                            controller.selectedDate.value = dateTime!.toUtc();
                            controller.getImanTrakerEntry();
                            log('${dateTime}');
                          },
                        )

                    ),
                    15.verticalSpace,
                    Stxt(
                      text: "Prayers",
                      size: f3,
                      weight: FontWeight.bold,
                    ),
                    Obx(() {
                      return controller.isloading.value
                          ? loading(context)
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: prayerList.length,
                        itemBuilder: (context, index) {
                          var k = prayerList[index];
                          var col = controller.imanData.value
                              .getPrayerListTracker![index];

                          return imanCard(
                            image: '${k["icon"]}',
                            title: '${col.prayerName}',
                            color: col.status == "late"
                                ? clr_yellow
                                : (col.status == "injamaah"
                                ? clr_green
                                : (col.status == "ontime"
                                ? clr_blue
                                : (col.status == "notprayed"
                                ? clr_red
                                : theme
                                .colorScheme.secondary))),
                            suffixIcon: col.status == "late"
                                ? Icons.history
                                : (col.status == "injamaah"
                                ? Icons.groups_sharp
                                : (col.status == "ontime"
                                ? Icons.person
                                : (col.status == "notprayed"
                                ? Icons.not_interested
                                : Icons.add))),
                            onTap: () {
                              //  controller.changeColor(index);
                              //  print("$index");
                            },
                            suffixonTap: () {
                              Get.bottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  Column(
                                    children: [
                                      20.verticalSpace,
                                      SvgPicture.asset(
                                        "assets/icons/${k["icon"]}.svg",
                                        height: 25,
                                        color: Get.theme.primaryColor,
                                      ),
                                      Stxt(
                                        pad: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        text:
                                        'How did you complete Asr today?',
                                        size: f3,
                                        weight: FontWeight.bold,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Obx(() {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              SButton(
                                                  color: controller.status
                                                      .value == "notprayed"
                                                      ? theme
                                                      .primaryColor
                                                      : null,
                                                  height: 35.h,
                                                  ontap: () {
                                                    controller.status.value =
                                                    "notprayed";
                                                    controller.prayerId.value =
                                                        col.prayerId.toString();
                                                    controller.update();
                                                  },
                                                  text: "Not Prayed",
                                                  prefix: Icon(
                                                    Icons.not_interested,
                                                    color: clr_red,
                                                  )),
                                              SButton(
                                                  color: controller.status
                                                      .value == "late"
                                                      ? theme
                                                      .primaryColor
                                                      : null,
                                                  height: 35.h,
                                                  ontap: () {
                                                    controller.status.value =
                                                    "late";
                                                    controller.prayerId.value =
                                                        col.prayerId.toString();
                                                    controller.update();
                                                  },
                                                  text: "Late",
                                                  prefix: Icon(
                                                    Icons.history,
                                                    color: clr_yellow,
                                                  )),
                                            ],
                                          );
                                        }),
                                      ),
                                      Obx(() {
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SButton(
                                                color: controller.status
                                                    .value == "ontime" ? theme
                                                    .primaryColor : null,
                                                height: 35.h,
                                                ontap: () {
                                                  controller.status.value =
                                                  "ontime";
                                                  controller.prayerId.value =
                                                      col.prayerId.toString();
                                                  controller.update();
                                                },
                                                text: "On Time",
                                                prefix: Icon(
                                                  Icons.man,
                                                  color: clr_blue,
                                                )),
                                            SButton(
                                                color: controller.status
                                                    .value == "injamaah" ? theme
                                                    .primaryColor : null,
                                                height: 35.h,
                                                ontap: () {
                                                  controller.status.value =
                                                  "injamaah";
                                                  controller.prayerId.value =
                                                      col.prayerId.toString();
                                                  controller.update();
                                                },
                                                text: "In Jamaah",
                                                prefix: Icon(
                                                  Icons.groups,
                                                  color: clr_green,
                                                )),
                                          ],
                                        );
                                      }),
                                      Obx(() {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                              horizontal: 25.w),
                                          child: CheckboxListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.r)),
                                            title: Stxt(
                                                text: "After Sunnah (2)",
                                                size: f2),
                                            activeColor:
                                            Get.theme.primaryColor,
                                            tileColor: clr_bg,
                                            value:
                                            controller.aSunnah.value,
                                            onChanged: (value) {
                                              controller.aSunnah.value =
                                              value!;
                                            },
                                            dense: true,
                                            visualDensity:
                                            VisualDensity.compact,
                                          ),
                                        );
                                      }),
                                      Obx(() {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: CheckboxListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8.r)),
                                            title: Stxt(
                                                text: "Before Sunnah (2)",
                                                size: f2),
                                            activeColor:
                                            Get.theme.primaryColor,
                                            tileColor: clr_bg,
                                            value:
                                            controller.bSunnah.value,
                                            onChanged: (value) {
                                              controller.bSunnah.value =
                                              value!;
                                            },
                                            dense: true,
                                            visualDensity:
                                            VisualDensity.compact,
                                          ),
                                        );
                                      }),
                                      20.verticalSpace,
                                      SButton(
                                          ontap: () {
                                            controller.updatestatus();
                                            Navigator.pop(context);
                                          },
                                          text: "Submit",
                                          color: Get.theme.primaryColor,
                                          txtClr: Colors.white)
                                    ],
                                  ),
                                  backgroundColor:
                                  Get.theme.colorScheme.secondary);
                              print("click");
                            },
                          );
                        },
                      );
                    }),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: .2.sw,
                          ),
                          Stxt(
                            text: "Quran",
                            size: f3,
                            weight: FontWeight.bold,
                          ),
                          Stxt(
                            text: "Change Goals",
                            size: f0,
                            weight: FontWeight.bold,
                            color: Get.theme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    for (var k in quranList)
                      imanCard(
                        image: '${k["icon"]}',
                        title: '${k["name"]}',
                        // onTap: () {},
                        color: null,
                        onTap: () {},
                        suffixIcon: Icons.add,
                        suffixonTap: () {
                          Get.dialog(AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Stxt(
                                      text: "My Goals",
                                      size: f3,
                                      color: theme.primaryColor,
                                      weight: FontWeight.bold,
                                    ),
                                    Icon(Icons.close)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Stxt(
                                      text: "Read Quran(Daily)",
                                      size: f2,
                                      weight: FontWeight.bold,
                                    ),
                                    Safa_textfield(
                                      keyboardType: TextInputType.number,
                                      contentPad: 0,
                                      contentHPad: 3,
                                      fillColor: Colors.white,
                                      width: .15,
                                      height: 30,
                                      hint: "0",
                                    ),
                                    SafaDropdownButton2(
                                      hint: "Verse",
                                      value: "Verse",
                                      dropdownItems: ["Juz", "Verse"],
                                      onChanged: (value) {},
                                      buttonWidth: 30,
                                    ),
                                  ],
                                ).paddingSymmetric(vertical: 10.h),
                                Row(
                                  children: [
                                    Stxt(
                                      text: "Memorize Quran(Daily)",
                                      size: f2,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                SButton(ontap: () {}, text: "Submit",color: theme.primaryColor,txtClr: clr_white)
                              ],
                            ),
                          ));
                        },
                      ),
                  ],
                ),
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.sp, top: 15, bottom: 15),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      //     border: Border.all(
                      //       width: 2,
                      //       color: Colors.grey.shade300,
                      //   ),
                        borderRadius: BorderRadius.circular(5)),
                    child: ButtonsTabBar(
                      onTap: (index) {
                        log('$index');
                        if (index == 0) {
                          controller.getImanTrakerStatus("week");
                        } else if (index == 1) {
                          controller.getImanTrakerStatus("month");
                        } else {
                          controller.getImanTrakerStatus("total");
                        }
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.sp),
                      // decoration: BoxDecoration(color: Colors.green),
                      borderColor: Colors.black,
                      backgroundColor: Get.theme.primaryColor,
                      unselectedBackgroundColor: Colors.white,
                      unselectedLabelStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: "This Week",
                        ),
                        Tab(
                          text: "This Month",
                        ),
                        Tab(
                          text: "All Time",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        statusCommonWidget(context),
                        statusCommonWidget(context),
                        statusCommonWidget(context),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  ListView statusCommonWidget(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Stxt(
            text: 'Prayers Summary',
            size: f2,
            color: theme.primaryColor,
            weight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.all(8.sp),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Obx(() {
                return controller.isloading1.value
                    ? loading(context)
                    : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller
                      .imanStatusData
                      .value
                      .getImanTrackerStatus!
                      .length,
                  itemBuilder: (BuildContext context,
                      int index) {
                    var status = controller
                        .imanStatusData
                        .value
                        .getImanTrackerStatus![index];
                    return buildProgressIndicator(
                      title: "${status.trackerName}",
                      injamaah:
                      (status.status!.injamaah!),
                      ontime: status.status!.ontime!,
                      late: status.status!.late!,
                      notprayed:
                      status.status!.notprayed!,
                    );
                  },
                );
              }),
            ),
          ),
        ),
        10.verticalSpace,
        Center(
          child: Stxt(
            text: 'Quran Summary',
            size: f2,
            color: theme.primaryColor,
            weight: FontWeight.w500,
          ),
        ),
        Card(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Stxt(
                        text: 'Reading Quran\n (10 verse)',
                        size: f2,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      10.verticalSpace,
                      PieChart(
                          chartLegendSpacing: 15.h,
                          colorList: [
                            Color(0xff1A657E),
                            Color(0xff5EA4BB),
                            // theme.colorScheme.primary
                            //     .withOpacity(.8),
                            // theme.primaryColor,
                            theme.colorScheme.secondary,
                          ],
                          dataMap: dataMap,
                          legendOptions: LegendOptions(
                            legendPosition:
                            LegendPosition.bottom,
                          ),
                          chartValuesOptions:
                          ChartValuesOptions(
                            showChartValuesInPercentage:
                            true,
                          )),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Stxt(
                        text: 'Memorize Quran\n (10 verse)',
                        size: f2,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      10.verticalSpace,
                      PieChart(
                          chartLegendSpacing: 15.h,
                          colorList: [
                            Color(0xff1A657E),
                            Color(0xff5EA4BB),
                            // theme.colorScheme.primary
                            //     .withOpacity(.8),
                            // theme.primaryColor,
                            theme.colorScheme.secondary,
                          ],
                          dataMap: dataMap,
                          legendOptions: LegendOptions(
                            legendPosition:
                            LegendPosition.bottom,
                          ),
                          chartValuesOptions:
                          ChartValuesOptions(
                            showChartValuesInPercentage:
                            true,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        20.verticalSpace,
      ],
    );
  }

  Column buildProgressIndicator({required String title,
    required injamaah,
    required ontime,
    required late,
    required notprayed}) {
    var hhh = injamaah == 0 && ontime == 0 && late == 0 && notprayed == 0;
    var disableclr = Colors.grey.shade300;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stxt(
          pad: EdgeInsets.symmetric(vertical: 10.h),
          text: title[0].toUpperCase() + title.substring(1),
          size: f3,
          weight: FontWeight.w500,
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: injamaah == 0 ? 1 : (injamaah == 100 ? 11 : int.parse(
                      (injamaah + 20).toString()[0])),
                  child: imanIndicator(
                    ws: injamaah,
                    color: hhh ? disableclr : Colors.green.shade400,
                    icon: Icons.groups_sharp,
                  ),
                ),
                Expanded(
                  flex: ontime == 0 ? 1 : (ontime == 100 ? 11 : int.parse(
                      (ontime + 20).toString()[0])),
                  child: imanIndicator(
                    ws: ontime,
                    color: hhh ? disableclr : Colors.blue.shade400,
                    icon: Icons.person,
                  ),
                ),
                Expanded(
                  flex: late == 0 ? 1 : (late == 100 ? 11 : int.parse(
                      (late + 20).toString()[0])),
                  child: imanIndicator(
                    ws: late,
                    color: hhh ? disableclr : Colors.yellow.shade600,
                  ),
                ),
                Expanded(
                  flex: notprayed == 0 ? 1 : (notprayed == 100 ? 11 :((notprayed >= 90) ? 10 : int.parse(
                      (notprayed + 10).toString()[0]))),
                  child: imanIndicator(
                    ws: notprayed,
                    color: hhh ? disableclr : Colors.red.shade400,
                  ),
                ),
              ],
            ),
            5.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.groups_sharp,
                      size: f3,
                      color: Colors.green,
                    ),
                    Stxt(text: '${("${injamaah}")}%', size: f1),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: f3,
                      color: Colors.blueAccent,
                    ),
                    Stxt(text: '${("${ontime}")}%', size: f1),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.history,
                      size: f3,
                      color: Colors.yellow.shade600,
                    ),
                    Stxt(text: '${("${late}")}%', size: f1),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.not_interested,
                      size: f3,
                      color: Colors.red,
                    ),
                    Stxt(text: '${("${notprayed}")}%', size: f1),
                  ],
                ),
              ],
            )
          ],
        ),

      ],
    );
  }
}

class imanIndicator extends StatelessWidget {
  const imanIndicator({
    super.key,
    required this.ws,
    this.color,
    this.icon,
  });

  final int ws;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        children: [

          ///
          Container(
            height: 12,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
          ),

          ///
        ],
      ),
    );
  }
}

class imanCard extends StatelessWidget {
  const imanCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    required this.color,
    required this.suffixIcon,
    required this.suffixonTap,
  });

  final String image;
  final String title;
  final color;
  final IconData? suffixIcon;
  final Function() onTap;
  final Function() suffixonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () => onTap(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        //  minVerticalPadding: 0,
        contentPadding: EdgeInsets.only(left: 20.sp),
        tileColor: Colors.white,
        leading: SvgPicture.asset(
          "assets/icons/$image.svg",
          height: 20,
          color: Get.theme.primaryColor,
        ),
        title: Stxt(
          text: '$title',
          size: f3,
          weight: FontWeight.w500,
        ),
        trailing: GestureDetector(
          onTap: () => suffixonTap(),
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(
                padding: EdgeInsets.only(left: 5.w),
                width: 80.w,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    color: color ?? Get.theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  suffixIcon,
                  color: Colors.white,
                  size: 30.sp,
                )),
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width * 1, 0);
    path.lineTo(size.width, size.height * 1);

    path.lineTo(size.width * 0.2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
