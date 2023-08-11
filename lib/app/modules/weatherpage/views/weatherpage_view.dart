import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartmasjid_v1/app/modules/weatherdetail/views/weatherdetail_view.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/controllers/weatherpage_controller.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/views/add_weather.dart';
import 'package:smartmasjid_v1/app/routes/app_pages.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../utils/color_utils.dart';


class WeatherpageView extends StatelessWidget {
  WeatherpageView({super.key});

  WeatherpageController c = Get.put(WeatherpageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return c.isLoadings1.value ? loading(context) : Scaffold(
        body: Column(
          children: [
            Container(
                height: 560.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 6,
                        offset: Offset(0, 4),
                        color: Colors.grey.shade400
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)),
                  gradient: LinearGradient(colors: [
                    hexStringToColor("53899B"),
                    hexStringToColor("23687F"),
                  ]),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop(MaterialPageRoute(
                                      builder: (_) => HomeView()));
                                },
                                child: SvgPicture.asset(
                                    "assets/svg/backnew.svg")),
                            Space(16),
                            Stxt(text: "Weather",
                              size: f5,
                              weight: FontWeight.w600,
                              color: Colors.white,),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Addweather()));
                                },
                                child: Icon(
                                  Icons.add, size: 35, color: Colors.white,))
                          ],
                        ),
                        Space(16),
                        SizedBox(
                          width: double.infinity,
                          height: 30.h,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              separatorBuilder: (BuildContext context,
                                  int index) =>
                              const Space(8),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    c.setSelectedIndex(index);
                                  },
                                  child: Obx(() {
                                    bool isSelected = c.selectedIndex.value ==
                                        index;
                                    return AnimatedContainer(
                                        duration: Duration(milliseconds: 100),
                                        height: 30.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              16),
                                          border: Border.all(
                                              color: Colors.white),
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                        child: Center(
                                            child: Stxt(
                                                text: "${c.getweatherdata.value
                                                    .getWeatherReport!.location!
                                                    .region},${c.getweatherdata
                                                    .value.getWeatherReport!
                                                    .location!.country}",
                                                size: f3,
                                                color: isSelected ? Theme
                                                    .of(context)
                                                    .primaryColor : Colors
                                                    .white))
                                    );
                                  }),
                                );
                              }
                          ),
                        ),
                        Space(16),
                        c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.condition!.text ==
                            "Moderate rain" ? Image.asset(
                          "assets/images/rainybig.png",) :
                        c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.condition!.text == "Sunny"
                            ? Image.asset("assets/images/weather.png",)
                            :
                        c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.condition!.text ==
                            "Patchy rain possible" ? Image.asset(
                          "assets/images/rainybig.png",) :
                        c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.condition!.text ==
                            "Partly cloudy" ? Image.asset(
                          "assets/images/cloudybig.png",) :
                        c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.condition!.text == "Sunny"
                            ? Image.asset("assets/images/weather.png",)
                            :  c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.condition!.text == "Heavy rain"
                            ? Image.asset("assets/images/rainybig.png",) :
                        Container(),
                        Text("${c.getweatherdata.value.getWeatherReport!
                            .currentWeatherData!.maxtempC}\u00B0",
                          style: TextStyle(
                              fontSize: 100, color: Colors.white),),
                        Stxt(
                          text: "${c.getweatherdata.value.getWeatherReport!
                              .currentWeatherData!.condition!.text}",
                          size: f4,
                          color: Colors.white,),
                        Space(4),
                        Stxt(text: "${c.getweatherdata.value.getWeatherReport!
                            .hijriDate}",
                          size: f2,
                          color: Colors.white,),
                        Space(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/svg/wind.svg"),
                                Space(8),
                                Stxt(
                                  text: "${c.getweatherdata.value
                                      .getWeatherReport!.currentWeatherData!
                                      .maxwindKph}Km/h",
                                  size: f3,
                                  color: Colors.white,),
                                Space(4),
                                Stxt(text: "Wind", size: f2, color: Colors.white
                                    .withOpacity(0.4),),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/svg/rain.svg"),
                                Space(8),
                                Stxt(text: "${c.getweatherdata.value
                                    .getWeatherReport!.currentWeatherData!
                                    .dailyChanceOfRain}%",
                                  size: f3,
                                  color: Colors.white,),
                                Space(4),
                                Stxt(
                                  text: "Chance of Rain",
                                  size: f2,
                                  color: Colors
                                      .white.withOpacity(0.4),),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/humidity.png", width: 15,),
                                Space(8),
                                Stxt(text: "${c.getweatherdata.value
                                    .getWeatherReport!.currentWeatherData!
                                    .avghumidity}%",
                                  size: f3,
                                  color: Colors.white,),
                                Space(4),
                                Stxt(
                                  text: "Humidity",
                                  size: f2,
                                  color: Colors.white
                                      .withOpacity(0.4),),
                              ],
                            ),
                          ],
                        )
                      ],
                    )

                )
            ),
            Space(16),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  // Stxt(text: "This Week", size: f3, weight: FontWeight.w500,),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) =>
                              WeatherdetailView()));
                    },
                    child: Container(child: Row(
                      children: [
                        Stxt(text: "10 days",
                          size: f3,
                          weight: FontWeight.w500,
                          color: Theme
                              .of(context)
                              .primaryColor,),
                        Icon(
                          Icons.arrow_forward_ios_outlined, size: 15,
                          color: Theme
                              .of(context)
                              .primaryColor,)
                      ],
                    )),
                  ),
                ],
              ),
            ),
            Space(8),
            SizedBox(
              height: 90.h,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (BuildContext context,
                    int index) => const Space(8),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      c.setSelectedIndex1(index);
                    },
                    child: Obx(() {
                      bool isSelected = c.selectedIndex1.value == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 16),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 80.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: isSelected? Color(0xff15627C) : Color(0xffD9D9D9)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Stxt(text: "Today", size: f2, weight: FontWeight
                                    .w600, color: isSelected? Colors.white: Colors.black),
                                Space(4),
                                Stxt(text: "26\u00B0", size: f2, color: isSelected? Colors.white: Colors.black,),
                                Space(4),
                                Image.asset(
                                  "assets/images/Raincloud.png", width: 30,),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },

              ),
            )
            // Padding(
            //   padding: const EdgeInsets.only(right: 16, bottom: 8, left: 16),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 80.w,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(16),
            //             color: Color(0xffD9D9D9)
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               Stxt(text: "Today", size: f2, weight: FontWeight
            //                   .w600,),
            //               Space(4),
            //               Stxt(text: "26\u00B0", size: f2),
            //               Space(4),
            //               Image.asset(
            //                 "assets/images/Raincloud.png", width: 30,),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Space(16),
            //       Container(
            //         width: 80.w,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(16),
            //             color: Color(0xffD9D9D9)
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               Stxt(text: "Today", size: f2, weight: FontWeight
            //                   .w600,),
            //               Space(4),
            //               Stxt(text: "26\u00B0", size: f2),
            //               Space(4),
            //               Image.asset(
            //                 "assets/images/Raincloud.png", width: 30,),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Space(16),
            //       Container(
            //         width: 80.w,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(16),
            //             color: Color(0xff15627C)
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               Stxt(text: "Today",
            //                 size: f2,
            //                 weight: FontWeight.w600,
            //                 color: Colors.white,),
            //               Space(4),
            //               Stxt(text: "26\u00B0", size: f2, color: Colors
            //                   .white,),
            //               Space(4),
            //               Image.asset(
            //                 "assets/images/Raincloud.png", width: 30,),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Space(16),
            //       Container(
            //         width: 80.w,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(16),
            //             color: Color(0xffD9D9D9)
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               Stxt(text: "Today", size: f2, weight: FontWeight
            //                   .w600,),
            //               Space(4),
            //               Stxt(text: "26\u00B0", size: f2),
            //               Space(4),
            //               Image.asset(
            //                 "assets/images/Raincloud.png", width: 30,),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
