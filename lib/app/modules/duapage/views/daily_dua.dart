import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smartmasjid_v1/app/modules/duapage/controllers/duapage_controller.dart';

import '../../../../global.dart';
import '../../../../widgets/loading.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/widgets/appBar.dart';
import '../../language_page/controllers/language_page_controller.dart';


class DailyDua extends StatelessWidget {
  DailyDua({super.key});

  final DuapageController duactrl = Get.put(DuapageController());
  final langCtrl=Get.put(LanguagePageController());

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: CustomAppbar(
            tittle: "Dua",
            action: [
              PopupMenuButton(
                  icon: Icon(Icons.menu),
                  onSelected: (value) {
                    duactrl.selectedMenuItem.value = value;
                  },
                  shadowColor: Colors.grey
                      .shade400,
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                          child: Obx(() {
                            return GestureDetector(
                              onTap: () {
                                duactrl.fontFamily.value = "indopak";
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    activeColor: Get.theme.primaryColor,
                                    // title: Text("Amiri"),
                                    value: "indopak",
                                    groupValue: duactrl.fontFamily.value,
                                    onChanged: (groupValue) =>
                                    duactrl.fontFamily.value = groupValue!,
                                  ),
                                  Space(12),
                                  Text(
                                    "Indopak",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          })),
                      PopupMenuItem(
                          child: Obx(() {
                            return GestureDetector(
                              onTap: () {
                                duactrl.fontFamily.value = "qalam";
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    activeColor: Get.theme.primaryColor,
                                    // title: Text("Amiri"),
                                    value: "qalam",
                                    groupValue: duactrl.fontFamily.value,
                                    onChanged: (groupValue) =>
                                    duactrl.fontFamily.value = groupValue!,
                                  ),
                                  Space(12),
                                  Text("Qalam", style: TextStyle(
                                      fontWeight: FontWeight.w500),),
                                ],
                              ),
                            );
                          })),
                    ];
                  }
              )
            ],
          ),
          body: Obx(() {
            return duactrl.isLoadings2.value ?  DialogHelper.showLoading() : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        var titlename = duactrl.getdailydata.value.getDuasVerseList!;
                        return SizedBox(
                          width: duactrl.screenWidth * 0.7,
                          child: Stxt(
                            textAlign: TextAlign.center,
                            text:
                            langCtrl.selectedLang.value=="ENGLISH"?titlename.title.toString():
                            langCtrl.selectedLang.value=="Tamil(தமிழ்)"?titlename.titleTamil.toString():
                            langCtrl.selectedLang.value=="Hindi(हिंदी)"?titlename.titleHindi.toString():
                            langCtrl.selectedLang.value=="Urdu(اردو)"?titlename.titleUrdu.toString():
                            langCtrl.selectedLang.value=="Malayalam(മലയാളം)"?titlename.titleMalayalam.toString():
                            langCtrl.selectedLang.value=="Telugu(తెలుగు)"?titlename.titleTelugu.toString():
                            titlename.title.toString(),
                            size: f4,
                            weight: FontWeight.w500,),
                        );
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
                        itemCount: duactrl.getdailydata.value.getDuasVerseList!.duasVerses!
                            .length,
                        itemBuilder: (context, index) {
                          var dailydet = duactrl.getdailydata.value
                              .getDuasVerseList!.duasVerses![index];
                          double fontSize = 35.0;
                          return Column(
                            children: [
                              Stxt(text: "#${index + 1}", size: f4, color: Get.theme.hoverColor, weight: FontWeight.w600,),
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
                                        Obx(() {
                                          return Text(
                                            "${dailydet.duasArabicText}ِ",
                                            style: TextStyle(
                                                wordSpacing: 5,
                                                color: Colors.white,
                                                fontSize: fontSize,
                                                fontFamily: duactrl.fontFamily
                                                    .value == "indopak"
                                                    ? "Indopak"
                                                    : duactrl.fontFamily
                                                    .value == "qalam"
                                                    ? "qalam" : null
                                            ),);
                                        }),
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
                                            color: Color(0xff78BDD4),
                                            textAlign: TextAlign.justify),
                                        Space(12),
                                        Stxt(
                                            family: "Sriracha",
                                            text:
                                            langCtrl.selectedLang.value=="ENGLISH"?dailydet.engTranslation.toString():
                                            langCtrl.selectedLang.value=="Tamil(தமிழ்)"?dailydet.tamilTranslation.toString():
                                            langCtrl.selectedLang.value=="Hindi(हिंदी)"?dailydet.hindiTranslation.toString():
                                            langCtrl.selectedLang.value=="Urdu(اردو)"?dailydet.urduTranslation.toString():
                                            langCtrl.selectedLang.value=="Malayalam(മലയാളം)"?dailydet.malayalamTranslation.toString():
                                            langCtrl.selectedLang.value=="Telugu(తెలుగు)"?dailydet.teluguTranslation.toString():
                                            dailydet.engTranslation.toString(),
                                            size: f4,
                                            color: Colors.white.withOpacity(
                                                0.8),
                                            textAlign: TextAlign.justify),
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
