import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../controllers/membership_controller.dart';

class PaymentMethod extends StatelessWidget {
   PaymentMethod({super.key});
  MembershipController c = Get.put(MembershipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Payment",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 80.h,
              width: double.infinity,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(8),
               boxShadow: [
                 BoxShadow(
                   blurRadius: 4,
                   spreadRadius: 4,
                   offset: Offset(
                     0,4
                   ),
                   color: Colors.grey.shade400
                 )
               ]
             ),
              child: Row(
                children: [
                  Space(8),
              Obx(() {
                return  Transform.scale(
                  scale: 1.3,
                  child: Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Amiri"),
                      value: "upi",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                      c.fontFamily.value = groupValue!,
                    ),
                );
                  }),
                  Space(8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("UPI Payment", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                      Space(8),
                      Text("Google pay, Paytm, Phonepe", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),)
                    ],
                  )
                ],
              ),
            ),
            Space(16),
            Container(
              height: 80.h,
              width: double.infinity,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(8),
               boxShadow: [
                 BoxShadow(
                   blurRadius: 4,
                   spreadRadius: 4,
                   offset: Offset(
                     0,4
                   ),
                   color: Colors.grey.shade400
                 )
               ]
             ),
              child: Row(
                children: [
                  Space(8),
              Obx(() {
                return  Transform.scale(
                  scale: 1.3,
                  child: Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Amiri"),
                      value: "cr",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                      c.fontFamily.value = groupValue!,
                    ),
                );
                  }),
                  Space(8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Credit/Debit Card", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                      Space(8),
                      Text("Visa, mastercard", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),)
                    ],
                  )
                ],
              ),
            ),
            Space(16),
            Container(
              height: 80.h,
              width: double.infinity,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(8),
               boxShadow: [
                 BoxShadow(
                   blurRadius: 4,
                   spreadRadius: 4,
                   offset: Offset(
                     0,4
                   ),
                   color: Colors.grey.shade400
                 )
               ]
             ),
              child: Row(
                children: [
                  Space(8),
              Obx(() {
                return  Transform.scale(
                  scale: 1.3,
                  child: Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Amiri"),
                      value: "net",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                      c.fontFamily.value = groupValue!,
                    ),
                );
                  }),
                  Space(8),
                  Text("Net Banking", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                ],
              ),
            ),
            Space(16),
            Container(
              height: 80.h,
              width: double.infinity,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(8),
               boxShadow: [
                 BoxShadow(
                   blurRadius: 4,
                   spreadRadius: 4,
                   offset: Offset(
                     0,4
                   ),
                   color: Colors.grey.shade400
                 )
               ]
             ),
              child: Row(
                children: [
                  Space(8),
              Obx(() {
                return  Transform.scale(
                  scale: 1.3,
                  child: Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Amiri"),
                      value: "cash",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                      c.fontFamily.value = groupValue!,
                    ),
                );
                  }),
                  Space(8),
                  Text("Cash", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),)
                ],
              ),
            ),
            Space(16),
            ElevatedButton(
                onPressed: ()   {

                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 40),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Color(0xff11323B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4.0,
                ),
                child: Text("Pay now", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
