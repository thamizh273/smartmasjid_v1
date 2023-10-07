import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../model/masjid_facility_model.dart';

class MasjidhistoryController extends GetxController {
  //TODO: Implement MasjidhistoryController

  final count = 0.obs;
    final _restCallController = Get.put(restCallController());
  RxBool isLoadings0 = false.obs;
  var getmasjidfacility = MasjidFacilityModel().obs;
  @override
  void onInit() {
    masjidFacilities();
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

  masjidFacilities() async {
    isLoadings0.value = true;
    var header = """
query Get_Masjid_Facilities_List(\$masjidId: ID!, \$type: String) {
  Get_Masjid_Facilities_List(masjid_id: \$masjidId, type_: \$type) {
    id
    facility_title
    name_list {
      id
      facility_name
      facility_status
    }
  }
}
    """;

    var body = {
      "masjidId": "38890dfb-5990-4dd3-ae5b-16dd3c27896e",
      "type": "user"

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data facility ${json.encode(res)}");
    isLoadings0.value = false;
    getmasjidfacility.value = masjidFacilityModelFromJson(json.encode(res));
    update();
  }
}
