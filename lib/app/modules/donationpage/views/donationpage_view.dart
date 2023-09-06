import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smartmasjid_v1/app/modules/donationpage/views/donation_next_page.dart';
import 'package:smartmasjid_v1/app/modules/donationpage/views/past_payments.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../controllers/donationpage_controller.dart';

class DonationpageView extends GetView<DonationpageController> {
  const DonationpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "donation".tr,
          action: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => PastPayments()));
                },
                child: SvgPicture.asset("assets/svg/pastdonation.svg")),
            Space(20),
          ],
        ),
        body: Obx(() {
          return controller.isloadingDona.value
              ? loading(context)
              : Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      15.verticalSpace,
                      Image.asset("assets/images/donatead.png"),
                      Space(16),
                      Stxt(
                        text:
                            "your_masjid_raises_these_funds,_So_these_are_all_will_be_settled_to_your_masjid."
                                .tr,
                        size: f2,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w500,
                      ),
                      Space(16),
                      Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.donationgetData.value
                                .getMasjidDonations!.length,
                            itemBuilder: (context, index) {
                              var data = controller.donationgetData.value
                                  .getMasjidDonations![index];

                           var givenDate = DateTime.parse(data.expiryDate.toString()).toLocal();
                              DateTime currentDate = DateTime.now();
                              Duration difference = givenDate.difference(currentDate);
                              int daysAgo = difference.inDays;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => DonationAmount(
                                            index: index, ago: daysAgo,
                                          )));
                                },
                                child: Padding(
                                  padding:
                                       EdgeInsets.only(top: 8.h,),
                                  child: Container(
                                    height: 95.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                        color: Colors.white),

                                    // data.image==null?MemoryImage(base64Decode(data.image.toString())) :
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            margin: EdgeInsets.all(5.sp),
                                            height: 80.h,

                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                image: data.image == null
                                                    ? DecorationImage(
                                                        image: AssetImage(
                                                          "assets/images/masjidselc.png",
                                                        ),
                                                        fit: BoxFit.cover,)
                                                    : DecorationImage(
                                                    fit: BoxFit.cover,
                                                        image: MemoryImage(
                                                            base64Decode(data
                                                                .image
                                                                .toString())))
                                            ),
                                          ),
                                        ),
                                        5.horizontalSpace,
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Stxt(
                                                    text:
                                                        "${data.donationTitle}",
                                                    size: f3,
                                                    weight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),

                                                  Stxt(
                                                    text: "$daysAgo days left",
                                                    size: f1,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                ],
                                              ),
                                              Space(8),
                                              Stxt(
                                                text: "${data.donationType}",
                                                size: f2,
                                                weight: FontWeight.w400,
                                              ),
                                              Space(8),
                                              Stxt(
                                                text:
                                                    "Raised ₹ ${data.collectionAmount!.round()} of ${data.donationRaisedAmount!.round()}",
                                                size: f3,
                                                weight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Space(8),

                                              LinearPercentIndicator(padding: EdgeInsets.symmetric(horizontal: 3),barRadius: Radius.circular(2),percent:(data.percentCalculation!/100).toDouble(),progressColor: Get.theme.primaryColor,trailing:Stxt(text: '${data.percentCalculation}%', size: f1,),)
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10.w),
                                              height: 100.h,

                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.horizontal(right: Radius.circular(9.r)),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              child: Center(
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
        }));
  }
}
