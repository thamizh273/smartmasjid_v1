import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/controllers/iman_tracker_controller.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';

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
                      child: EasyDateTimeLine(
                        headerProps: EasyHeaderProps(
                            showHeader: false,
                            //  monthPickerType : MonthPickerType.dropDown,
                            showSelectedDate: false,
                            padding: EdgeInsets.all(0)),
                        dayProps: EasyDayProps(
                          // activeDayNumStyle: TextStyle(fontSize: 18,color: Colors.white),
                          // inactiveDayNumStyle: TextStyle(fontSize: 18,color: Colors.black),
                            height: 50.h,
                            width: 50.w,
                            dayStructure: DayStructure.dayStrDayNumMonth),
                        timeLineProps: EasyTimeLineProps(),
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {
                          //[selectedDate] the new date selected.
                        },
                      ),
                    ),
                    15.verticalSpace,
                    Stxt(
                      text: "Prayers",
                      size: f3,
                      weight: FontWeight.bold,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: prayerList.length,
                      itemBuilder: (context, index) {
                        var k = prayerList[index];

                        return Obx(() =>
                            imanCard(
                              image: '${k["icon"]}',
                              title: '${k["name"]}',
                              color: controller.cardColors[
                              controller.colorIndices[index]]["color"],
                              suffixIcon: controller.cardColors[
                              controller.colorIndices[index]]["icon"],
                              onTap: () {
                                controller.changeColor(index);
                                print("$index");
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
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SButton(

                                                  height: 35.h,
                                                  ontap: () {},
                                                  text: "Not Prayed",
                                                  prefix: Icon(
                                                    Icons.not_interested,
                                                    color: clr_black,
                                                  )),
                                              SButton(
                                                  height: 35.h,

                                                  ontap: () {},
                                                  text: "Late",
                                                  prefix: Icon(
                                                    Icons.history,
                                                    color: clr_red,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SButton(
                                                height: 35.h,

                                                ontap: () {},
                                                text: "On Time",
                                                prefix: Icon(
                                                  Icons.man,
                                                  color: clr_yellow,
                                                )),
                                            SButton(
                                                height: 35.h,

                                                ontap: () {},
                                                text: "In Jamaah",
                                                prefix: Icon(
                                                  Icons.groups,
                                                  color: clr_green,
                                                )),
                                          ],
                                        ),
                                        Obx(() {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 25.w),
                                            child: CheckboxListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.r)),
                                              title: Stxt(
                                                  text: "After Sunnah (2)",
                                                  size: f2),
                                              activeColor: Get.theme
                                                  .primaryColor,
                                              tileColor:    clr_bg,
                                              value: controller.aSunnah.value,
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
                                                  BorderRadius.circular(8.r)),
                                              title: Stxt(
                                                  text: "Before Sunnah (2)",
                                                  size: f2),
                                              activeColor: Get.theme
                                                  .primaryColor,
                                              tileColor: clr_bg,
                                              value: controller.bSunnah.value,
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
                            ));
                      },
                    ),
                  
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
                        color: null, onTap: () {  }, suffixIcon: Icons.add, suffixonTap: () {  },
                      ),
                  ],
                ),
              ),
            ),
            DefaultTabController(
              length: 5,
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.sp),
                      // decoration: BoxDecoration(color: Colors.green),
                      borderColor: Colors.black,
                      backgroundColor: Get.theme.primaryColor,
                      unselectedBackgroundColor: Colors.white,
                      unselectedLabelStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: "Last Week",
                        ),
                        Tab(
                          text: "Last Month",
                        ),
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
                        ListView(
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
                                  child: Column(
                                    children: [
                                      buildProgressIndicator(title: 'Fajr'),
                                      buildProgressIndicator(title: 'Dhuhr'),
                                      buildProgressIndicator(title: 'Asr'),
                                      buildProgressIndicator(title: 'Maghrib'),
                                      buildProgressIndicator(title: 'Isha'),
                                      10.verticalSpace,
                                    ],
                                  ),
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
                        ),
                        Center(
                          child: Icon(Icons.directions_bike),
                        ),
                        Center(
                          child: Icon(Icons.directions_bike),
                        ),
                        Center(
                          child: Icon(Icons.directions_bike),
                        ),
                        Center(
                          child: Icon(Icons.directions_car),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Column buildProgressIndicator({required String title}) {
    var w = .4;
    var ws = .1;
    var w1 = .3;
    var w2 = .2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stxt(
          pad: EdgeInsets.symmetric(vertical: 10.h),
          text: title,
          size: f3,
          weight: FontWeight.w500,
        ),
        Row(
          children: [
            imanIndicator(
              ws: w,
              color: Colors.green,
              icon: Icons.groups_sharp,
            ),
            imanIndicator(
              ws: ws,
              color: Colors.yellow.shade700,
              icon: Icons.person,
            ),
            imanIndicator(
              ws: w1,
              color: Colors.red.shade700,
              icon: Icons.history,
            ),
            imanIndicator(
              ws: w2,
              color: Colors.black45,
              icon: Icons.not_interested,
            ),
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

  final num ws;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearPercentIndicator(
          padding: EdgeInsets.only(right: 5),
          barRadius: Radius.circular(5),
          width:
          ((ws == 0) ? (.05.sw) : ((ws <= .1) ? (.1.sw) : ((ws - .05).sw))),
          lineHeight: 10.0,
          percent: (ws == 0 ? (.1) : ws) / (ws == 0 ? (.1) : ws),
          backgroundColor: Colors.grey,
          progressColor: color,
        ),
        5.verticalSpace,
        Row(
          children: [
            Icon(
              icon,
              size: f3,
              color: color,
              shadows: [ BoxShadow(color: Colors.grey,spreadRadius: 2,blurRadius: 2,offset: Offset(0,1))],
            ),
            2.horizontalSpace,
            Stxt(text: '${((ws) * 100).toInt()}%', size: f1),
          ],
        )
      ],
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
  final Color? color;
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
