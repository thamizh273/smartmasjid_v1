import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../widgets/safa_dropdown2.dart';
import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/specialdayspage_controller.dart';

class SpecialdayspageView extends GetView<SpecialdayspageController> {
  SpecialdayspageView({Key? key}) : super(key: key);
  final spclcntrl = Get.put(SpecialdayspageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: 'special_days'.tr,
        ),
        body: FrostedBottomBar(
          width: 330.w,
          opacity: .8,
          sigmaX: 10,
          sigmaY: 10,
          bottomBarColor: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 800),
          hideOnScroll: true,
          body: (BuildContext context, ScrollController controller) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return SafaDropdownButton2(
                          dropdownDecoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                          ),
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.theme.primaryColor.withOpacity(0.6)),
                          buttonPadding: EdgeInsets.symmetric(horizontal: 7),
                          buttonWidth: 110,
                          buttonHeight: 35,
                          dropdownWidth: 120,
                          offset: Offset(-12, -5),
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          iconSize: 30.r,
                          hint: 'Fliter',
                          value: spclcntrl.dropDownvalue.value,
                          dropdownItems: [
                            "This Month",
                            "This Year",
                            "Next Year"
                          ],
                          onChanged: (String? value) {
                            if (value == "This Month") {
                              spclcntrl.dropDownvalue.value = value!;
                              spclcntrl.specialDays("month");
                            } else {
                              spclcntrl.dropDownvalue.value = value!;
                              var date = DateTime.now().year;
                              spclcntrl.specialDays(value == "This Year" ? "$date" : "${date + 1}");
                            }
                          },
                        );
                      }),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      if (spclcntrl.isLoadings0.value) {
                        return  DialogHelper.showLoading();
                      } else {
                        final holyDays = spclcntrl.getspecialdays.value.getHolyDays!;
                        if (holyDays.isEmpty) {
                          // Show "No special days found" message when the list is empty
                          return Center(
                            child: Text("No special days found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          );
                        } else {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: spclcntrl
                                  .getspecialdays.value.getHolyDays!.length,
                              itemBuilder: (context, index) {
                                var spcldays = spclcntrl
                                    .getspecialdays.value.getHolyDays![index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4, bottom: 4, right: 8, left: 8),
                                  child: Container(
                                    height: 80.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Get.theme.primaryColor)),
                                    child: Center(
                                      child: ListTile(
                                        leading: Container(
                                          height: 50.h,
                                          width: 50.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: 16.h,
                                                  width: double.infinity,
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Center(
                                                        child: Text(
                                                      "${spcldays.month}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                  )),
                                              SizedBox(
                                                  child: Container(
                                                height: 26.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${spcldays.date}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20,
                                                          color: Get.theme
                                                              .primaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        title: Text(
                                          "${spcldays.holydaysName}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Get.theme.primaryColor),
                                        ),
                                        subtitle: Text(
                                          "${spcldays.day}, ${spcldays.arabicDate}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                    }),
                  ),
                ),
                Space(70),
              ],
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/svg/masjidbot.svg",  color: Get.theme.focusColor),
                Space(8),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.QURANPAGE);
                    },
                    child: SvgPicture.asset("assets/svg/quranbot.svg",  color: Get.theme.focusColor)),
                Space(8),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pop(MaterialPageRoute(builder: (_) => HomeView()));
                    },
                    child: SvgPicture.asset("assets/svg/homebot.svg",  color: Get.theme.focusColor)),
                Space(8),
                SvgPicture.asset("assets/svg/mediabot.svg",  color: Get.theme.focusColor),
                Space(8),
                SvgPicture.asset("assets/svg/qiblabot.svg",  color: Get.theme.focusColor),
              ],
            ),
          ),
        ));
  }
}
