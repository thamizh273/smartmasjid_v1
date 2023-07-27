import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/prayerdetailspage/views/prayerdetailspage_view.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/views/prayerpage_view.dart';

import '../../../routes/export.dart';
import '../controllers/home_controller.dart';

class PrayerTimes extends StatelessWidget {
  PrayerTimes({
    super.key,
  });

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => PrayerdetailspageView()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stxt(
            pad: EdgeInsets.only(left: 10),
            text: 'Prayer Times',
            size: f2,
            color: themeData.primaryColor,
            weight: FontWeight.bold,
          ),

          // SizedBox(
          //   height: 100,
          //
          //   child: ListView.builder(
          //     controller: _getScrollController(),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 5,
          //     itemBuilder: (context, index) {
          //
          //       return Container(
          //         width: 190.w,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(5),
          //                       image: DecorationImage(
          //                           image: AssetImage(
          //                             "assets/images/${controller.prayerTime[index]}.png",
          //                           ),
          //                           fit: BoxFit.fill)),
          //                   child: Padding(
          //                     padding:  EdgeInsets.all(8.sp),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.stretch,
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             const Stxt(
          //                               text: "3,Dhul Quadah,1444",
          //                               size: f1,
          //                               color: Colors.white,
          //                             ),
          //                             Container(
          //                               height: 20,
          //                               child: Transform.scale(
          //                                 scale: .8,
          //                                 child: Switch(
          //                                   inactiveThumbImage: Image.asset(
          //                                     "assets/images/alarm_clock.png",
          //                                   ).image,
          //                                   activeThumbImage: const AssetImage(
          //                                       "assets/images/alarm_clock.png"),
          //                                   inactiveThumbColor: Colors.red[400],
          //                                   //inactiveTrackColor: Colors.red[400],
          //                                   activeColor: Colors.green,
          //
          //                                   value: controller.alarm.value,
          //                                   onChanged: (value) {
          //
          //                                     controller.alarm.value = value;
          //
          //                                   },
          //
          //                                   splashRadius: 20,
          //                                 ),
          //                               ),
          //                             )
          //                           ],
          //                         ),
          //                         Padding(
          //                           padding:
          //                           const EdgeInsets.symmetric(vertical: 2),
          //                           child: Stxt(
          //                             text:
          //                             '${controller.prayerTime[index][0].toUpperCase()}${controller.prayerTime[index].substring(1)}',
          //                             size: f3,
          //                             color: Colors.white,
          //                             weight: FontWeight.bold,
          //                           ),
          //                         ),
          //                         Stxt(
          //                           text:
          //                           "${DateFormat.jm().format(DateTime.now())}",
          //                           size: 18.sp,
          //                           color: Colors.white,
          //                           weight: FontWeight.bold,
          //                         ),
          //                         Padding(
          //                           padding: const EdgeInsets.only(right: 5),
          //                           child: Stxt(
          //                             text:
          //                             "-${DateFormat.Hms().format(DateTime.now())}",
          //                             size: f2,
          //                             color: Colors.white,
          //                             weight: FontWeight.bold,
          //                             textAlign: TextAlign.end,
          //                           ),
          //                         ),
          //
          //                       ]),
          //                   ));},
          //   ),
          // ),
          ///
          Obx(() {
            return controller.isloading1.value
                ? CupertinoActivityIndicator()
                : CarouselSlider(
                    items: controller.prayerTime.asMap().entries.map((e) {
                      int index = e.key;
                      String prayerTimeName = e.value;
                      //  print(int.parse(e));
                      controller.rrr.value = controller
                          .prayerTimeData
                          .value
                          .getTodayMasjidPrayerTime!
                          .todayPrayerList![index]
                          .startTime.toString();
                      controller.update();
                      return Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 3,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/$prayerTimeName.png",
                                    ),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ListView(
                                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20.sp),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stxt(
                                            text:
                                                "${controller.prayerTimeData.value.getTodayMasjidPrayerTime!.todayHijriDate}",
                                            size: f1,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: 20,
                                            child: Transform.scale(
                                              scale: .8,
                                              child: Switch(
                                                inactiveThumbImage: Image.asset(
                                                  "assets/images/alarm_clock.png",
                                                ).image,
                                                activeThumbImage: const AssetImage(
                                                    "assets/images/alarm_clock.png"),
                                                inactiveThumbColor:
                                                    Colors.red[400],
                                                //inactiveTrackColor: Colors.red[400],
                                                activeColor: Colors.green,

                                                value: controller
                                                    .prayerTimeData
                                                    .value
                                                    .getTodayMasjidPrayerTime!
                                                    .todayPrayerList![index]
                                                    .notification!,
                                                onChanged: (value) {
                                                  controller.alarm.value =
                                                      value;
                                                },

                                                splashRadius: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        child: Stxt(
                                          text:
                                              '${controller.prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![index].prayerName}',
                                          size: f3,
                                          color: Colors.white,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      Stxt(
                                        text:
                                            "${DateFormat('hh:mm a').format(DateTime.parse("${controller.prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![index].startTime}").toLocal())}",
                                        size: 20,
                                        color: Colors.white,
                                        weight: FontWeight.bold,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Stxt(
                                          text: controller.remainTime(),
                                          // "-${DateFormat.Hms().format(
                                          //     DateTime.now())}",
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
                          )

                          // Image.asset(
                          //   "assets/images/$e.png",
                          //   fit: BoxFit.fill,
                          //   width: MediaQuery.of(context).size.width,
                          // ),
                          );
                    }).toList(),
                    options: CarouselOptions(

                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeCenterPage: true,
                       enlargeFactor: .1,
                      padEnds: true,
                      enableInfiniteScroll: false,
                      initialPage:controller.prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList!.indexWhere((prayer) => prayer.prayerStatus == "future"),

                      height: 130,
                      viewportFraction: .87,
                      onPageChanged: (index, reason) {

                        // Update the index in the controller
                        controller.updateIndex(index);
                      },
                    ),
                  );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return SizedBox(
                  width: 100.w,
                  child: StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: controller.currentIndex.value + 1,
                    size: 5,
                    padding: .01,
                    selectedColor: themeData.primaryColor,
                    unselectedColor: themeData.colorScheme.secondary,
                    roundedEdges: Radius.circular(10),
                    // selectedGradientColor: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [Colors.yellowAccent, Colors.deepOrange],
                    // ),
                    // unselectedGradientColor: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   colors: [Colors.black, Colors.blue],
                    // ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
