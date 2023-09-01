import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';

class PastPayments extends StatelessWidget {
  const PastPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "past_donation".tr,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
          itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                  ),
                  child: Row(
                    children: [
                      Space(8),
                      Container(
                          height: 80.h,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/masjidselc.png", fit: BoxFit.fill,),
                          )
                      ),
                      Space(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Space(12),
                          Row(
                            children: [
                              SizedBox(width: 145.w, child: Stxt(text: "Masjid Construction", size: f3, weight: FontWeight.w600, overflow: TextOverflow.ellipsis,)),
                              Space(20),
                              Stxt(text: "23 days left", size: f1, color: Colors.black.withOpacity(0.5),),
                            ],
                          ),
                          Space(6),
                          Stxt(text: "Masjid Sadaqah", size: f2,weight: FontWeight.w400,),
                          Space(8),
                          Row(
                            children: [
                              Image.asset("assets/images/tick.png", width: 16,),
                              Space(8),
                              Stxt(text: "₹2,000 Donated", size: f3, weight: FontWeight.w600, color: Theme.of(context).primaryColor,),
                              60.horizontalSpace,
                              Image.asset("assets/images/download.png", width: 25,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
          }
      )
    );
  }
}
