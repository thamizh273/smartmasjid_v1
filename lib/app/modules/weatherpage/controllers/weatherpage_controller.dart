import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/weatherpage/model/district_model.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/weather_model.dart';

class WeatherpageController extends GetxController {
  final count = 0.obs;
  RxInt _currentPage = 0.obs;
  int currentPage = 0;
  late String bgImg;
  _onPageChanged(int index){
    currentPage = index;
  }

  RxBool isLoadings = false.obs;
  final _restCallController = Get.put(restCallController());
  var getweatherdata = WeatherModel().obs;
  var getdistictdata = DistrictModel().obs;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  RxString searchQuery = ''.obs;
  var selectedIndices = [].obs;
  RxInt selectedIndex = 1.obs;
  RxInt selectedIndex1 = 1.obs;

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
  void setSelectedIndex1(int index) {
    selectedIndex1.value = index;
  }

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  @override
  void onInit() {
    weatherList();
    districtList();
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
    isLoadings.value = true;
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
      "cityName": "puducherry",
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
   // log("ddddd ${json.encode(res)}");
    isLoadings.value = false;
    getweatherdata.value = weatherModelFromJson(json.encode(res));
    update();
  }


  districtList() async {
    isLoadings.value = true;
    var header = """
query Query(\$dummy: String) {
  Get_District_By_State(dummy_: \$dummy) {
    country_name
    state_name
    district
  }
}
    """;

    var body = {
      "dummy": ""
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data dis ${json.encode(res)}");
    isLoadings.value = false;
    getdistictdata.value = districtModelFromJson(json.encode(res));
    update();
  }
}
