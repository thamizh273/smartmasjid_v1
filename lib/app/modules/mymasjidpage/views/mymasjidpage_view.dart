import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../controllers/mymasjidpage_controller.dart';

class MymasjidpageView extends GetView<MymasjidpageController> {
  const MymasjidpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "my_masjid".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              // height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stxt(text: "current_masjid".tr, size: f2, color: Theme.of(context).primaryColor,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 70.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset("assets/images/masjidhis.png", fit: BoxFit.cover,),
                          ),
                          Space(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 130.w, child: Stxt(text: "Masjid-e-nooraniya", size: f5, weight: FontWeight.w500, color:Get.theme.primaryColor)),
                              Space(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on),
                                  Space(4),
                                  Stxt(text: "Muthiyalpet", size: f3, color:Get.theme.primaryColor),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Space(8),
                    Stxt(text: "  In the early 1980 there were around 10 Muslim families living in the "
                        "Depesanpet area of Muthialpet, Pondicherry. These people need to go to "
                        "KottakuppamBusthaniya Masjid for their prayers.On considering the difficulty, "
                        "Marhoom Janab Abdul Hammed was kind enough to spare a room of his house to convert "
                        "into a prayer hall for offering prayer. In the same room, a Madrassa for small children was also conducted."
                    , size: f2, textAlign: TextAlign.start,color:Get.theme.primaryColor),
                    Space(16),
                    Row(
                      children: [
                        Stxt(text: "joined_on".tr, size: f3, weight: FontWeight.w500,color:Get.theme.primaryColor),
                        Stxt(text: ": Jan 2020".tr, size: f3, weight: FontWeight.w500,color:Get.theme.primaryColor),
                        Spacer(),
                        Stxt(text: "members".tr, size: f3, weight: FontWeight.w400,color:Get.theme.primaryColor),
                        Stxt(text: ": 198", size: f3, weight: FontWeight.w400,color:Get.theme.primaryColor),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Space(16),
            // ElevatedButton(
            //     onPressed: ()   {
            //     },
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: Size(150, 40),
            //       backgroundColor: Theme.of(context).primaryColor,
            //       foregroundColor: Color(0xff11323B),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       elevation: 4.0,
            //     ),
            //     child: Text("Add Masjid", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
            Spacer(),
            Stxt(text: "note:if_you_join_another_masjid_you_need_to_pay_membership_for_that_masjid_too".tr, size: f2, textAlign: TextAlign.center,color:Get.theme.primaryColor)
          ],
        ),
      ),
    );
  }
}
