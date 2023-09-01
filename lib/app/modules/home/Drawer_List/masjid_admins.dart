import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';


class MasjidAdmin extends StatelessWidget {
  const MasjidAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: 'masjid_admins'.tr,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return  Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: Offset(0,4),
                            color: Colors.grey.shade400
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 30.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(0,4),
                                    color: Colors.grey.shade400
                                )
                              ]
                          ),
                          child: Center(
                            child: Stxt(text: "Chairman", size: f4, color: Colors.white,weight: FontWeight.w500,),
                          ),
                        ),
                      ),
                      Padding(
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
                              children: [
                                Stxt(text: "Abdul Jabbar", size: f4, weight: FontWeight.w500,),
                                Space(3),
                                Stxt(text: "abduljabbar@gmail.com", size: f1, weight: FontWeight.w300,),
                                Space(3),
                                Stxt(text: "+91 9876543210", size: f2, weight: FontWeight.w400,),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                SvgPicture.asset("assets/svg/phonedr.svg", width: 35,),
                                Space(8),
                                SvgPicture.asset("assets/svg/messagedr.svg", width: 35,),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
