import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartmasjid_v1/app/modules/duapage/controllers/duapage_controller.dart';

import '../../../../global.dart';
import '../../../../widgets/loading.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/widgets/appBar.dart';


class DailyDua extends StatelessWidget {
  DailyDua({super.key});

  final DuapageController duactrl = Get.put(DuapageController());

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: CustomAppbar(
            tittle: "Dua",
          ),
          body:
          Obx(() {
            return duactrl.isLoadings2.value ? loading(context) : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Stxt(
                          text: "${duactrl.getdailydata.value.getDuasVerseList![0].title}",
                          size: f4,
                          weight: FontWeight.w500,);
                      }),
                      Space(8),
                      // Stxt(
                      //  text: "Sleeping",
                      //  size: f4,
                      //  weight: FontWeight.w500,
                      //  color: Theme
                      //      .of(context)
                      //      .primaryColor,)
                    ],
                  ),
                  Space(16),
                  Expanded(
                    child: ListView.builder(
                        itemCount: duactrl.getdailydata.value.getDuasVerseList!
                            .length,
                        itemBuilder: (context, index) {
                          var dailydet = duactrl.getdailydata.value
                              .getDuasVerseList![index];
                          double fontSize = 35.0;
                          return Column(
                            children: [
                              Stxt(text: "#${index + 1}", size: f4, color: Theme
                                  .of(context)
                                  .primaryColor, weight: FontWeight.w600,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xff1A667F)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          "${dailydet.duasArabicText}ِ",
                                          style: TextStyle(
                                              wordSpacing: 5,
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontFamily: duactrl.fontFamily
                                                  .value == "indopak"
                                                  ? "Indopak"
                                                  : duactrl.fontFamily.value
                                          ),),
                                        // Stxt(
                                        //   family: "Indopak",
                                        //   text: "${duas.duasArabicText}ِ",
                                        //   size: f5,
                                        //   color: Colors.white,),
                                        Space(12),
                                        Stxt(
                                          family: "Inter",
                                          text: "${dailydet.duasEngText}",
                                          size: f4,
                                          color: Color(0xff78BDD4),),
                                        Space(12),
                                        Stxt(
                                          text: "${dailydet.engTranslation}",
                                          size: f4,
                                          color: Colors.white.withOpacity(
                                              0.8),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  )
                ],
              ),
            );
          })
      );
  }
}
