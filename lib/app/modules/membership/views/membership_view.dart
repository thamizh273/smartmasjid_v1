import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/past_payments.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/quick_pay.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/views/home_view.dart';
import '../controllers/membership_controller.dart';

class MembershipView extends GetView<MembershipController> {
  MembershipView({Key? key}) : super(key: key);

  List<Member> memberList = [
    Member(amount: "500", month: "Jan", image: "assets/images/download.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isloading.value ? loading(context) : Column(
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
                      color: Colors.grey.shade400
                  )
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
                  var data = controller.membershipDetailData.value
                      .getMembershipDetail!;
                  return Column(
                    children: [
                      Space(20),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(MaterialPageRoute(
                                    builder: (_) => HomeView()));
                              },
                              child: SvgPicture.asset(
                                  "assets/svg/backnew.svg")),
                          Space(16),
                          Stxt(text: "Membership", size: f5, weight: FontWeight
                              .w600, color: Colors.white,),
                        ],
                      ),
                      Space(70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stxt(text: "Janab. ", size: f5, color: Colors.white),
                          Stxt(text: "${data.userId!.firstName} ",
                            size: f5,
                            color: Colors.white,
                            weight: FontWeight.w600,),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stxt(text: "Membership Id: ", size: f3, color: Colors
                              .white),
                          Stxt(text: "${data.membershipid}",
                              size: f3,
                              color: Colors.white),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),

            Obx(() {
              var data = controller.membershipDetailData.value
                  .getMembershipDetail!;
              var statusPaid=data.monthChart![0]
                  .paymentStatus == "paid";
              return Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You are paying to "),
                        Text("${data.masjidId!.masjidName} ",
                          style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Theme
                                  .of(context)
                                  .primaryColor),),
                      ],
                    ),
                    Space(8),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                                color: Theme
                                    .of(context)
                                    .primaryColor
                            )
                        ),
                        child: Column(
                          children: [
                            Space(16),
                            Stxt(
                              text: "₹ ${data.currentPayment!
                                  .amount} ",
                              size: f5,
                              weight: FontWeight.bold,),
                            Space(8),
                            Stxt(
                              text: "Membership ${statusPaid
                                  ? "expire in"
                                  : "due by"} ${DateFormat('dd MMM yyyy')
                                  .format(
                                  DateTime(DateTime.now().year, DateTime.now().month + 1, 0))}",
                              size: f1,
                              weight: FontWeight.w500,
                              color:statusPaid? clr_green:clr_red,),
                            Space(2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stxt(text: "Membership Auto pay", size: f4),
                                Obx(() {
                                  return Switch(
                                    activeColor: Theme
                                        .of(context)
                                        .primaryColor,
                                    value: controller.switchValue.value,
                                    onChanged: (newValue) {
                                      controller.switchValue.value = newValue;
                                    },
                                  );
                                }),
                              ],
                            ),
                            Container(
                              height: 36,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IgnorePointer(
                                    ignoring: statusPaid ? true : false,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => QuickPay()));
                                        },
                                        child: Stxt(
                                          text:statusPaid? "Paid" : "Pay Now",
                                          size: f3,
                                          weight: FontWeight.w600,
                                          color: Colors.white,)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Space(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stxt(
                          text: "Pay for Other Membership",
                          size: f3,
                          color: Theme
                              .of(context)
                              .primaryColor,
                          weight: FontWeight.w600,),
                        Icon(Icons.double_arrow_outlined, color: Theme
                            .of(context)
                            .primaryColor, size: 20,),
                      ],
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(right: 12, left: 12),
                      child: Row(
                        children: [
                          Stxt(text: "Last 6 month",
                            size: f3,
                            family: "Inter",
                            weight: FontWeight.bold,),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                Get.to(PastPayments());
                                controller.getMembershipPayDetails("currentyear");
                                controller.dropDownvalue.value ="This Year";
                              },
                              child: Stxt(text: "View all",
                                size: f3,
                                weight: FontWeight.w600,
                                color: Theme
                                    .of(context)
                                    .primaryColor,)),
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
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            separatorBuilder: (BuildContext context,
                                int index) => 21.horizontalSpace,
                            itemBuilder: (context, index) {
                             var monthstatus=data.monthChart![index]
                                 .paymentStatus == "paid" ;
                              return Column(
                                children: [
                                  Text("₹ ${data.monthChart![index].amount}",
                                    style: TextStyle(fontSize: 15, color: Theme
                                        .of(context)
                                        .primaryColor),),
                                  Space(4),
                                  Container(
                                    // child: Align(child: Stxt(text: 'Paid', size: f0,),),
                                    height: 185.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color:monthstatus ? Get.theme
                                          .primaryColor : Colors.grey,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                          child: data.monthChart![index]
                                              .paymentStatus == "paid" ? Stxt(text: 'Paid', size: f2,color: Colors.white.withOpacity(0.7), weight: FontWeight.w600,):Stxt(text: 'UnPaid', size: f2,color: Colors.white.withOpacity(0.5), weight: FontWeight.w600,)),
                                    ),
                                  ),
                                  Space(4),
                                  Stxt(text: "${data.monthChart![index]
                                      .paymentMonth}",
                                    size: f2,
                                    weight: FontWeight.w500,),
                                  Space(8),
                              Container(

                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                              color: monthstatus?Get.theme.primaryColor:clr_gray,
                              borderRadius: BorderRadius.circular(20),

                              ),child: Icon(Icons.download_rounded,size: f2,color: clr_white,),),
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
                        children: [
                          Stxt(text: "Pay Bulk", size: f4)
                        ],
                      ),
                    ),
                    Space(16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stxt(text: "Quarterly",
                                    size: f4,
                                    color: Colors.white,),
                                  Space(16),
                                  Stxt(text: "₹ 300",
                                    size: f5,
                                    color: Colors.white,),
                                ],
                              ),
                            ),
                            Space(16),
                            Container(
                              height: 80,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stxt(text: "Half yearly",
                                    size: f4,
                                    color: Colors.white,),
                                  Space(16),
                                  Stxt(text: "₹ 600",
                                    size: f5,
                                    color: Colors.white,),
                                ],
                              ),
                            ),
                            Space(16),
                            Container(
                              height: 80,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stxt(text: "Annually",
                                    size: f4,
                                    color: Colors.white,),
                                  Space(16),
                                  Stxt(text: "₹ 1,200",
                                    size: f5,
                                    color: Colors.white,),
                                ],
                              ),
                            ),
                          ],
                        ),
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