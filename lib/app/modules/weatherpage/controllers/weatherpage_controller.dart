import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../model/weather_model.dart';

class WeatherpageController extends GetxController {
  final count = 0.obs;
  RxInt _currentPage = 0.obs;
  int currentPage = 0;
  late String bgImg;
  _onPageChanged(int index){
    currentPage = index;
  }
  RxBool isLoadings1 = false.obs;
  RxBool isLoadings = false.obs;
  final _restCallController = Get.put(restCallController());
  var getweatherdata = WeatherModel().obs;

  @override
  void onInit() {
    weatherList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  weatherList() async {
    isLoadings1.value = true;
    var header = """
query Get_Weather_Report(\$cityName: String) {
  Get_Weather_Report(city_name: \$cityName) {
    location {
      region
      country
      localtime
    }
    current_weather_data {
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_1 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_2 {
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_3 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_4 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_5 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_6 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_7 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_8 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
      maxwind_mph
    }
    day_9 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    day_10 {
      date
      day
      maxtemp_c
      maxtemp_f
      mintemp_c
      mintemp_f
      maxwind_mph
      maxwind_kph
      avghumidity
      daily_chance_of_rain
      condition {
        text
      }
    }
    hijri_date
  }
}
    """;

    var body = {
      "cityName": "pondicherry"
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("ddddd ${json.encode(res)}");
    isLoadings1.value = false;
    getweatherdata.value = weatherModelFromJson(json.encode(res));
    update();
  }
}
