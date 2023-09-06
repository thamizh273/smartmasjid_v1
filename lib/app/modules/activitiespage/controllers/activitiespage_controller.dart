import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../model/transactionHistoryModel.dart';

class ActivitiespageController extends GetxController {

  final _restCallController = Get.put(restCallController());
  final homectrl= Get.find<HomeController>();

  RxBool isloadingtrans=false.obs;
  var tansactionHistoryData=TransactionHistoryModel().obs;
  @override
  void onInit() {
    get_Transaction_History();
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
  get_Transaction_History() async {
    isloadingtrans.value=true;
    var header="""
query Get_Transaction_History(\$userId: ID!) {
  Get_Transaction_History(user_id: \$userId) {
    id
    process_date
    receiver_name
    transaction_amount
    transaction_message
    transaction_type
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}"
    };

    var res = await  _restCallController.gql_query(header, body);
    isloadingtrans.value=false;

    tansactionHistoryData.value=transactionHistoryModelFromJson(json.encode(res));

    // print("gettrans");
    // log(json.encode(res));
    // print("gettrans");
  }
}
