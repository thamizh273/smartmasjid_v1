import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';

class WellWisher extends StatelessWidget {
  const WellWisher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "masjid_well_wishers".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 30.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0,4),
                        color: Get.theme.shadowColor
                    )
                  ]
              ),
              child: Center(
                child: Stxt(text: "well_wishers".tr, size: f4, color: Colors.white,weight: FontWeight.w500,),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context , int index) {
                  return  Container(
                    height: 90.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(2,2),
                              color: Get.theme.shadowColor
                          )
                        ]
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                            ),
                            child: Image.asset("assets/images/picdr.png",),
                          ),
                          Space(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stxt(text: "Abdul Jabbar", size: f4, weight: FontWeight.w500, color: Get.theme.primaryColor,),
                              Space(4),
                              Stxt(text: "abduljabbar@gmail.com", size: f1, weight: FontWeight.w300, color: Get.theme.primaryColor,),
                              Space(4),
                              Stxt(text: "+91 9876543210", size: f2, weight: FontWeight.w400, color: Get.theme.primaryColor,),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SvgPicture.asset("assets/svg/phonedr.svg", width: 30,),
                              Space(12),
                              SvgPicture.asset("assets/svg/messagedr.svg", width: 30,),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
