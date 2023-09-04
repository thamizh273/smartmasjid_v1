import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/past_payments.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/quick_pay.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/select_month.dart';
import 'package:smartmasjid_v1/widgets/button_widget.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../controllers/membership_controller.dart';
import '../model/pdf_model/customer.dart';
import '../model/pdf_model/invoice.dart';
import '../model/pdf_model/supplier.dart';
import '../pdf_helper/pdf_helper.dart';
import '../pdf_helper/pdf_invoice_helper.dart';
import 'invoice_page.dart';
import 'invoice_pdfpage.dart';

class MembershipView extends GetView<MembershipController> {
  MembershipView({Key? key}) : super(key: key);
  HomeController homeCtrl = Get.find<HomeController>();
  List<Member> memberList = [
    Member(amount: "500", month: "Jan", image: "assets/images/download.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isloading.value
            ? loading(context)
            : Column(
                children: [
                  Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            spreadRadius: 6,
                            offset: Offset(0, 4),
                            color: Colors.grey.shade400)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(32),
                          bottomLeft: Radius.circular(32)),
                      gradient: LinearGradient(colors: [
                        hexStringToColor("53899B"),
                        hexStringToColor("23687F"),
                      ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Obx(() {
                        var data = controller
                            .membershipDetailData.value.getMembershipDetail!;
                        return Column(
                          children: [
                            Space(20),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(
                                          MaterialPageRoute(
                                              builder: (_) => HomeView()));
                                    },
                                    child: SvgPicture.asset(
                                        "assets/svg/backnew.svg")),
                                Space(16),
                                Stxt(
                                  text: "membership".tr,
                                  size: f5,
                                  weight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                           60.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stxt(
                                    text: "janab".tr,
                                    size: f5,
                                    color: Colors.white),
                                Stxt(
                                  text: "${data.userId!.firstName} ",
                                  size: f5,
                                  color: Colors.white,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stxt(
                                    text: "membership_id".tr,
                                    size: f3,
                                    color: Colors.white),
                                Stxt(
                                    text: " ${data.membershipid}",
                                    size: f3,
                                    color: Colors.white,weight: FontWeight.w500,),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  Obx(() {
                    var data = controller
                        .membershipDetailData.value.getMembershipDetail!;


                    DateTime timestamp =data.currentPayment!.expireDate=="null"?DateTime.now():DateTime.parse(data.currentPayment!.expireDate.toString());
                    DateTime currentDate = DateTime.now();
                    bool isBeforeCurrentMonth = timestamp.month < currentDate.month;
                    return Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("you_are_paying_to".tr),
                              Text(
                                " ${data.masjidId!.masjidName} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Space(8),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height: 164,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Column(
                                children: [
                                  data.currentPayment!.expireDate=="null"?14.verticalSpace:14.verticalSpace,
                                  Container(
                                   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),color: clr_gray.shade300),
                                    height: 40,width: 80,
                                    child: Center(
                                      child: Stxt(
                                        text: "₹ ${data.currentPayment!.amount} ",
                                        size: f5,
                                        weight: FontWeight.bold,textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),

                                  data.currentPayment!.expireDate=="null"?8.verticalSpace:    Stxt(
                                    pad: EdgeInsets.only(top: 6.h),
                                    text:
                                  "Membership ${isBeforeCurrentMonth ?"expired ": "valid till" } ${DateFormat('dd MMM yyyy').format(DateTime.parse("${data.currentPayment!.expireDate}").toLocal())}",
                                    size: f1,
                                    weight: FontWeight.w500,
                                    color:isBeforeCurrentMonth ? clr_red : clr_green,
                                  ),
                                 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stxt(
                                          text: "membership_auto_pay".tr,
                                          size: f4),
                                      Obx(() {
                                        return Switch(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: controller.switchValue.value,
                                          onChanged: (newValue) {
                                            controller.switchValue.value =
                                                newValue;
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.membershipPayment(
                                          "onemonth",
                                          false,
                                          homeCtrl.getUserData.value
                                              .getUserById!.phoneNumber);
                                      controller.checkboxignore.value=false;
                                    },
                                    child: Container(
                                      height: 36,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stxt(
                                            text: "pay_now".tr,
                                            size: f3,
                                            weight: FontWeight.w600,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Space(4),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => QuickPay()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stxt(
                                  text: "pay_for_other_members".tr,
                                  size: f3,
                                  color: Theme.of(context).primaryColor,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.double_arrow_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                  duration: Duration(
                                seconds: 3,
                              ),color: clr_yellow),

                          // .tint(color: Get.theme.colorScheme.secondary)

                          10.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(right: 12, left: 12),
                            child: Row(
                              children: [
                                Stxt(
                                  text: "last_month".tr,
                                  size: f3,
                                  family: "Inter",
                                  weight: FontWeight.bold,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(PastPayments());
                                      controller.getMembershipPayDetails(
                                          "currentyear");
                                      controller.dropDownvalue.value =
                                          "This Year";
                                    },
                                    child: Stxt(
                                      text: "view_all".tr,
                                      size: f3,
                                      weight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ],
                            ),
                          ),

                          15.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(

                                height: 270.h,
                                child: ListView.separated(

                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          30.horizontalSpace,
                                  itemBuilder: (context, index) {
                                    var monthstatus =
                                        data.monthChart![index].paymentStatus ==
                                            "paid";
                                    return Column(
                                      children: [
                                        Text(
                                          "₹ ${data.monthChart![index].amount}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Space(4),
                                        Container(
                                          // child: Align(child: Stxt(text: 'Paid', size: f0,),),
                                          height: 185.h,
                                          width: 20.w,
                                          decoration: BoxDecoration(
                                            color: monthstatus
                                                ? Get.theme.primaryColor
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                            child: RotatedBox(
                                                quarterTurns: 1,
                                                child: data.monthChart![index]
                                                            .paymentStatus ==
                                                        "paid"
                                                    ? Stxt(
                                                        text: 'paid'.tr,
                                                        size: f2,
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        weight: FontWeight.w600,
                                                      )
                                                    : Stxt(
                                                        text: 'unpaid'.tr,
                                                        size: f2,
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        weight: FontWeight.w600,
                                                      )),
                                          ),
                                        ),
                                        Space(4),
                                        Stxt(
                                          text: DateFormat('MMM').format(DateTime.parse("${data.monthChart![index].paymentMonth}").toLocal()),
                                          size: f2,
                                          weight: FontWeight.w500,
                                        ),
                                        Space(8),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => PdfPreviewPage("")));
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: monthstatus
                                                  ? Get.theme.primaryColor
                                                  : clr_gray,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Icon(
                                              Icons.download_rounded,
                                              size: f2,
                                              color: clr_white,
                                            ),
                                          ),
                                        ),
                                        // Image.asset(
                                        //   "assets/images/download.png", width: 25,color: data.monthChart![index]
                                        //     .paymentStatus == "paid" ?null:Get.theme.primaryColor.withOpacity(.8),)
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [Stxt(text: "pay_bulk".tr, size: f4)],
                            ),
                          ),
                          Space(16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                widgetPayBulk(context, "quarterly".tr, "${data.bulkPayThree}", () {
                                  controller.membershipPayment(
                                      "threemonth",
                                      true,
                                      homeCtrl.getUserData.value.getUserById!
                                          .phoneNumber);
                                  controller.checkboxignore.value = true;
                                }),
                                widgetPayBulk(context, "half_yearly".tr, "${data.bulkPaySix}",
                                    () {
                                  controller.membershipPayment(
                                      "sixmonth",
                                      true,
                                      homeCtrl.getUserData.value.getUserById!
                                          .phoneNumber);
                                  controller.checkboxignore.value = true;

                                }),
                                widgetPayBulk(context, "annually".tr, "${data.bulkPayAnnual}", () {
                                  controller.membershipPayment(
                                      "twelvemonth",
                                      true,
                                      homeCtrl.getUserData.value.getUserById!
                                          .phoneNumber);
                                  controller.checkboxignore.value = true;

                                })
                              ],
                            ),
                          ),
                          Space(50),
                        ],
                      ),
                    );
                  }),
                ],
              );
      }),
    );
  }

  GestureDetector widgetPayBulk(
      BuildContext context, title, amount, Function() ontap) {
    // controller.isChecked.value=true;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 80.h,
        width: 100.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stxt(
              text: "${title}",
              size: f4,
              color: Colors.white,
            ),
            Space(16),
            Stxt(
              text: "₹ ${amount}",
              size: f5,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class Member {
  String? month;
  String? amount;
  String? image;

  Member({
    this.month,
    this.amount,
    this.image,
  });
}
