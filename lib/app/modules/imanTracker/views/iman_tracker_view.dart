import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/controllers/iman_tracker_controller.dart';

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
                    SizedBox(
                      child: EasyDateTimeLine(
                        headerProps: EasyHeaderProps(
                            showSelectedDate: false,
                            padding: EdgeInsets.all(0)),
                        dayProps: EasyDayProps(
                            height: 55.h,
                            width: 50.w,
                            dayStructure: DayStructure.dayStrDayNum),
                        timeLineProps: EasyTimeLineProps(),
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {
                          //[selectedDate] the new date selected.
                        },
                      ),
                    ),
                    10.verticalSpace,
                    Stxt(
                      text: "Prayers",
                      size: f3,
                      weight: FontWeight.bold,
                    ),
                    for (var k in prayerList)
                      imanCard(
                        image: '${k["icon"]}',
                        title: '${k["name"]}',
                      ),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: .2.w,
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
                    margin: EdgeInsets.all(15.sp),
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
                                                theme.colorScheme.primary
                                                    .withOpacity(.8),
                                                theme.primaryColor,
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
                                                theme.colorScheme.primary
                                                    .withOpacity(.8),
                                                theme.primaryColor,
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
            imanIndicator(ws: w,color: Colors.green,icon: Icons.groups_sharp,),
            imanIndicator(ws: ws,color: Colors.orange,icon: Icons.person,),
            imanIndicator(ws: w1,color: Colors.red,icon: Icons.history,),
            imanIndicator(ws: w2,color: Colors.black45,icon: Icons.not_interested,),
          ],
        ),
      ],
    );
  }
}

class imanIndicator extends StatelessWidget {
  const imanIndicator({
    super.key,
    required this.ws, this.color, this.icon,
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
          width: ((ws ==0) ? (.05.sw ):((ws <= .1)?(.1.sw) :( (ws -.05).sw))),
          lineHeight: 10.0,
          percent: (ws==0?(.1):ws) / (ws==0?(.1):ws),
          backgroundColor: Colors.grey,
          progressColor: color,
        ),
        5.verticalSpace,
        Row(
          children: [
            Icon(icon,size: f3,color: color,),
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
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
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
        trailing: ClipPath(
          clipper: TriangleClipper(),
          child: Container(
              width: 80.w,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.add)),
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
