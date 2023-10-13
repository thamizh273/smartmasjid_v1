import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/membership_view.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';

import '../../../routes/app_pages.dart';
import '../controllers/membership_controller.dart';

class PaymentMethodM extends StatefulWidget {
  PaymentMethodM({super.key});

  @override
  State<PaymentMethodM> createState() => _PaymentMethodMState();
}

class _PaymentMethodMState extends State<PaymentMethodM> {
  final MembershipController membrCtrl = Get.put(MembershipController());



  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    membrCtrl.upiIndia_.value.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        membrCtrl.apps = value;
      });
    }).catchError((e) {
      membrCtrl.apps = [];
    });
    super.initState();
  }



  Widget displayUpiApps() {
    if (membrCtrl.apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (membrCtrl.apps!.isEmpty) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: membrCtrl.apps!.map<Widget>((UpiApp app) {
            return GestureDetector(
              onTap: () async {
              await  membrCtrl.Pay_Membership_Payment_Gate_Way(app);
              setState(() {

              });
              },
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: SizedBox(
                  height: 120,
                  width: 80,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      10.verticalSpace,
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.shadowColor,
                                  blurRadius: .2,
                                  spreadRadius: .5)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: MemoryImage(
                                  app.icon,
                                ))),
                      ),
                      5.verticalSpace,
                      Stxt(
                        text: "${app.name}",
                        size: f2,
                        weight: FontWeight.bold,
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  Future<void> _checkTxnStatus(String status, String txnId) async {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
       await membrCtrl.membershipUpiPayment(status, txnId);
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        await membrCtrl.membershipUpiPayment(status, txnId);
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        toast(error: "Failure", msg: "Transaction Failed");
        print('Transaction Failed');
        break;
      default:
        toast(error: "Failed", msg: "Something went wrong, Try again");
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
                body,
                style: value,
              )),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> methods = const [
    {
      'value': 'upi',
      'name': 'UPI Payment',
      'assets': ['gpay', 'paytm', 'phonepe'],
      'enable': true,
      'val': 0
    },
    {
      'value': 'card',
      'name': 'Credit/Debit Card',
      'assets': ['visa', 'mastercard'],
      'val': 1
    },
    {'value': 'net_banking', 'name': 'Net Banking', 'assets': [], 'val': 2},
    {'value': 'cash', 'name': 'Cash', 'assets': [], 'val': 3},
    {'value': 'wallwt', 'name': 'Wallet', 'assets': [], 'val': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "payment".tr,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              15.verticalSpace,
              ...methods.map((e) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
                  height: 80.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: e['enable'] == true ? Colors.white : Colors.white
                          .withOpacity(.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        e['enable'] == true ? BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 4,
                            offset: Offset(0, 4),
                            color:Get.theme.shadowColor) : BoxShadow()
                      ]),
                  child: Row(
                    children: [
                      Space(8),
                      Obx(() {
                        return Transform.scale(
                            scale: 1.3,
                            child: Radio(
                                activeColor: Get.theme.primaryColor,
                                // title: Text("Amiri"),
                                value: e['val'],
                                groupValue: membrCtrl.selectedRadioIndex.value,
                                onChanged: (groupValue) =>
                                e['enable'] == true ? membrCtrl
                                    .setSelectedRadio(groupValue!) : null));
                      }),
                      Space(8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stxt(
                            text: e['name'].toString(),
                            size: f4,
                            weight: FontWeight.bold,
                            color: Get.theme.primaryColor,
                          ),
                          Space(8),
                          Wrap(
                              spacing: 16,
                              children: List.generate(e['assets'].length, (i) {
                                final asset = e['assets'][i];
                                return Image.asset(
                                  'assets/images/$asset.png',
                                  height: 20,
                                );
                              })),
                        ],
                      )
                    ],
                  ),
                );
              }),
              10.verticalSpace,
              ElevatedButton(
                  onPressed: () {

                    Get.bottomSheet(
                      backgroundColor: Get.theme.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      displayUpiApps(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                    foregroundColor: Color(0xff11323B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4.0,
                  ),
                  child: Text(
                    "pay_now".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  )),
              10.verticalSpace,
              FutureBuilder(
                future: membrCtrl.transaction_,
                builder: (BuildContext context,
                    AsyncSnapshot<UpiResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          _upiErrorHandler(snapshot.error.runtimeType),
                          style: header,
                        ), // Print's text message on screen
                      );
                    }

                    UpiResponse _upiResponse = snapshot.data!;
                    String txnId = _upiResponse.transactionId ?? 'N/A';
                    String resCode = _upiResponse.responseCode ?? 'N/A';
                    String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                    String status = _upiResponse.status ?? 'N/A';
                    String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                    _checkTxnStatus(status, txnId);
                    //  print('trans  $status');
                    //    if(status=="SUCCESS"){
                    // membrCtrl.membershipUpiPayment("dfghj","dfghj");
                    //    }
                    //
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // displayTransactionData('Transaction Id', txnId),
                          // displayTransactionData('Response Code', resCode),
                          // displayTransactionData('Reference Id', txnRef),
                          displayTransactionData(
                              'Status', status.toUpperCase()),
                          // displayTransactionData('Approval No', approvalRef),
                        ],
                      ),
                    );
                  } else
                    return Center(
                      child: Text(''),
                    );
                },
              ),
            ],
          ),
        ));
  }
}
