import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';

class Events extends StatelessWidget {
  Events({
    super.key,
    required CarouselController carouselController,
  }) : _carouselController = carouselController;
  final _homectr = Get.find<HomeController>();
  final CarouselController _carouselController;

  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "events".tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Get.theme.hoverColor),
                  ),
                  Stxt(text: "3 Upcoming Events near you", size: 12, weight: FontWeight.w500,)
                ],
              ),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.EVENTS);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EventsPage(),
                    //     ));
                  },
                  child:  Stxt(
                    text: 'view_all'.tr, size: f2,color: Get.theme.hoverColor,
                    // "View all",
                    // style: TextStyle(fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          _homectr.eventsData.value.getMasjidEvents==null?Container(): CarouselSlider(
              carouselController: _carouselController,
              items: _homectr.eventsData.value.getMasjidEvents! .where((e) => e != null).take(5).map((e) {
                return Card(
                  color:Get.isDarkMode? ThemeService.primarycolor : Colors.white,
                  surfaceTintColor: themeData.primaryColor,
                  shadowColor: themeData.primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        e.image == null
                            ? Image.asset(
                                'assets/images/event_img.png',
                                fit: BoxFit.cover,
                                height: 85,
                                width: 140,
                              )
                            : Flexible(
                              flex: 1,
                              child: Container(
                                  height: 85,
                                  // width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: MemoryImage(
                                          base64Decode(e.image.toString())),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                        const SizedBox(
                          height: 8,
                        ),
                        Stxt(
                          text: " ${e.description}",
                          size: f1,
                          color: ThemeService.accentcolor,
                          weight: FontWeight.bold,
                          maxLines: 2,
                          family: "Inter",
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.verticalSpace,
                        //  Text(
                        //   '${e.description}',
                        //   style: TextStyle(
                        //       fontSize: f0,
                        //       color: Colors.indigo,
                        //       fontWeight: FontWeight.bold,),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                color: ThemeService.accentcolor,
                                size: f2,
                              ),
                              stxtN(
                                text: " ${e.masjidId!.masjidName}",
                                size: f1,
                                color: ThemeService.accentcolor,
                                weight: FontWeight.w500,
                              )
                            ],
                          ),
                        ),
                        2.verticalSpace,
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_outlined,
                              color: ThemeService.accentcolor,
                              size: f1,
                            ),
                            SizedBox(
                              width: 100,
                              child: Stxt(
                                maxLines: 2,
                                text: DateFormat(' MMMM d, y').format(
                                    DateTime.parse(
                                        "${e.startTime!.toLocal()}")),
                                weight: FontWeight.w400,
                                color: ThemeService.accentcolor,
                                size: f0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                // enlargeStrategy: CenterPageEnlargeStrategy.height,
                // enlargeCenterPage: true,
                // enlargeFactor: .4,
                disableCenter: true,
                enableInfiniteScroll: true,
                initialPage: 1,
                height: 180,
                viewportFraction: 0.4,
              )),
        ],
      ),
    );
  }
}
