import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';

import '../controllers/membership_controller.dart';

class PaymentMethodM extends StatefulWidget {
  PaymentMethodM({super.key});

  @override
  State<PaymentMethodM> createState() => _PaymentMethodMState();
}

class _PaymentMethodMState extends State<PaymentMethodM> {
  final MembershipController c = Get.put(MembershipController());
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

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
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "9514786166@ybl",
        receiverName: 'Thamizhselvan',
        transactionRefId: DateTime.now().millisecondsSinceEpoch.toString(),
        transactionNote: '',
        amount: 1,
        merchantId: '');
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty) {
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
          children: apps!.map<Widget>((UpiApp app) {
            return GestureDetector(
              onTap: () {
                _transaction = initiateTransaction(app);
                setState(() {});
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
                                  color: clr_gray,
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

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
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
      'val':0
    },
    {
      'value': 'card',
      'name': 'Credit/Debit Card',
      'assets': ['visa', 'mastercard'],
      'val':1
    },
    {'value': 'net_banking', 'name': 'Net Banking', 'assets': [],'val':2},
    {'value': 'cash', 'name': 'Cash', 'assets': [], 'enable': true,'val':3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "Payment",
        ),
        body: Column(
          children: [
            15.verticalSpace,
            ...methods.map((e) {
             
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                          color: Colors.grey.shade400)
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
                              groupValue: c.selectedRadioIndex.value,
                              onChanged: (groupValue) =>
                                  c.setSelectedRadio(groupValue!)));
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
            SButton(
                ontap: () {
                  Get.bottomSheet(
                    backgroundColor: clr_white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                       displayUpiApps(),
                  );
                },
                text: "Pay Now",
                color: Get.theme.primaryColor,
                txtClr: clr_white)
          ],
        ));
  }
}
