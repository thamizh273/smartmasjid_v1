import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/membership/controllers/membership_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../widgets/safa_dropdown2.dart';

class PastPaymentsMembership extends GetView<MembershipController> {
  const PastPaymentsMembership({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Get.theme;
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "past_payments".tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          shrinkWrap: true,
          children: [
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  return SafaDropdownButton2(

                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(color: Get.theme.primaryColor)),
                    buttonPadding: EdgeInsets.symmetric(horizontal: 7),
                    buttonWidth: 110,
                    buttonHeight: 35,
                    dropdownWidth: 120,
                    offset: Offset(-12, -5),
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 30.r,
                    hint: 'Fliter',
                    value: controller.dropDownvalue.value,
                    dropdownItems:  ["This Year", "previous_year".tr],
                    onChanged: (String? value) {
                      controller.dropDownvalue.value = value!;
                      controller.getMembershipPayDetails(value=="This Year"?"currentyear":"lastyear");
                    },
                  );
                }),
              ],
            ),
            10.verticalSpace,
            Obx(() {
              return controller.isloading1.value
                  ? DialogHelper.showLoading()
                  :controller.membershipPaymentData.value
                  .getMembershipPaymentDetail!.length==0?SizedBox(height:.7.sh,child: Center(child: Stxt(text: "No Record Found", size: f4))):  ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.membershipPaymentData.value
                    .getMembershipPaymentDetail!.length,
                itemBuilder: (context, index) {
                  var data = controller.membershipPaymentData.value
                      .getMembershipPaymentDetail![index];
                  controller.expand.assignAll(List.generate(
                    controller.membershipPaymentData.value
                        .getMembershipPaymentDetail!.length,
                        (_) => false,
                  ));
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                              color: Colors.grey.shade400)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stxt(
                                  text:
                                  '${DateFormat('MMMM yyyy').format(
                                      DateTime.parse(
                                          data.paymentMonth.toString()).toLocal())}',
                                  // text: "June 2023",
                                  size: f3,
                                  weight: FontWeight.w500),
                              Spacer(),
                              // Image.asset(
                              //   "assets/images/alert.png",
                              //   width: 20,
                              // ),
                              Icon(
                                Icons.check_circle,
                                color: clr_green,
                                size: f4,
                              ),

                              5.horizontalSpace,
                              Stxt(
                                  text: "Paid",
                                  size: f3,
                                  weight: FontWeight.w500),
                            ],
                          ),
                          20.verticalSpace,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stxt(
                                  text: "Paid amount : ",
                                  size: f3,
                                  weight: FontWeight.w500),
                              Stxt(
                                  text: "₹ ${data.amount}",
                                  size: f3,
                                  color: clr_green,
                                  weight: FontWeight.bold),
                              Spacer(),
                              Stxt(
                                  text: "${data.paymentMethod}",
                                  size: f3,
                                  weight: FontWeight.w500),
                            ],
                          ),
                          16.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                Icons.download,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                size: f4,
                              ),
                              Space(8),
                              Stxt(
                                text: "Download Receipt",
                                size: f2,
                                weight: FontWeight.w500,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.toggleExpansion(index);
                                  print(controller.expand);
                                },
                                child: SizedBox(
                                  height: 20.h,
                                  child: Row(
                                    children: [
                                      Stxt(
                                        text: "Details",
                                        size: f2,
                                        weight: FontWeight.w500,
                                        color: theme.primaryColor,
                                      ),
                                      5.horizontalSpace,
                                      Obx(() {
                                        return Icon(
                                          controller.expand[index] ? Icons
                                              .arrow_drop_up : Icons
                                              .arrow_drop_down,
                                          size: f3,
                                          color: theme.primaryColor,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Obx(() {
                            return (controller.expand[index])
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.verticalSpace,
                                Divider(thickness: 1,),

                                Row(
                                  children: [
                                    Stxt(
                                      pad: EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      text:
                                      "Receipt No: ",
                                      size: f2,
                                      weight: FontWeight.w600,
                                    ),
                                    Stxt(
                                      pad: EdgeInsets.symmetric(
                                          vertical: 8.h),
                                      text:
                                      "${data.receiptNo}",
                                      size: f2,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Stxt(
                                      pad: EdgeInsets.symmetric(
                                          vertical: 7.h),
                                      text:
                                      "Date of Payment: ",
                                      size: f2,
                                      weight: FontWeight.w600,
                                    ),
                                    Stxt(
                                      text: "${DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(data.paymentDate!
                                              .toLocal().toString()))}",
                                      size: f2,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ): SizedBox();
                          })

                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
