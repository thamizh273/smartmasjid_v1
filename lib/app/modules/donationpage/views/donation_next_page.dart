import 'dart:convert';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/paymentsmethods.dart';

import '../../membership/views/payment_method.dart';
import '../controllers/donationpage_controller.dart';

class DonationAmount extends StatelessWidget {
  DonationAmount({super.key, required this.index, required this.ago});

  final int index;
  final int ago;
  final donationamount_ctrl = Get.put(DonationpageController());
  final PaymentMethodsController ctxs=Get.put(PaymentMethodsController());
  @override
  Widget build(BuildContext context) {
    var theme = Get.theme;
    var data =
        donationamount_ctrl.donationgetData.value.getMasjidDonations![index];
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "donation".tr,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data.image == null
                  ? SizedBox()
                  : Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: MemoryImage(
                                  base64Decode(data.image.toString())))),
                    ),
              16.verticalSpace,
              Row(
                children: [
                  Stxt(
                    text: "${data.donationTitle}",
                    size: f5,
                    weight: FontWeight.w500,
                  ),
                  Spacer(),
                  Stxt(
                    text: "$ago days left",
                    size: f1,
                    color:Get.theme.hoverColor.withOpacity(0.5),
                  ),
                ],
              ),
              4.verticalSpace,
              Stxt(
                text: "${data.donationType}",
                size: f3,
                weight: FontWeight.w400,
              ),
              16.verticalSpace,
              Stxt(
                text: "₹${data.donationRaisedAmount!.round()}",
                size: f5,
                weight: FontWeight.w600,
                color: Get.theme.hoverColor,
              ),
              16.verticalSpace,
              LinearPercentIndicator(
                lineHeight: 10,
                barRadius: Radius.circular(5.r),
                percent: (data.percentCalculation! / 100).toDouble(),
                progressColor: Get.theme.primaryColor,
                trailing: Stxt(
                  text: '${data.percentCalculation}%',
                  size: f1,
                ),
              ),
              8.verticalSpace,
              Row(
                children: [
                  Stxt(
                    text: "₹${data.collectionAmount!.round()}",
                    size: f3,
                    weight: FontWeight.w500,
                    color: Get.theme.hoverColor,
                  ),
                  Spacer(),
                  Stxt(
                    text: "₹${data.neededAmount!.round()}",
                    size: f3,
                    weight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
              16.verticalSpace,
              Image.asset("assets/images/charity.png"),
              16.verticalSpace,
              Stxt(
                text:
                    "this_fund_raised_by_your_masjid_so_your_donate_amount_will_be_settled_to_your_masjid"
                        .tr,
                size: f2,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              Safa_textfield(
                keyboardType: TextInputType.number,
                controller: donationamount_ctrl.amountxtD.value,
                hint: 'enter_amount'.tr,
                fillColor: clr_white,
                onChanged: (value) {
                  donationamount_ctrl.amount.value=value!;
                },
              ),
              Space(8),
              Row(
                children: [
                  Stxt(
                    text: "suggested".tr,
                    size: f4,
                    color: Get.theme.hoverColor,
                    weight: FontWeight.w500,
                  ),
                  8.horizontalSpace,
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.hoverColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Stxt(text: "200", size: f3),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.hoverColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Stxt(text: "500", size: f3),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.hoverColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Stxt(text: "1000", size: f3),
                      ),
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if(donationamount_ctrl.amount.value.isNotEmpty){
                          ctxs.receiverName.value=data.masjidId!.masjidName.toString();
                          ctxs.amount.value=double.parse(donationamount_ctrl.amount.value);
                          Get.to(PaymentsMethods(controllerMethod: () { donationamount_ctrl.donationPayment(); },  controllerMethod2: donationamount_ctrl.donationPaymentsuccess));
                          return;
                        }
                        toast(error: "Hint", msg: "Enter Amount");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        foregroundColor: const Color(0xff11323B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4.0,
                      ),
                      child:  Text(
                        "donate_now".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      )),
              )
            ],
          ),
        ),
      ),
    );
  }
}


