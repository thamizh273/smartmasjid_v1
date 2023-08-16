import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';

import '../../../rest_call_controller/rest_call_controller.dart';

import '../model/noticationModel.dart';

class NotificationpageController extends GetxController {
  //TODO: Implement NotificationpageController
 RxBool isloading=false.obs;
 final _restCallController = Get.put(restCallController());
 final _homeCtrl= Get.find<HomeController>();

  var notificationData=NotificationModel().obs;
  @override
  void onInit() {
    getNotification();
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



  getNotification() async {

    isloading.value=true;
    var header="""
query Query(\$userId: ID!) {
  Get_Notification_Log(user_id: \$userId) {
    user_id
    read_status_
    notification_type
    notification_message
    masjid_id {
      id
      masjid_name
      masjid_image
    }
    description
    createdAt
    id
  }
}
    """;
    var body ={
      "userId": "${_homeCtrl.getUserData.value.getUserById!.id}"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;

  notificationData.value=notificationModelFromJson(json.encode(res));
    print("getnotification");
    log(json.encode(res));
    print("getnotification");

  }
}
