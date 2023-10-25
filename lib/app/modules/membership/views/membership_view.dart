

import 'dart:io';
import 'dart:typed_data';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:smartmasjid_v1/app/modules/home/Drawer_List/masjid_history.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/past_payments.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/quick_pay.dart';


import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/membership_controller.dart';
import 'invoice_pdfpage.dart';



class MembershipView extends GetView<MembershipController> {
  MembershipView({Key? key}) : super(key: key);
 final HomeController homeCtrl = Get.find<HomeController>();
 final membercntl = Get.put(MembershipController());
  final invoicecntrl = Get.put(MembershipController());


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(() {
        double containerWidth = screenWidth > 768 ? 300 : screenWidth;
        double containerHeight = screenWidth > 768 ? screenHeight : 150;
        return controller.isloading.value
            ?  DialogHelper.showLoading()
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
                            color: Get.theme.shadowColor)
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
                                 // text: "",
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
                                   // text: " ",
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
                                    color: Get.theme.hoverColor),
                              ),
                            ],
                          ),
                          Space(8),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height:  data.currentPayment!.expireDate=="null"?152:164,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                               data.currentPayment!.expireDate=="null"?14.verticalSpace:14.verticalSpace,
                                  Container(
                                   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),color: clr_gray.shade300),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height / 30,
                                    child: Center(
                                      child: Stxt(
                                        text: "₹ ${data.currentPayment!.amount} ",
                                        size: f5,
                                        weight: FontWeight.bold,textAlign: TextAlign.center,
                                        color: Get.theme.primaryColor,
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
                                          color: Get.theme.primaryColor,
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
                                      controller.payforOthers.value=false;
                                      controller.membershipPayment(
                                          "onemonth",
                                          false,
                                          homeCtrl.getUserData.value
                                              .getUserById!.phoneNumber);
                                      controller.checkboxignore.value=false;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
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
                              controller.payforOthers.value=true;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stxt(
                                  text: "pay_for_other_members".tr,
                                  size: f3,
                                  color: Get.theme.hoverColor,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.double_arrow_outlined,
                                  color: Get.theme.hoverColor,
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
                                      Get.to(PastPaymentsMembership());
                                      controller.getMembershipPayDetails(
                                          "currentyear");
                                      controller.dropDownvalue.value =
                                          "This Year";
                                    },
                                    child: Stxt(
                                      text: "view_all".tr,
                                      size: f3,
                                      weight: FontWeight.w600,
                                      color: Get.theme.hoverColor,
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
                                              color: Get.theme.hoverColor),
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
                                            data.monthChart![index].paymentStatus =="paid"? membercntl.paymentInvoice(data.monthChart![index].receiptNo!):null;
                                            data.monthChart![index].paymentStatus =="paid"? Navigator.of(context).push(MaterialPageRoute(builder: (_) => PdfPreviewPage(""))): null;
                                            //membercntl.downloadPDF();
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
                                  controller.payforOthers.value=false;
                                  controller.membershipPayment(
                                      "threemonth",
                                      true,
                                      homeCtrl.getUserData.value.getUserById!
                                          .phoneNumber);
                                  controller.checkboxignore.value = true;
                                }),
                                widgetPayBulk(context, "half_yearly".tr, "${data.bulkPaySix}",
                                    () {
                                      controller.payforOthers.value=false;
                                  controller.membershipPayment(
                                      "sixmonth",
                                      true,
                                      homeCtrl.getUserData.value.getUserById!
                                          .phoneNumber);
                                  controller.checkboxignore.value = true;

                                }),
                                widgetPayBulk(context, "annually".tr, "${data.bulkPayAnnual}", () {
                                  controller.payforOthers.value=false;
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



