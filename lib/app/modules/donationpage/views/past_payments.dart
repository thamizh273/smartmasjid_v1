import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../controllers/donationpage_controller.dart';


class PastPayments extends StatelessWidget {
   PastPayments({super.key});
  final donation_ctrl = Get.put(DonationpageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "past_donation".tr,
        ),
        body: Obx(() {
          return donation_ctrl.isloadingPastD.value? DialogHelper.showLoading():ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              physics: BouncingScrollPhysics(),
              itemCount: donation_ctrl.pastDonationData.value.getDonationPayList!.length,
              itemBuilder: (context, index) {
                var data=donation_ctrl.pastDonationData.value.getDonationPayList![index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.h, horizontal: 10.w),
                  child: Column(
                    children: [
                      Container(
                        height: 90.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Theme
                                .of(context)
                                .primaryColor, width: 2)
                        ),
                        child: Row(
                          children: [
                            5.horizontalSpace,
                            Expanded(
                              flex: 2,
                              child: Container(
                                  height: 75.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8.r),
                                      image: data.donationId!.image == null
                                          ? DecorationImage(
                                        image: AssetImage(
                                          "assets/images/masjidselc.png",
                                        ),
                                        fit: BoxFit.cover,)
                                          : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                              base64Decode(data.donationId!.image
                                                  .toString())))
                                  ),

                              ),
                            ),
                            6.horizontalSpace,
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Space(12),
                                  Row(

                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(flex: 2,
                                          child: Stxt(
                                              text: "${data.donationId!.donationTitle}",
                                              size: f3,
                                              weight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis)),

                                      Flexible(flex: 1,
                                          child: Stxt(text: DateFormat("dd MMM yy").format(DateTime.parse(data.paymentDate.toString())),
                                            size: f1,
                                            weight: FontWeight.w500,
                                            color: Colors.black.withOpacity(
                                                0.6),
                                            pad: EdgeInsets.symmetric(
                                                horizontal: 5.w),)),
                                    ],
                                  ),
                                  Space(6),
                                  Stxt(text: "${data.donationId!.donationType}",
                                    size: f2,
                                    weight: FontWeight.w400,),
                                  Space(8),
                                  Row(

                                    children: [
                                      Image.asset(
                                        "assets/images/tick.png", width: 16,),
                                      Space(8),
                                      Stxt(text: "₹${data.amountDonated} Donated",
                                        size: f3,
                                        weight: FontWeight.w600,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,),
                                     Spacer(),
                                      Image.asset("assets/images/download.png",
                                        width: 25,),
                                      8.horizontalSpace
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        })
    );
  }
}
