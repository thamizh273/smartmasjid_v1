import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/duapage/controllers/duapage_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../language_page/controllers/language_page_controller.dart';

class DuaDetail extends StatelessWidget {
   DuaDetail({super.key});


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
                // icon: Icon(Icons.menu),
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
                            onTap: (){
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
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        })),
                    PopupMenuItem(
                        child: Obx(() {
                          return GestureDetector(
                            onTap: (){
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
          return duactrl.isLoadings1.value ?  DialogHelper.showLoading() : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stxt(
                      text: "i_am_feeling".tr, size: f4, weight: FontWeight.w500,),
                    Space(8),
                    Obx(() {
                      var detaildua = duactrl.getdetailduadata.value.getDuasVerseList!.duasVerses![0];
                      return Stxt(
                        text:
                        langCtrl.selectedLang.value=="ENGLISH"? detaildua.duasNameEn.toString():
                        langCtrl.selectedLang.value=="Tamil(தமிழ்)"? detaildua.duasNameTamil.toString():
                        langCtrl.selectedLang.value=="Hindi(हिंदी)"? detaildua.duasNameHindi.toString():
                        langCtrl.selectedLang.value=="Urdu(اردو)"? detaildua.duasNameUrdu.toString():
                        langCtrl.selectedLang.value=="Malayalam(മലയാളം)"? detaildua.duasNameMalayalam.toString():
                        langCtrl.selectedLang.value=="Telugu(తెలుగు)"? detaildua.duasNameTelugu.toString():
                        detaildua.duasNameEn.toString(),
                        size: f4,
                        weight: FontWeight.w500,
                        color: Get.theme.hoverColor);
                    }),
                  ],
                ),
                Space(16),
                Expanded(
                  child: ListView.builder(
                      itemCount: duactrl.getdetailduadata.value
                          .getDuasVerseList!.duasVerses!.length,
                      itemBuilder: (context, index) {
                        var duas = duactrl.getdetailduadata.value
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
                                        return Text("${duas.duasArabicText}",
                                          style: TextStyle(
                                              wordSpacing: 5,
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontFamily: duactrl.fontFamily
                                                  .value == "indopak"
                                                  ? "Indopak"
                                                  : duactrl.fontFamily.value ==
                                                  "qalam" ? "Qalam" : null
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
                                        text: "${duas.duasEngText}ِ",
                                        size: f4,
                                        color: Color(0xff78BDD4),textAlign: TextAlign.justify),
                                      Space(12),
                                      Text(
                                          langCtrl.selectedLang.value=="ENGLISH"? duas.engTranslation.toString():
                                          langCtrl.selectedLang.value=="Tamil(தமிழ்)"? duas.tamilTranslation.toString():
                                          langCtrl.selectedLang.value=="Hindi(हिंदी)"? duas.hindiTranslation.toString():
                                          langCtrl.selectedLang.value=="Urdu(اردو)"? duas.urduTranslation.toString():
                                          langCtrl.selectedLang.value=="Malayalam(മലയാളം)"? duas.malayalamTranslation.toString():
                                          langCtrl.selectedLang.value=="Telugu(తెలుగు)"? duas.teluguTranslation.toString():
                                          duas.engTranslation.toString(),
                                        style: TextStyle(fontFamily: "Sriracha",
                                            fontSize: 20,
                                            color: Colors.white.withOpacity(0.8)),textAlign: TextAlign.justify)
                                      // Stxt(
                                      //   family: "Italy",
                                      //   text: "${duas.engTranslation}",
                                      //   size: f5,
                                      //   color: Colors.white.withOpacity(0.8),),
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
        }),
      );
  }
}
