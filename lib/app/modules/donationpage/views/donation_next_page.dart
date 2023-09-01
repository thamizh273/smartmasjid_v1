import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/donationpage/views/payment_method.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../../membership/views/payment_method.dart';

class DonationAmount extends StatelessWidget {
  const DonationAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "donation".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/donate.png"),
              Space(16),
              Row(
                children: [
                  Stxt(text: "Education for poor", size: f5, weight: FontWeight.w500,),
                  Spacer(),
                  Stxt(text: "22 days left", size: f1 ,color: Colors.black.withOpacity(0.5),),
                ],
              ),
              Space(4),
              Stxt(text: "Poverty Sadaqah", size: f3,  weight: FontWeight.w400,),
              Space(16),
              Stxt(text: "₹3,20,000 Raised", size: f5, weight: FontWeight.w600, color: Theme.of(context).primaryColor,),
              Space(16),
              Container(
                height: 8.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey
                ),
              ),
              Space(8),
              Row(
                children: [
                  Stxt(text: "₹1,05,000 Collected", size: f3, weight: FontWeight.w500, color: Theme.of(context).primaryColor,),
                  Spacer(),
                  Stxt(text: "₹60,000 Needed", size: f3, weight: FontWeight.w600, color: Colors.grey.shade500,),
                ],
              ),
              Space(25),
              Image.asset("assets/images/charity.png"),
              Space(20),
              Stxt(text: "this_fund_raised_by_your_masjid_so_your_donate_amount_will_be_settled_to_your_masjid".tr, size: f2, weight: FontWeight.w400, textAlign: TextAlign.center,),
              Space(16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).primaryColor)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "enter_amount".tr
                    ),
                  ),
                ),
              ),
              Space(8),
              Row(
                children: [
                 Stxt(text: "suggested".tr, size: f4, color: Theme.of(context).primaryColor, weight: FontWeight.w500,),
                  Space(8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Stxt(text: "200", size: f3),
                      ),
                    ),
                  ),
                  Space(8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Stxt(text: "500", size: f3),
                      ),
                    ),
                  ),
                  Space(8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                        child: Stxt(text: "1000", size: f3),
                      ),
                    ),
                  ),
                ],
              ),
              Space(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: ()   {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentMethod()));
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
                      child: Text("donate_now".tr, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
