import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../model/membershipDetailModel.dart';

class MembershipController extends GetxController {
  //TODO: Implement MembershipController
  final _restCallController = Get.put(restCallController());
  final homectrl= Get.find<HomeController>();
  var membershipDetailData=MembershipDetailModel().obs;
  RxBool isloading = false.obs;
  RxBool switchValue = false.obs;
  String? value;
  final isChecked = false.obs;
  final isCheckeddue = false.obs;
  final isCheckedother = false.obs;
  var fontFamily = "upi".obs;


  @override
  void onInit() {
    getMembershipDetails();
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


  getMembershipDetails() async {

    isloading.value=true;
    var header="""
query Query(\$userId: String!) {
  Get_Membership_Detail(user_id_: \$userId) {
    masjid_id {
      id
      masjid_name
    }
    membershipid
    month_chart {
      amount
      payment_month
      payment_status
    }
   
    current_payment {
      amount
      payment_month
      payment_status
      expire_date
    }
    user_id {
      id
      first_name
      user_unique_id
      phone_number
    }
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;

    membershipDetailData.value=membershipDetailModelFromJson(json.encode(res));

    print("getMEBER");
    log(json.encode(res));
    print("getMEBER");
  }



}
