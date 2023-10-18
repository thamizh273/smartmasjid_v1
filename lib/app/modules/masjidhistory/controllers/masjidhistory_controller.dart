

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/masjid_facility_model.dart';
import '../model/masjid_gallery_model.dart';

class MasjidhistoryController extends GetxController {
  //TODO: Implement MasjidhistoryController

  final count = 0.obs;
    final _restCallController = Get.put(restCallController());
  RxBool isLoadings0 = false.obs;
  RxBool isLoadings1 = false.obs;
  var getmasjidfacility = MasjidFacilityModel().obs;
  var getmasjidgallery = MasjidGalleryModel().obs;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  void onInit() {
    masjidFacilities();
     masjidGallery();
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

  Future<void> refreshData() async {
    // Simulating an API request or data refresh
    await  Future.delayed(const Duration(seconds: 2));
    await masjidFacilities();
    await masjidGallery();
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
    //log("data facility ${json.encode(res)}");
    isLoadings0.value = false;
    getmasjidfacility.value = masjidFacilityModelFromJson(json.encode(res));
    update();
  }

  masjidGallery() async {
    isLoadings1.value = true;
    var header = """
query Get_Masjid_Gallery_Images(\$masjidId: ID!, \$userId: String) {
  Get_Masjid_Gallery_Images(masjid_id: \$masjidId, user_id: \$userId) {
    Image
    masjid_id
    id
    admin_id
  }
}
    """;

    var body = {
      "masjidId": "38890dfb-5990-4dd3-ae5b-16dd3c27896e",
      "userId": "b5124d55-4a03-4375-aec6-7ef347116531"
    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    // log("data gallery ${json.encode(res)}");
    isLoadings1.value = false;

    getmasjidgallery.value = masjidGalleryModelFromJson(json.encode(res));

  }
}
