import 'dart:convert';
import 'dart:developer';


import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../../home/controllers/home_controller.dart';
import '../model/membershipDetailModel.dart';
import '../model/membershipPayDetailModel.dart';
import '../model/membershipPaymentMonthModel.dart';
import '../views/select_month.dart';

class MembershipController extends GetxController {
  //TODO: Implement MembershipController
  final _restCallController = Get.put(restCallController());
  final homectrl= Get.find<HomeController>();
  final QuickPayKey = GlobalKey<FormState>();
  var membershipDetailData=MembershipDetailModel().obs;
  var membershipPaymentData=MembershipPayementModel().obs;
  var membershipPaymentMonthData=MembershipPaymentMonthModel().obs;
  Rx<TextEditingController> payPhone_ = TextEditingController().obs;
  Rx<TextEditingController> paymemberId_ = TextEditingController().obs;
  RxBool isloading = false.obs;
  RxBool isloadingPay = false.obs;
  RxBool switchValue = false.obs;
  RxBool checkboxignore = false.obs;
  RxBool isloadingGateway = false.obs;
  String? value;
  final isChecked = false.obs;
  RxList checkedStates=[].obs;
  RxList<DataObject> dataArray = <DataObject>[].obs;
  // Rx<FocusNode> quickpayFocusNode = FocusNode().obs;

   RxList expand = [].obs;
   RxList paid = [].obs;

    RxInt totalPayment=0.obs;


  RxInt selectedRadioIndex = 0.obs;
  RxString dropDownvalue="This Year".obs;
  void setSelectedRadio(int index) {
    selectedRadioIndex.value = index;
  }
  void addDataList(List<DataObject> dataList) {
    dataArray.addAll(dataList);
  }
  @override
  void onInit() {
    getMembershipDetails();
    super.onInit();


  }

  void toggleExpansion(int index) {
    expand[index] = !expand[index];
    update(); // Notify GetX that the state has changed
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  //
  // var errorText = ''.obs;
  // void validateInput() {
  //   if (payPhone_.value.text.isEmpty&&paymemberId_.value.text.isEmpty) {
  //     errorText.value = 'Field cannot be empty';
  //     return;
  //   }else {
  //     errorText.value = '';
  //   }
  //
  // }

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

    // print("getMEBER");
    // log(json.encode(res));
    // print("getMEBER");
  }
  getMembershipPayDetails(String type) async {

    isloading.value=true;
    var header="""
query Query(\$userId: String!, \$type: String, \$status: String) {
  Get_Membership_Payment_Detail(user_id: \$userId, type_: \$type, status_: \$status) {
    amount
    expire_date
    id
    membershipid
    payment_date
    payment_method
    payment_month
    payment_status
    payment_type
    receipt_no
    transactionid
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}",
      "type": "${type}",
      "status": "paid"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;

    membershipPaymentData.value=membershipPayementModelFromJson(json.encode(res));

    // print("getMEBER");
    // log(json.encode(res));
    // print("getMEBER");
  }
  Pay_Membership_Payment_Gate_Way() async {
print(     dataArray[0]);
    isloadingGateway.value=true;
    var header="""
query Pay_Membership_Payment_Gate_Way(\$monthOfPay: [pay_log], \$userId: String!, \$masjidId: String!, \$membership: String!, \$paymentId: String!, \$totalAmount: Int!) {
  Pay_Membership_Payment_Gate_Way(month_of_pay: \$monthOfPay, user_id: \$userId, masjid_id: \$masjidId, membership_: \$membership, payment_id: \$paymentId, total_amount: \$totalAmount) {
    _id
    code
    masjid_id
    message
    payment_id
    token
    user_id
  }
}
    """;
    var body ={
      "monthOfPay": [

      ],
      "userId": "${membershipPaymentMonthData.value.membershipPayments!.userId}",
      "masjidId": "${membershipPaymentMonthData.value.membershipPayments!.masjidId}",
      "membership": "${membershipPaymentMonthData.value.membershipPayments!.membershipid}",
      "paymentId": "9677335560@paytm",
      "totalAmount": totalPayment.value
    };
    var res = await  _restCallController.gql_query(header, body);
    isloadingGateway.value=false;

   // membershipPaymentData.value=membershipPayementModelFromJson(json.encode(res));

    print("getMEBER");
    log(json.encode(res));
    print("getMEBER");
  }
  membershipPayment(String type,bool checkbox,id) async {
    print("sssssssssss $id");
    totalPayment.value=0;
    isloadingPay.value=true;
    var header="""
query Membership_Payments_(\$mobileOrMemberid: String, \$payType: String) {
  Membership_Payments_(mobile_or_memberid: \$mobileOrMemberid, pay_type: \$payType) {
    email_id
    first_name
    masjid_id
    membershipid
    month_list {
      amount
      month_due
      payment_month
      payment_status
    }
    phone_number
    user_id
  }
}
    """;
    var body ={
      "mobileOrMemberid": "${id}",
      "payType": "$type"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloadingPay.value=false;
    membershipPaymentMonthData.value=membershipPaymentMonthModelFromJson(json.encode(res));

    // print("getMEBER");
    // log(json.encode(res));
    // print("getMEBER");
    if(res.toString().contains("ERROR")){
     return toast(error: "Error", msg: "Register Mobile no/ Id Not Found");
    }


      //
      Get.to(SelectMonth());

   checkedStates.value = List.generate(
     membershipPaymentMonthData.value
          .membershipPayments!.monthList!.length,
          (index) =>checkbox,
    );
  }



}
class DataObject {
  final int amount;
  final String date_;

  DataObject({required this.amount, required this.date_});
}