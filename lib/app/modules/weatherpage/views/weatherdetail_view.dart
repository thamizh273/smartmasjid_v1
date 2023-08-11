import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/model/weather_model.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/views/weatherpage_view.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/gotoverse.dart';
import '../../../routes/export.dart';
import '../../weatherdetail/controllers/weatherdetail_controller.dart';
import '../controllers/weatherpage_controller.dart';

class WeatherdetailView extends StatelessWidget {
  WeatherdetailView({Key? key}) : super(key: key);
  WeatherpageController c = Get.put(WeatherpageController());

  @override
  Widget build(BuildContext context) {
    var witem = c.getweathertest.value.current!;
    var daywise = c.getweatherdata.value.getWeatherReportFutureDate!;
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 330.h,
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
                padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (_) => WeatherpageView()));
                            },
                            child: SvgPicture.asset("assets/svg/backnew.svg")),
                        Space(16),
                        Stxt(
                          text: "Weather",
                          size: f5,
                          weight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Space(16),
                    Row(
                      children: [
                        witem.condition!.text == "Moderate rain"
                            ? Image.asset(
                                "assets/images/rainybig.png",
                                width: 200.w,
                              )
                            : witem.condition!.text == "Sunny"
                                ? Image.asset(
                                    "assets/images/weather.png",
                                    width: 200.w,
                                  )
                                : witem.condition!.text ==
                                        "Patchy rain possible"
                                    ? Image.asset(
                                        "assets/images/rainybig.png",
                                        width: 200.w,
                                      )
                                    : witem.condition!.text == "Partly cloudy"
                                        ? Image.asset(
                                            "assets/images/cloudybig.png",
                                            width: 200.w,
                                          )
                                        : witem.condition!.text == "Sunny"
                                            ? Image.asset(
                                                "assets/images/weather.png",
                                                width: 200.w,
                                              )
                                            : witem.condition!.text ==
                                                    "Heavy rain"
                                                ? Image.asset(
                                                    "assets/images/rainybig.png",
                                                    width: 200.w,
                                                  )
                                                : witem.condition!.text ==
                                                        "Thundery outbreaks possible"
                                                    ? Image.asset(
                                                        "assets/images/thunderbig.png",
                                                        width: 200.w,
                                                      )
                                                    : Image.asset(
                                                        "assets/images/weather.png",
                                                        width: 200.w,
                                                      ),
                        Text(
                          "${witem.tempC!.round()}\u00B0C",
                          style: TextStyle(fontSize: 55.w, color: Colors.white),
                        ),
                      ],
                    ),
                    Stxt(
                      text: "${witem.condition!.text}",
                      size: f4,
                      color: Colors.white,
                    ),
                    Space(4),
                    Stxt(
                      text:
                          "${daywise.hijriDate}  (${DateFormat('yyyy-MM-dd, ').add_EEEE().format(DateTime.now())})",
                      size: f2,
                      color: Colors.white,
                    ),
                    Space(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset("assets/svg/wind.svg"),
                            Space(8),
                            Stxt(
                              text: "${witem.windKph} Km/h",
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
                              text: "${witem.pressureIn}%",
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
                              text: "${witem.humidity}%",
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
                ),
              )),

          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                daywiseWeather(
                    daywise.day1!.day,
                    daywise.day1!.condition!.icon,
                    daywise.day1!.dailyChanceOfRain,
                    daywise.day1!.maxtempC,
                    daywise.day1!.avghumidity,
                    daywise.day1!.maxwindKph,
                    daywise.day1!.condition!.text,
                    context),
                daywiseWeather(
                    daywise.day2!.day,
                    daywise.day2!.condition!.icon,
                    daywise.day2!.dailyChanceOfRain,
                    daywise.day2!.maxtempC,
                    daywise.day2!.avghumidity,
                    daywise.day2!.maxwindKph,
                    daywise.day2!.condition!.text,
                    context),
                daywiseWeather(
                    daywise.day3!.day,
                    daywise.day3!.condition!.icon,
                    daywise.day3!.dailyChanceOfRain,
                    daywise.day3!.maxtempC,
                    daywise.day3!.avghumidity,
                    daywise.day3!.maxwindKph,
                    daywise.day3!.condition!.text,
                    context),
                daywiseWeather(
                    daywise.day4!.day,
                    daywise.day4!.condition!.icon,
                    daywise.day4!.dailyChanceOfRain,
                    daywise.day4!.maxtempC,
                    daywise.day4!.avghumidity,
                    daywise.day4!.maxwindKph,
                    daywise.day4!.condition!.text,
                    context),
                daywiseWeather(
                    daywise.day5!.day,
                    daywise.day5!.condition!.icon,
                    daywise.day5!.dailyChanceOfRain,
                    daywise.day5!.maxtempC,
                    daywise.day5!.avghumidity,
                    daywise.day5!.maxwindKph,
                    daywise.day5!.condition!.text,
                    context),
                daywiseWeather(
                    daywise.day6!.day,
                    daywise.day6!.condition!.icon,
                    daywise.day6!.dailyChanceOfRain,
                    daywise.day6!.maxtempC,
                    daywise.day6!.avghumidity,
                    daywise.day6!.maxwindKph,
                    daywise.day6!.condition!.text,
                    context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding daywiseWeather(
      day, icon, rain, temp, wind, humidity, condition, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  color: Colors.grey.shade400)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  Stxt(
                    text: "${day}",
                    size: f3,
                    color: Theme.of(context).primaryColor,
                    weight: FontWeight.w600,
                  ),
                  Image.network(
                    "https:${icon}",
                    width: 45,
                  ),
                ],
              ),
              Space(16),
              Column(
                children: [
                  Stxt(
                    text: "W/sp",
                    size: f3,
                    color: Theme.of(context).primaryColor,
                    weight: FontWeight.w600,
                  ),
                  Space(16),
                  Stxt(text: "${wind}kph", size: f3),
                ],
              ),
              Space(16),
              Column(
                children: [
                  Stxt(
                    text: "Rain",
                    size: f3,
                    color: Theme.of(context).primaryColor,
                    weight: FontWeight.w600,
                  ),
                  Space(16),
                  Stxt(text: "${rain}%", size: f3),
                ],
              ),
              Space(16),
              Column(
                children: [
                  Stxt(
                    text: "Avg/h",
                    size: f3,
                    color: Theme.of(context).primaryColor,
                    weight: FontWeight.w600,
                  ),
                  Space(16),
                  Stxt(text: "${humidity}%", size: f3),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    "${temp}\u00B0",
                    style: TextStyle(
                        fontSize: 30, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(width: 100,child: Stxt(text: "${condition}", size: f2,textAlign: TextAlign.center,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
