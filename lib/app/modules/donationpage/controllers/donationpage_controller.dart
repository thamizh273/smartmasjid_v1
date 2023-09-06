import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../model/donation_model.dart';

class DonationpageController extends GetxController {
  //TODO: Implement DonationpageController
  final _restCallController = Get.put(restCallController());
  final homectrl= Get.find<HomeController>();
  var donationgetData=MasjidDonationsModel().obs;

 RxBool isloadingDona=true.obs;
  var fontFamily = "upi".obs;
  @override
  void onInit() {
    getDonation();
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


  getDonation() async {
    isloadingDona.value=true;
    var header="""
query Get_Masjid_Donations(\$userId: ID!) {
  Get_Masjid_Donations(user_id_: \$userId) {
    collection_amount
    currency_type
    donation_raised_amount
    donation_title
    donation_type
    expiry_date
    fundraiser {
      id
      first_name
    }
    id
    masjid_id {
      id
      masjid_name
    }
    needed_amount
    percent_calculation
    start_date
    image
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}"
    };

    var res = await  _restCallController.gql_query(header, body);
    isloadingDona.value=false;

    donationgetData.value=masjidDonationsModelFromJson(json.encode(res));

    print("gettrans");
    log(json.encode(res));
    print("gettrans");
  }
}
