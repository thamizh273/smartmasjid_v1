
import 'package:pinput/pinput.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/membership/controllers/membership_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

class QuickPay extends StatelessWidget {
  QuickPay({super.key});

 final MembershipController membershipCtrl = Get.put(MembershipController());
 final HomeController homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "quick_pay".tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: membershipCtrl.QuickPayKey,
            child: Column(
              children: [
                const Space(16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                            color: Colors.grey.shade400)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Space(8),
                        Stxt(
                          text: "pay_memberShip".tr,
                          size: f5,
                          color: Theme
                              .of(context)
                              .primaryColor,
                          weight: FontWeight.w600,
                        ),
                        const Space(16),

                        const Space(16),

                         Row(
                          children: [
                            Text("mobile_number".tr,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),

                        Obx(() {
                          return Safa_textfield(
                            keyboardType: const TextInputType.numberWithOptions(),
                            // errorText: membershipCtrl.errorText.value.isNotEmpty
                            //     ? ""
                            //     : null,
                            fillColor: clr_white,
                            height: 40.h,
                            hint: "register_number".tr,
                            controller: membershipCtrl.payPhone_.value,
                            onChanged: (value) {

                              value != null
                                  ? membershipCtrl.paymemberId_.value.clear()
                                  : null;
                            },
                          );
                        }),
                        8.verticalSpace,

                         Text(
                          "or".tr,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        8.verticalSpace,
                         Row(
                          children: [
                            Text(
                              "membership_id".tr,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Obx(() {
                          return Safa_textfield(
                            // errorText: membershipCtrl.errorText.value.isNotEmpty
                            //     ? membershipCtrl.errorText.value
                            //     : null,
                            fillColor: clr_white,
                            height: 40.h,
                            hint: "EX: ABCD4585",
                            controller: membershipCtrl.paymemberId_.value,
                            onChanged: (value) {

                              value != null
                                  ? membershipCtrl.payPhone_.value.clear()
                                  : null;
                            },

                          );
                        }),
                        10.verticalSpace,
                        //   SButton(ontap: (){},text: "verify",color: Get.theme.primaryColor,txtClr: clr_white),
                      ],
                    ),
                  ),
                ),
                const Space(16),
                ElevatedButton(
                    onPressed: () {
                      if (membershipCtrl.payPhone_.value.text.isEmpty&&membershipCtrl.paymemberId_.value.text.isEmpty) {
                       return toast(error: "Error", msg: "Required any one field");
                      }
                      membershipCtrl.paymemberId_.value.text.length==0? membershipCtrl.membershipPayment(
                          "onemonth", false,"+${membershipCtrl.payPhone_.value.text}"): membershipCtrl.membershipPayment(
                          "onemonth", false,"${membershipCtrl.paymemberId_.value.text}");

                      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentMethod()));
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
                      "pay_now".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
