import 'package:upi_india/upi_india.dart';

import '../app/modules/home/widgets/appBar.dart';
import '../app/routes/export.dart';
import '../utils/color_utils.dart';


class PaymentsMethods extends StatefulWidget {
  final VoidCallback controllerMethod;
  final Function(String status, String trans) controllerMethod2;


  PaymentsMethods(
      {required this.controllerMethod, required this.controllerMethod2});

  @override
  State<PaymentsMethods> createState() => _PaymentsMethodsState();
}

class _PaymentsMethodsState extends State<PaymentsMethods> {
  final paymentctrl = Get.put(PaymentMethodsController());
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
  ];

  void _checkTxnStatus(String status, String txnId) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        widget.controllerMethod2(status, txnId);
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        widget.controllerMethod2(status, txnId);
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

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
          Flexible(
              child: Text(
                body,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "${paymentctrl.masjidupid.value}",
        receiverName: "${paymentctrl.receiverName.value}",
        transactionRefId: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        amount: paymentctrl.amount.value,
        merchantId: '${paymentctrl.merchantid.value}');
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
          children: apps!.map<Widget>((app) {
            return GestureDetector(
              onTap: () {
                // donationamount_ctrl.donationPayment();
                _transaction = initiateTransaction(app);
                Navigator.pop(Get.context!);
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
                        color: Get.theme.primaryColor,
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

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    // TODO: implement initState
    super.initState();
  }

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
                      color: e['enable'] == true ? Colors.white : Get.theme.shadowColor
                          .withOpacity(.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        e['enable'] == true ? BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 4,
                            offset: Offset(0, 4),
                            color: Get.theme.shadowColor) : BoxShadow()
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
                                groupValue: paymentctrl.selectedRadioIndex
                                    .value,
                                onChanged: (groupValue) =>
                                e['enable'] == true ? paymentctrl
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
                    widget.controllerMethod();
                    Get.bottomSheet(
                      backgroundColor: clr_white,
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
                future: _transaction,
                builder: (BuildContext context,
                    AsyncSnapshot<UpiResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Obx(() {
                            return Text(
                              _upiErrorHandler(
                                  snapshot.error.runtimeType),
                              style: header,
                            );
                          })
                        // Print's text message on screen
                      );
                    }

                    UpiResponse _upiResponse = snapshot.data!;
                    String txnId = _upiResponse.transactionId ?? 'N/A';
                    String resCode = _upiResponse.responseCode ?? 'N/A';
                    String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                    String status = _upiResponse.status ?? 'N/A';
                    String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                    _checkTxnStatus(status, txnId);
                    print('trans  $status');
                    if (status == "FAILURE") {
                      toast(error: "FAILURE", msg: 'Transaction Failed');
                    }

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

class PaymentMethodsController extends GetxController {


  RxString receiverName = "".obs;
  RxString masjidupid = "".obs;
  RxString merchantid = "".obs;
  RxDouble amount = 0.0.obs;

  RxInt selectedRadioIndex = 0.obs;

  void setSelectedRadio(int index) {
    selectedRadioIndex.value = index;
  }

  @override
  void onInit() {
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


}