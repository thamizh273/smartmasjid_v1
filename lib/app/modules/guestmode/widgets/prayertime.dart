import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/guestmode/controllers/guestmode_controller.dart';
import 'package:smartmasjid_v1/app/modules/prayerdetailspage/views/prayerdetailspage_view.dart';
import '../../../routes/export.dart';


class PrayerTimes extends StatelessWidget {
  PrayerTimes({super.key,});

  final controller = Get.put(GuestmodeController());
  late final CarouselController carouselController;


  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return controller.guestprayertime.value.getPrayerTimeGuest == null
        ? Container()
        : GestureDetector(
      onTap: () {

        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (_) => PrayerdetailspageView()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stxt(
            pad: EdgeInsets.only(left: 10),
            text: 'prayer_time'.tr,
            size: f3,
            color: Get.theme.hoverColor,
            weight: FontWeight.bold,
          ),
          Space(10),
          ///
          Obx(() {
            return controller.isloading1.value
                ? CupertinoActivityIndicator()
                : CarouselSlider(
              items:List.generate(5, (index) {
                String prayerName = '';
                String prayerTime = '';
                switch (index) {
                  case 0:
                    prayerName = 'Fajr';
                    prayerTime = controller.guestprayertime.value.getPrayerTimeGuest!.prayer!.fajr!;
                    break;
                  case 1:
                    prayerName = 'Dhuhr';
                    prayerTime = controller.guestprayertime.value.getPrayerTimeGuest!.prayer!.dhuhr!;
                    break;
                  case 2:
                    prayerName = 'Asr';
                    prayerTime = controller.guestprayertime.value.getPrayerTimeGuest!.prayer!.asr!;
                    break;
                  case 3:
                    prayerName = 'Maghrib';
                    prayerTime = controller.guestprayertime.value.getPrayerTimeGuest!.prayer!.maghrib!;
                    break;
                  case 4:
                    prayerName = 'Isha';
                    prayerTime = controller.guestprayertime.value.getPrayerTimeGuest!.prayer!.isha!;
                    break;
                  default:
                    break;
                }
               // bool isMorning = int.parse(prayerTime.split(":")[0]) < 12;
                DateTime time = DateFormat("HH:mm").parse(prayerTime);
                String prayerTime12 = DateFormat("h:mm a").format(time);
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/${controller.prayerTime[index]}.png",
                        ),
                        fit: BoxFit.fill)),
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 12),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Stxt(
                                text:
                                "${controller.guestprayertime.value
                                    .getPrayerTimeGuest!
                                    .todayHijriDate}",
                                size: f3,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Space(12),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2),
                            child: Stxt(
                              text:
                              prayerName,
                              size: f5,
                              color: Colors.white,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Space(12),
                          Row(
                            children: [
                              Stxt(
                                text:prayerTime12,
                                size: 20,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              Space(4),
                              Icon(Icons.alarm, color: Colors.white,),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              );
            }),
              options: CarouselOptions(
                height: 150.0,
                aspectRatio: 16/9,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 10),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }),
          Space(10),
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


