import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/specialdayspage/model/special_days_model.dart';

import '../../../rest_call_controller/rest_call_controller.dart';

class SpecialdayspageController extends GetxController {
  //TODO: Implement SpecialdayspageController

  final count = 0.obs;
  RxBool isLoadings0 = false.obs;
  final _restCallController = Get.put(restCallController());
  var getspecialdays = SpecialDaysModel().obs;
  RxString dropDownvalue = "This Year".obs;
  RxString dropDownvalue1="Next Year".obs;



  @override
  void onInit() {
    specialDays('2023');
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

  specialDays(index) async {
    isLoadings0.value = true;
    var header = """
query Get_Holy_days(\$year: String) {
  Get_Holy_days(year: \$year) {
    holydays_name
    arabic_date
    english_date
    date_
    day
    month_
    year_
  }
}
    """;

    var body = {
      "year": "$index"

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data days ${json.encode(res)}");
    isLoadings0.value = false;
    getspecialdays.value = specialDaysModelFromJson(json.encode(res));
    update();
  }
}
