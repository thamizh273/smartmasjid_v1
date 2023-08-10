import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';

import '../model/noticationModel.dart';

class NotificationpageController extends GetxController {
  //TODO: Implement NotificationpageController
 RxBool isloading=false.obs;
 final _restCallController = Get.put(restCallController());

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
query Get_Notification_Log(\$userId: ID!) {
  Get_Notification_Log(user_id: \$userId) {
    createdAt
    description
    id
    masjid_id {
      id
      masjid_image
      masjid_name
    }
    notification_message
    notification_type
    read_status_
    updatedAt
    user_id {
      id
      first_name
    }
  }
}
    """;
    var body ={
      "userId": "5b52cef8-1c88-48ac-bd76-a092cd5ad200"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;

    notificationData.value=notificationModelFromJson(json.encode(res));
    print("getnotification");
    log(json.encode(res));
    print("getnotification");

  }
}
