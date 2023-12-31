
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/payment_method.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import '../controllers/membership_controller.dart';

class SelectMonth extends StatelessWidget {
  SelectMonth({super.key});

  final memcntrl = Get.put(MembershipController());

  final Stxt paid1 = Stxt(
    text: "Paid",
    size: f2,
    weight: FontWeight.w500,
  );
  final Stxt unpaid1 = Stxt(
    text: "Unpaid",
    size: f2,
    weight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "select_month".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stxt(
              text:
              "you_unpaid".tr,
              size: f2,
              textAlign: TextAlign.center,
              weight: FontWeight.w500,
            ),
            30.verticalSpace,
            Obx(() {
              return memcntrl.isloadingPay.value
                  ? DialogHelper.showLoading()
                  : Expanded(
                    child: GridView.builder(

                      // physics: NeverScrollableScrollPhysics(),
                        itemCount: memcntrl.membershipPaymentMonthData.value
                            .membershipPayments!.monthList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery
                              .of(context)
                              .orientation ==
                              Orientation.landscape
                              ? 3
                              : 3,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 180.w / 160.h,
                        ),
                        itemBuilder: (context,
                            index,) {
                          var data = memcntrl.membershipPaymentMonthData.value
                              .membershipPayments!.monthList![index];

                          return IgnorePointer(
                            ignoring:memcntrl.checkboxignore.value==true? true:data.paymentStatus=='paid'?true:false,

                            child: GestureDetector(
                              onTap: (){
                                memcntrl.checkedStates[index] =
                                !memcntrl.checkedStates[index];
                                print(" ${memcntrl
                                    .checkedStates[index]}");

                                memcntrl.update();
                                if (memcntrl.checkedStates[index]) {
                                  memcntrl.totalPayment.value +=
                                      int.parse(data.amount!);

                                  memcntrl.listofmonthPay.add(data.monthDue.toString());
                                } else {
                                  memcntrl.totalPayment.value -=
                                      int.parse(data.amount!);
                                  memcntrl.listofmonthPay.remove(data.monthDue.toString());
                                }

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 180.w,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Stxt(
                                              text: DateFormat('MMM y').format(DateTime.parse("${data.monthDue!}").toLocal()),
                                              size: f2,
                                              weight: FontWeight.w500,
                                              color: Get.theme.primaryColor,
                                            ),
                                            data.paymentStatus == 'paid'
                                                ? Container()
                                                : Transform.scale(
                                              scale: 0.7.r,
                                              child: Container(
                                                height: 18.h,
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Obx(() {
                                                  return IgnorePointer(
                                                    child: Checkbox(
                                                      focusColor: Get.theme.primaryColor,
                                                      activeColor:
                                                      Get.theme.primaryColor,
                                                      checkColor: Colors.white,
                                                      value: memcntrl
                                                          .checkedStates[index],
                                                      onChanged: (value) {

                                                      },
                                                    ),
                                                  );
                                                }),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stxt(
                                            text: "₹ ${data.amount}",
                                            size: f3,
                                            weight: FontWeight.w600,
                                            color: Get.theme.primaryColor,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Stxt(text: data.paymentStatus == 'paid'
                                              ? "Paid"
                                              : "UnPaid", size: f2, color: Get.theme.primaryColor,),
                                          Space(8),
                                          SvgPicture.asset(
                                              "assets/svg/${data.paymentStatus}.svg",
                                              width: f2.w)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
            }),

            GestureDetector(
              onTap: (){
                if(memcntrl.totalPayment.value==0)
                  return toast(error: "Message", msg: "Please Select atleast 1 month");
                memcntrl.transaction_=null;
                Get.to(() =>PaymentMethodM());


              },
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                          color: Get.theme.shadowColor
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stxt(text: "pay_membership_of".tr,
                      size: f3,
                      weight: FontWeight.w500,
                      color: Colors.white,),
                    Space(8),
                    Obx(() {


                      return Stxt(text: "₹ ${memcntrl.membershipPaymentMonthData.value.membershipPayments!.totalAmountPay??memcntrl.totalPayment.value}",
                        size: f4,
                        weight: FontWeight.w600,
                        color: Colors.white,);
                    }),
                   10.horizontalSpace,
                    Icon(Icons.send, color: Colors.white, size: 25,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
