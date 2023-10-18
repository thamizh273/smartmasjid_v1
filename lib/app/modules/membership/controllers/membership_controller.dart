import 'dart:convert';
import 'dart:developer';
import 'package:upi_india/upi_india.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../home/controllers/home_controller.dart';
import '../model/PayMembershipPaymentGateWayModel.dart';
import '../model/membershipDetailModel.dart';
import '../model/membershipPayDetailModel.dart';
import '../model/membershipPaymentMonthModel.dart';
import '../model/payment_invoice_model.dart';
import '../views/payment_method.dart';
import '../views/select_month.dart';

class MembershipController extends GetxController {
  //TODO: Implement MembershipController
  final _restCallController = Get.put(restCallController());
  final homectrl= Get.find<HomeController>();
  final QuickPayKey = GlobalKey<FormState>();
  var membershipDetailData=MembershipDetailModel().obs;
  var membershipPaymentData=MembershipPayementModel().obs;
  var membershipPaymentMonthData=MembershipPaymentMonthModel().obs;
  var payMembershipPaymentGateWayData=PayMembershipPaymentGateWayModel().obs;
  var getpaymentinvoice = PaymentInvoiceModel().obs;
  Rx<TextEditingController> payPhone_ = TextEditingController().obs;
  Rx<TextEditingController> paymemberId_ = TextEditingController().obs;
  RxBool isloading = false.obs;
  RxBool isloading1 = false.obs;
  RxBool invoiceloading = false.obs;
  RxBool isloadingtrascomplete = false.obs;
  RxBool upiLoading = false.obs;
  RxBool isloadingPay = false.obs;
  RxBool switchValue = false.obs;
  RxBool checkboxignore = false.obs;
  RxBool isloadingGateway = false.obs;
  RxBool payforOthers = false.obs;

  String? value;
  final isChecked = false.obs;
  RxList checkedStates=[].obs;
  RxList listofmonthPay=[].obs;

  // Rx<FocusNode> quickpayFocusNode = FocusNode().obs;

  RxList expand = [].obs;
  RxList paid = [].obs;

  RxInt totalPayment=0.obs;

  RxInt  passindexamount=0.obs;  RxInt selectedRadioIndex = 0.obs;
  RxString dropDownvalue="This Year".obs;
  void setSelectedRadio(int index) {
    selectedRadioIndex.value = index;
  }

  @override
  void onInit() {
    getMembershipDetails();
    paymentInvoice();
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
    payforOthers.value=false;
    print("rrrrr ${homectrl.getUserData.value.getUserById!.id}");
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
    bulk_pay_annual
    bulk_pay_six
    bulk_pay_three
  }
}
    """;
    var body ={
      "userId": "${homectrl.getUserData.value.getUserById!.id}"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;

    membershipDetailData.value=membershipDetailModelFromJson(json.encode(res));
    update();
    refresh();
    print("getMEBER");
    log(json.encode(res));
    print("getMEBER");
  }
  getMembershipPayDetails(String type) async {

    isloading1.value=true;
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
    isloading1.value=false;

    membershipPaymentData.value=membershipPayementModelFromJson(json.encode(res));
    update();
    print("getMEBER1");
    log(json.encode(res));
    print("getMEBER1");
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
    masjid_name
    masjid_upi_id
    total_amount_pay
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
    update();
    print("getMEBER2");
    log(json.encode(res));
    print("getMEBER2");
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

  membershipUpiPayment(String status, String txnId) async {
    log("ddd1${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.id}");
    log("ddd2${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.userId}");
    log("ddd3${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.paymentId}");
    log("ddd4${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.masjidId}");
    log("ddd5${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.token}");
    log("ddd6${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.code}");
    isloadingtrascomplete.value=true;
    var header =
    """mutation Membership_Payment_GateWay_Authentication_(\$id: ID!, \$userId: String!, \$paymentId: String!, \$masjidId: String!, \$token: String!, \$code: String!, \$transactionId: String, \$status: String) {
  Membership_Payment_GateWay_Authentication_(id: \$id, user_id: \$userId, payment_id: \$paymentId, masjid_id: \$masjidId, token: \$token, code: \$code, transaction_id: \$transactionId, status: \$status) {
    amount
    expire_date
    payment_month
    payment_status
    receipt_no
  }
}""";
    var body = {  "id": "${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.id}",
      "userId": "${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.userId}",
      "paymentId": "${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.paymentId}",
      "masjidId": "${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.masjidId}",
      "token": "${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.token}",
      "code": "${payMembershipPaymentGateWayData.value.payMembershipPaymentGateWay!.code}",
      "transactionId": "$txnId",
      "status": "$status",
    };
    var res = await _restCallController.gql_mutation(header, body);
    log("message");
    log(json.encode(res));
    log("message");
    isloadingtrascomplete.value=false;

    if (res.toString().contains("SUCCESS")) {


      payforOthers.value==true? Get.close(3):    Get.close(2);
      getMembershipDetails();
      totalPayment.value=0;
      listofmonthPay.value=[];
      update();

      //Get.offAndToNamed(Routes.HOME);

      // var hh = res["SUCCESS"]["Update_User"];
      toast(error: "SUCCESS", msg: "${status}");
      // transaction_!.whenComplete(() => null);
    }

    return res;
  }
  ///new
  Future<UpiResponse>? transaction_;
  final Rx<UpiIndia> upiIndia_ = UpiIndia().obs;
  List<UpiApp>? apps;
  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return upiIndia_.value.startTransaction(
        app: app,
        receiverUpiId: "masjidenooraniyya@sbi",
        receiverName: "${membershipPaymentMonthData.value
            .membershipPayments!.masjidName}",
        transactionRefId: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        amount:totalPayment.value.toDouble(),
        merchantId: '19897398237982');
  }


  Pay_Membership_Payment_Gate_Way(UpiApp app) async {
    log("${membershipPaymentMonthData.value.membershipPayments!.userId}");
    log("${listofmonthPay}");
    log("${totalPayment.value}");
    isloadingGateway.value=true;
    var header="""
query Pay_Membership_Payment_Gate_Way(\$userId: String!, \$masjidId: String!, \$membership: String!, \$paymentId: String!, \$monthOfPay: [String!]!, \$totalAmount: Int!, \$senderId: String) {
  Pay_Membership_Payment_Gate_Way(user_id: \$userId, masjid_id: \$masjidId, membership_: \$membership, payment_id: \$paymentId, month_of_pay: \$monthOfPay, total_amount: \$totalAmount, sender_id: \$senderId) {
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
    var body ={  "userId": "${membershipPaymentMonthData.value.membershipPayments!.userId}",
      "masjidId":  "${membershipPaymentMonthData.value.membershipPayments!.masjidId}",
      "membership":  "${membershipPaymentMonthData.value.membershipPayments!.membershipid}",
      "paymentId": "${membershipPaymentMonthData.value.membershipPayments!.masjidUpiId}",
      "monthOfPay": listofmonthPay,
      "totalAmount": totalPayment.value,
      "senderId": "${homectrl.getUserData.value.getUserById!.id}"
    };

    var res = await  _restCallController.gql_query(header, body);
    isloadingGateway.value=false;

    payMembershipPaymentGateWayData.value=payMembershipPaymentGateWayModelFromJson(json.encode(res));
    log("passed");
    log(json.encode(res));
    log("passed");
    update();
    if(res.toString().contains("ERROR")){
      return toast(error: "Error", msg: "Failed");
    }else{ transaction_= initiateTransaction(app);
    Navigator.pop(Get.context!);}

    // setState(() {});

  }


  paymentInvoice() async {
    invoiceloading.value = true;
    var header = """
query View__Payment__Receipt(\$userId: ID!, \$masjidId: ID!, \$receiptNo: Float, \$type: String) {
  View__Payment__Receipt(user_id: \$userId, masjid_id: \$masjidId, receipt_no: \$receiptNo, type_: \$type) {
    amount
    bill_collector
    expire_date
    in_words_
    masjid_id {
      masjid_name
      phone_number
      pin_code
      state
      address
      area
      city
      country
      district
    }
    receipt_no
    payment_date
    user_id {
      first_name
      user_unique_id
    }
    payment_type
    payment_month
    payment_method
    secretary_
  }
}
    """;

    var body = {
      "userId": "5b52cef8-1c88-48ac-bd76-a092cd5ad200",
      "masjidId": "38890dfb-5990-4dd3-ae5b-16dd3c27896e",
      "type": "membership",
      "receiptNo": 20231141

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data invoice ${json.encode(res)}");
    invoiceloading.value = false;
    getpaymentinvoice.value = paymentInvoiceModelFromJson(json.encode(res));
    update();
  }
}