import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartmasjid_v1/app/modules/hadithchapterdetail/views/hadithchapterdetail_view.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/controllers/hadithpage_controller.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/views/hadithchapterdetail.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../widgets/space.dart';

class HadithChapter extends StatelessWidget {
  HadithChapter({super.key});

  final hadchap_cntrl = Get.put(HadithpageController());
  final Color oddItemColor = Color(0xffBCDDF2);
  final Color evenItemColor = Colors.white;


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return hadchap_cntrl.isLoadings3.value ? loading(context) : Scaffold(
        appBar: CustomAppbar(
          tittle: "Hadith",
          action: [
            Row(
              children: [
                Image.asset("assets/images/notes.png", width: 20,),
                Space(16),
                Image.asset("assets/images/bookmark.png", width: 20,),
                Space(16),
              ],
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Color(0xff16627C)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/book.png", scale: 8,),
                    Space(8),
                    Text("${hadchap_cntrl.gethadithchapter.value.getHadithsChapterByCollection!.collectionNameEn}", style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
              Space(8),
              Text("Select chapter you want to read",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),),
              Space(16),
              // ListTile(
              //   title: Row(
              //     children: [
              //       Stack(children: [
              //         Padding(
              //           padding: const EdgeInsets.only(top: 12),
              //           child: Text("1", style: TextStyle(fontSize: 15),),
              //         ),
              //         Image.asset("assets/images/hadithchap.png",scale: 3,)]),
              //       Space(8),
              //       Text("Revelation", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
              //       Spacer(),
              //       Text("1-7")
              //     ],
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemCount: hadchap_cntrl.gethadithchapter.value.getHadithsChapterByCollection!.chapterList!.length,
                    itemBuilder: (context, index) {
                      var chapter = hadchap_cntrl.gethadithchapter.value.getHadithsChapterByCollection!.chapterList![index];
                      Color color = index % 2 == 0 ? evenItemColor : oddItemColor;

                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,2),
                                    blurRadius: 2,
                                    spreadRadius: 4,
                                  color: Colors.grey.shade400
                                )
                              ],
                              color: color,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30.h,
                                    width: 30.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/hadithnum.png"),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment
                                          .center,
                                      child: Text("${chapter.chapterNo}", style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Theme
                                              .of(context)
                                              .primaryColor),),
                                    ),
                                  ),
                                  Space(8),
                                  SizedBox(
                                    width: 200.w,
                                    child: Text("${chapter.hadithsChapterNameEn}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Spacer(),
                                  Text("${chapter.hadithsTotal}")
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => Hadithchapterdetail()));
                        },
                      );

                    }
                ),

              ),
            ],
          ),
        ),
      );
    });
  }
}
