import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../widgets/space.dart';
import '../controllers/quranpage_controller.dart';
import '../model/quran_detail_model.dart';

class QuranDetails extends StatefulWidget {
  QuranDetails({super.key});

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

final QuranpageController c = Get.put(QuranpageController());


class _QuranDetailsState extends State<QuranDetails> {
  var makki = c.getqurandetail.value.getQuranAyahVerse![0].makkiMadina;
  var chapterno = c.getqurandetail.value.getQuranAyahVerse![0].suraChapterNo;
  var sura = c.getqurandetail.value.getQuranAyahVerse![0].suraNameEn;
  var title = c.getqurandetail.value.getQuranAyahVerse![0].titleEn;
  var verse = c.getqurandetail.value.getQuranAyahVerse![0].totalVerses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          tittle: "",
          action: [
            Row(
              children: [
                Icon(Icons.dangerous_rounded),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
              ],
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/qurantitle.png",
                        ),
                        fit: BoxFit.fill)),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Space(32),
                      Container(
                        height: 50,
                        width: 50,
                        // color: Colors.red,
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${makki}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                                Text(
                                  "${chapterno}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                              ],
                            )),
                      ),
                      Space(65),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${sura}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                            Text(
                              "${title}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Roboto",
                                  color: Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 50,
                        width: 50,
                        // color: Colors.red,
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Ayah",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                                Text(
                                  "${verse}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                              ],
                            )),
                      ),
                      Space(32)
                    ],
                  ),
                ),
              ),
              Space(16),
              Expanded(
                child: Scrollbar(
                  isAlwaysShown: true,
                  thickness: 8,
                  controller: c.scrollController,
                  radius: Radius.circular(20),
                  child: ListView.builder(
                      itemCount: c.getqurandetail.value.getQuranAyahVerse![0]
                          .ayahList!.length,
                      itemBuilder: (context, index) {
                        var sura = c.getqurandetail.value.getQuranAyahVerse![0]
                            .ayahList![index];
                        return Container(
                            width: double.infinity,
                            // color: Colors.red,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.r),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   "${sura.versesKey}",
                                      //   style: TextStyle(
                                      //       color: Theme
                                      //           .of(context)
                                      //           .primaryColor),
                                      // ),
                                      Container(
                                        width: 21.w,
                                        height: 21.w,
                                        child: Transform.rotate(
                                          angle: 40 *
                                              (3.1415926535897932 / 180),
                                          // Converting 30 degrees to radians
                                          child: Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              color: Color(0xff16627C),
                                            ),
                                            child: Center(
                                              child: Transform.rotate(
                                                angle: -40 *
                                                    (3.1415926535897932 /
                                                        180),
                                                child: Text(
                                                  "${sura.versesKey}",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Space(8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.play_circle,
                                            color: Theme
                                                .of(context)
                                                .primaryColor,
                                          ),
                                          40.horizontalSpace,
                                          // Container(
                                          //   width: 20.w,
                                          //   height: 20.w,
                                          //   child: Transform.rotate(
                                          //     angle: 40 *
                                          //         (3.1415926535897932 / 180),
                                          //     // Converting 30 degrees to radians
                                          //     child: Container(
                                          //       width: 200,
                                          //       height: 200,
                                          //       decoration: BoxDecoration(
                                          //         borderRadius:
                                          //         BorderRadius.circular(4),
                                          //         color: Color(0xff16627C),
                                          //       ),
                                          //       child: Center(
                                          //         child: Transform.rotate(
                                          //           angle: -40 *
                                          //               (3.1415926535897932 /
                                          //                   180),
                                          //           child: Text(
                                          //             "${sura.ayahNo}",
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 fontWeight: FontWeight
                                          //                     .bold,
                                          //                 color: Colors.white),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Space(10.w),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: .7.sw,
                                              child:
                                              Text(
                                                "${sura.arabicText}",
                                                style: GoogleFonts.amiri(
                                                  textStyle: Theme.of(context).textTheme.displayLarge,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                    color:
                                                    Theme
                                                        .of(context)
                                                        .colorScheme.primary,
                                                  wordSpacing: 3,
                                                ),
                                                textAlign: TextAlign.end,

                                                ),
                                              // Text(
                                              //   "${sura.arabicText}",
                                              //   style: TextStyle(
                                              //
                                              //       fontSize: 35,
                                              //       fontWeight: FontWeight.w800,
                                              //       color:
                                              //       Theme
                                              //           .of(context)
                                              //           .colorScheme.primary),
                                              //   textAlign: TextAlign.end,
                                              // ),
                                              ),



                                            ),
                                        ],
                                      ),
                                      Space(8),
                                      Icon(
                                        Icons.bookmark,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                      ),
                                      Space(16),
                                      SizedBox(width: .9.sw,
                                          child: Align(
                                            alignment: Alignment.center,
                                              child: Text("${sura.engTranslation}",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),))),
                                      Space(16),
                                      Image.asset(
                                        "assets/images/qurandivider.png",
                                        scale: 4,
                                        width: 310.w,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      }),
                ),
              )
            ],
          ),
        ),
      );

  }
}
