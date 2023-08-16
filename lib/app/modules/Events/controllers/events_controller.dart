import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../Model/eventsModel.dart';

class EventsController extends GetxController {
  final _restCallController = Get.put(restCallController());
  //TODO: Implement EventsController
 RxBool isloading=false.obs;
 var eventsData= EventsModel().obs;
  @override
  void onInit() {
    // getUpcomingEvents();
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
//   getUpcomingEvents() async {
//
//     isloading.value=true;
//     var header="""
// query Query(\$masjidId: ID!) {
//   Get_Masjid_Events_(masjid_id: \$masjidId) {
//     image
//     id
//     area
//     start_time
//     end_time
//     masjid_id {
//       masjid_name
//     }
//     title
//     description
//   }
// }
//     """;
//     var body ={
//       "masjidId": "38890dfb-5990-4dd3-ae5b-16dd3c27896e"
//     };
//     var res = await  _restCallController.gql_query(header, body);
//     isloading.value=false;
//
//     eventsData.value=eventsModelFromJson(json.encode(res));
//     print("getevent");
//     log(json.encode(res));
//     print("getevent");
//
//   }
}
