import 'dart:convert';
import 'dart:developer';

import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/paymentsmethods.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../model/donation_model.dart';
import '../model/pastDonationModel.dart';
import '../model/paymentGateWaydonation.dart';

class DonationpageController extends GetxController {
  //TODO: Implement DonationpageController
  final _restCallController = Get.put(restCallController());
  final _paymentmethodsctrl = Get.put(PaymentMethodsController());
  final homectrl= Get.find<HomeController>();
  var donationgetData=MasjidDonationsModel().obs;
  var pastDonationData=PastDonationModel().obs;
  var paymentGateWayDonationData=PaymentGateWayDonationModel().obs;
  Rx<TextEditingController> amountxtD=TextEditingController().obs;
  RxString amount="".obs;
 RxBool isloadingDona=false.obs;
 RxBool isloadingPastD=false.obs;
 RxBool isloadingdpay=false.obs;
  var fontFamily = "upi".obs;

  RxInt donationindexpass=0.obs;



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
    amount.value="";
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

    // print("gettrans");
    // log(json.encode(res));
    // print("gettrans");
  }
  donationPayment() async {
    isloadingdpay.value=true;
    var header="""
query Payment_Gate_Way_(\$userId: String!, \$id: String, \$id2: String, \$masjidId: String, \$amount: Float, \$type: String) {
  Payment_Gate_Way_(user_id_: \$userId, id__: \$id, id___2: \$id2, masjid_id: \$masjidId, amount: \$amount, type: \$type) {
    _id
    user_id
    payment_id
    merchant_id
    masjid_id
    token
    message
    code
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}",
      "id": "${donationgetData.value.getMasjidDonations![donationindexpass.value].id}",
      "id2": "${donationgetData.value.getMasjidDonations![donationindexpass.value].fundraiser!.id}",
      "masjidId": "${donationgetData.value.getMasjidDonations![donationindexpass.value].masjidId!.id}",
      "amount": int.parse(amount.value),
      "type": "donation"
    };

    var res = await  _restCallController.gql_query(header, body);
    isloadingdpay.value=false;

    paymentGateWayDonationData.value=paymentGateWayDonationModelFromJson(json.encode(res));
    _paymentmethodsctrl.masjidupid.value=paymentGateWayDonationData.value.paymentGateWay!.paymentId.toString();
    _paymentmethodsctrl.merchantid.value=paymentGateWayDonationData.value.paymentGateWay!.merchantId.toString();

    // print("gettrans");
    // log(json.encode(res));
    // print("gettrans");
  }
  donationPaymentsuccess(String status,String trans) async {

    var header="""
mutation Payment_Gate_Way_Authentication(\$id: ID!, \$userId: String!, \$paymentId: String!, \$masjidId: String!, \$token: String!, \$code: String!, \$merchantId: String, \$transactionId: String, \$status: String) {
  Payment_Gate_Way_Authentication(_id: \$id, user_id: \$userId, payment_id: \$paymentId, masjid_id: \$masjidId, token: \$token, code: \$code, merchant_id: \$merchantId, transaction_id: \$transactionId, status_: \$status) {
    amount
    masjid_id
    payment_date
    payment_status
    receipt_no
    transactionid
    user_id
  }
}
    """;
    var body ={  "id": "${paymentGateWayDonationData.value.paymentGateWay!.id}",
      "userId": "${paymentGateWayDonationData.value.paymentGateWay!.userId}",
      "paymentId": "${paymentGateWayDonationData.value.paymentGateWay!.paymentId}",
      "masjidId": "${paymentGateWayDonationData.value.paymentGateWay!.masjidId}",
      "token": "${paymentGateWayDonationData.value.paymentGateWay!.token}",
      "code": "${paymentGateWayDonationData.value.paymentGateWay!.code}",
      "status": "$status",
      "transactionId": "$trans",
      "merchantId": "${paymentGateWayDonationData.value.paymentGateWay!.merchantId}"
    };

    var res = await  _restCallController.gql_mutation(header, body);


    if (res.toString().contains("SUCCESS")) {
      getDonation();
      Get.offAndToNamed(Routes.DONATIONPAGE);

      // var hh = res["SUCCESS"]["Update_User"];
      toast(error: "SUCCESS", msg: "Successfully Donated");
    }
    // print("gettrans");
    // log(json.encode(res));
    // print("gettrans");
    return res;
  }
  getpastDonaion() async {
    isloadingPastD.value=true;
    var header="""
query Get_Donation_Pay_list(\$userId: ID!) {
  Get_Donation_Pay_list(user_id_: \$userId) {
    amount_donated
    donation_id_ {
      donation_title
      donation_type
      image
      id
    }
    payment_date
    payment_method
    id
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}"
    };

    var res = await  _restCallController.gql_query(header, body);
    isloadingPastD.value=false;

  pastDonationData.value=pastDonationModelFromJson(json.encode(res));

/*    print("getdona");
    log(json.encode(res));
    print("getdona");*/
  }
}
