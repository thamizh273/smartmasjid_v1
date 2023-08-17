import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/donationpage/views/donation_next_page.dart';
import 'package:smartmasjid_v1/app/modules/donationpage/views/past_payments.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
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
        tittle: "Donation",
        action: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => PastPayments()));
            },
              child: SvgPicture.asset("assets/svg/pastdonation.svg")),
          Space(20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset("assets/images/donatead.png"),
            Space(16),
            Stxt(text: "Your Masjid raises these funds, So these are all will be \nsettled to your Masjid", size: f2, textAlign: TextAlign.center, weight: FontWeight.w500,),
            Space(16),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                  itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DonationAmount()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Container(
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Theme.of(context).primaryColor),
                            color: Colors.white
                        ),
                        child: Row(
                          children: [
                            Container(
                                height: 80.h,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/images/masjidselc.png", fit: BoxFit.cover,),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 145.w, child: Stxt(text: "Masjid Construction", size: f3, weight: FontWeight.w600, overflow: TextOverflow.ellipsis,)),
                                    Space(12),
                                    Stxt(text: "23 days left", size: f1, color: Colors.black.withOpacity(0.5),),
                                  ],
                                ),
                                Space(8),
                                Stxt(text: "Masjid Sadaqah", size: f2,weight: FontWeight.w400,),
                                Space(8),
                                Stxt(text: "Raised ₹80,000 of ₹3,20,000", size: f3, weight: FontWeight.w600, color: Theme.of(context).primaryColor,),
                                Space(8),
                                Container(
                                  width: 200.w,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.grey
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 100.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    color: Theme.of(context).primaryColor
                                ),
                                child: Center(
                                  child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  }
              ),
            )

          ],
        ),
      )
    );
  }
}
