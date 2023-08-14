import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/duapage/controllers/duapage_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

class DuaDetail extends StatelessWidget {
  DuaDetail({super.key});


  DuapageController c = Get.put(DuapageController());

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: CustomAppbar(
          tittle: "Dua",
        ),
        body: Obx(() {
          return c.isLoadings1.value?loading(context): Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stxt(
                      text: "I Am Feeling", size: f4, weight: FontWeight.w500,),
                    Space(8),
                    Obx(() {
                      return Stxt(
                        text: "${c.getdetailduadata.value.getDuasVerseList![0]
                            .duasNameEn}",
                        size: f4,
                        weight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .primaryColor,);
                    }),
                  ],
                ),
                Space(16),
                Expanded(
                  child: ListView.builder(
                      itemCount: c.getdetailduadata.value.getDuasVerseList!
                          .length,
                      itemBuilder: (context, index) {
                        var duas = c.getdetailduadata.value
                            .getDuasVerseList![index];

                        double fontSize = 35.0;
                        return Column(
                          children: [
                            Stxt(text: "#${index+1}", size: f4, color: Theme
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
                                      Text("${duas.duasArabicText}", style: TextStyle(
                                        wordSpacing: 5,
                                        color: Colors.white,
                                        fontSize: fontSize,
                                          fontFamily: c.fontFamily
                                              .value == "indopak"
                                              ? "Indopak"
                                              : c.fontFamily.value
                                      ),),
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
                                        color: Color(0xff78BDD4),),
                                      Space(12),
                                      Stxt(
                                        text: "${duas.engTranslation}",
                                        size: f4,
                                        color: Colors.white.withOpacity(0.8),),
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
