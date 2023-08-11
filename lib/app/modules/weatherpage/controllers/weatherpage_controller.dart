import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/weatherTest.dart';
import 'package:http/http.dart' as http;

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
  RxBool isLoadings1 = false.obs;
  final _restCallController = Get.put(restCallController());
  var getweatherdata = WeatherModel().obs;
  var getweathertest= Weathertest().obs;
  //var getdistictdata = DistrictModel().obs;
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
  void onInit() async {
   await fetchWeather();
   await weatherList();

    //districtList();
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

  final baseUrl = "https://weatherapi-com.p.rapidapi.com/current.json";
  final Location locationw = Location();
  Future<Map<String, dynamic>> fetchWeather() async {


    LocationData? locationData;
    try {
      isLoadings.value=true;
      locationData = await locationw.getLocation();
    } catch (e) {
      print('Error getting location: $e');
    }
   // final url = "$baseUrl?q=$latitude%2C$longitude";

    if (locationData != null) {

      final url =
          "$baseUrl?q=${locationData.latitude}%2C${locationData.longitude}";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "X-RapidAPI-Key": "e35a8f4fa1mshb0e4eff4d111061p12d232jsn6584eb87f9b1",
          "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
        },
      );
      if (response.statusCode == 200) {

        final Map<String, dynamic> data = json.decode(response.body);

        isLoadings.value=false;
        print("${json.encode(data)}");
        getweathertest.value=weathertestFromJson(json.encode(data));
        return data;

      } else {
        throw Exception('Failed to fetch weather data');
      }

    } else {
      throw Exception('Location data is null');
    }}



  weatherList() async {
    isLoadings1.value = true;
    var header = """
query Query(\$latitude: String!, \$longitude: String!) {
  Get_Weather_Report_Future_Date(latitude: \$latitude, longitude: \$longitude) {
    day_1 {
      date
      day
      daily_chance_of_rain
      maxtemp_c
      condition {
        text
        icon
      }
      avghumidity
      maxwind_kph
    }
    day_2 {
      daily_chance_of_rain
      date
      day
      maxtemp_c
      condition {
        text
        icon
      }
      avghumidity
      maxwind_kph
    }
    day_4 {
      daily_chance_of_rain
      date
      day
      maxtemp_c
      condition {
        text
        icon
      }
      avghumidity
      maxwind_kph
    }
    day_5 {
      daily_chance_of_rain
      date
      day
      maxtemp_c
      condition {
        text
        icon
      }
      avghumidity
      maxwind_kph
    }
    day_6 {
      daily_chance_of_rain
      date
      day
      maxtemp_c
      condition {
        text
        icon
      }
      avghumidity
      maxwind_kph
    }
    hijri_date
    today_ {
      date
      day
      humidity
      temp_c
      condition {
        text
        icon
      }
      wind_dir
      wind_kph
    }
    day_3 {
      condition {
        text
        icon
      }
      daily_chance_of_rain
      date
      day
      maxtemp_c
      avghumidity
      maxwind_kph
    }
  }
}
    """;

    var body = {  "latitude": "11.9416",
      "longitude": "79.8083"
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
  log("ddddd ${json.encode(res)}");
   // fetchWeather(11.916064,79.812325);
    isLoadings1.value = false;
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
    //getdistictdata.value = districtModelFromJson(json.encode(res));
    update();
  }
}
