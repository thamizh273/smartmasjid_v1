import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/views/weatherdetail_view.dart';
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
      return c.isLoadings.value
          ? loading(context)
          : Scaffold(
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
                        color: Colors.grey.shade400)
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
                                  Navigator.of(context).pop(
                                      MaterialPageRoute(
                                          builder: (_) => HomeView()));
                                },
                                child: SvgPicture.asset(
                                    "assets/svg/backnew.svg")),
                            Space(16),
                            Stxt(
                              text: "Weather",
                              size: f5,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            // Spacer(),
                            // GestureDetector(
                            //     onTap: () {
                            //       // Navigator.of(context).push(MaterialPageRoute(
                            //       //     builder: (_) => Addweather()));
                            //     },
                            //     child: Icon(
                            //       Icons.add,
                            //       size: 35,
                            //       color: Colors.white,
                            //     ))
                          ],
                        ),
                        Space(16),
                        SizedBox(
                            width: double.infinity,
                            height: 30.h,
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                height: 30.h,
                                width: 140.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white),
                                  // color:Colors.white
                                ),
                                child: Center(
                                    child: Stxt(
                                      text:
                                      "${c.getweathertest.value.location!
                                          .name} ,    ${c
                                          .getweathertest.value.location!.region} ${c.getweathertest.value
                                          .location!.country}",
                                      size: f3,weight: FontWeight.w500,
                                      color: clr_white,
                                    )))),
                        Space(16),
                        c.getweathertest.value.current!.condition!.text ==
                            "Moderate rain"
                            ? Image.asset(
                          "assets/images/rainybig.png",
                        )
                            : c.getweathertest.value.current!.condition!
                            .text ==
                            "Sunny"
                            ? Image.asset(
                          "assets/images/weather.png",
                        )
                            : c.getweathertest.value.current!
                            .condition!.text ==
                            "Patchy rain possible"
                            ? Image.asset(
                          "assets/images/rainybig.png",
                        )
                            : c.getweathertest.value.current!
                            .condition!.text ==
                            "Partly cloudy"
                            ? Image.asset(
                          "assets/images/cloudybig.png",
                        )
                            : c.getweathertest.value.current!
                            .condition!.text ==
                            "Sunny"
                            ? Image.asset(
                          "assets/images/weather.png",
                        )
                            : c
                            .getweathertest
                            .value
                            .current!
                            .condition!
                            .text ==
                            "Heavy rain"
                            ? Image.asset(
                          "assets/images/rainybig.png",
                        )
                            :  c
                            .getweathertest
                            .value
                            .current!.condition!.text ==
                            "Thundery outbreaks possible"
                            ? Image.asset(
                          "assets/images/thunderbig.png",

                        ):Image.asset(
                          "assets/images/weather.png",
                        ),
                        Text(
                          "${c.getweathertest.value.current!.tempC!.round()}\u00B0C",
                          style: TextStyle(
                              fontSize: 80.sp, color: Colors.white),
                        ),
                        Stxt(
                          text:
                          "${c.getweathertest.value.current!.condition!.text}",
                          size: f4,weight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        Space(8),
                        Obx(() {
                          return c.isLoadings1.value?CupertinoActivityIndicator():Stxt(
                            text:
                            "${c.getweatherdata.value
                                .getWeatherReportFutureDate!
                                .hijriDate }  (${DateFormat('yyyy-MM-dd, ').add_EEEE().format(DateTime.now())})",
                            size: f2,weight: FontWeight.w600,
                            color: Colors.white,
                          );
                        }),
                        Space(20),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset("assets/svg/wind.svg"),
                                Space(8),
                                Stxt(
                                  text:
                                  "${c.getweathertest.value.current!
                                      .windKph}Km/h",
                                  size: f3,
                                  color: Colors.white,
                                ),
                                Space(4),
                                Stxt(
                                  text: "Wind",
                                  size: f2,
                                  color: Colors.white.withOpacity(0.4),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset("assets/svg/rain.svg"),
                                Space(8),
                                Stxt(
                                  text:
                                  "${c.getweathertest.value.current!
                                      .pressureIn}%",
                                  size: f3,
                                  color: Colors.white,
                                ),
                                Space(4),
                                Stxt(
                                  text: "Pressure",
                                  size: f2,
                                  color: Colors.white.withOpacity(0.4),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/humidity.png",
                                  width: 15,
                                ),
                                Space(8),
                                Stxt(
                                  text:
                                  "${c.getweathertest.value.current!
                                      .humidity}%",
                                  size: f3,
                                  color: Colors.white,
                                ),
                                Space(4),
                                Stxt(
                                  text: "Humidity",
                                  size: f2,
                                  color: Colors.white.withOpacity(0.4),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ))),
            Space(16),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  // Stxt(text: "This Week", size: f3, weight: FontWeight.w500,),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => WeatherdetailView()));
                    },
                    child: Container(
                        child: Row(
                          children: [
                            Stxt(
                              text: "View all",
                              size: f3,
                              weight: FontWeight.w500,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 15,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Space(8),
            Obx(() {
              return c.isLoadings1.value ? CupertinoActivityIndicator() : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureDay(

                    day:
                    '${c.getweatherdata.value.getWeatherReportFutureDate!.day1!
                        .day}',
                    temp:
                    '${c.getweatherdata.value.getWeatherReportFutureDate!.day1!
                        .maxtempC}',
                    icon: '${c.getweatherdata.value.getWeatherReportFutureDate!
                        .day1!.condition!.icon}',
                  ),
                  FutureDay(

                    day:
                    "${c.getweatherdata.value.getWeatherReportFutureDate!.day2!
                        .day}",
                    temp:
                    '${c.getweatherdata.value.getWeatherReportFutureDate!.day2!
                        .maxtempC}',
                    icon: '${c.getweatherdata.value.getWeatherReportFutureDate!
                        .day2!.condition!.icon}',
                  ),
                  FutureDay(

                    day:
                    "${c.getweatherdata.value.getWeatherReportFutureDate!.day3!
                        .day}",
                    temp:
                    '${c.getweatherdata.value.getWeatherReportFutureDate!.day3!
                        .maxtempC}',
                    icon: '${c.getweatherdata.value.getWeatherReportFutureDate!
                        .day3!.condition!.icon}',
                  ),
                ],
              );
            }),
          ],
        ),
      );
    });
  }
}

class FutureDay extends StatelessWidget {
  const FutureDay({
    super.key,

    required this.day,
    required this.temp, required this.icon,
  });


  final String day;
  final String temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 80.w,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey.shade400,spreadRadius: 1,blurRadius: 2,offset: Offset(2,4))],
          borderRadius: BorderRadius.circular(16), color: Color(0xffD9D9D9)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stxt(
                text: day,
                size: f2,
                weight: FontWeight.w600,
                color: Colors.black),
            Space(4),
            Stxt(
              text: "$temp\u00B0",
              size: f2,
              color: Colors.black,
            ),
            Space(4),
            // Stxt(
            //   text: "$icon",
            //   size: f1,
            //   color: Colors.black,
            // ),
            Image.network(
              "https:${icon}",
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
