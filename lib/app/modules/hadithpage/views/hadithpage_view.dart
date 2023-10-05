import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/hadith_chapter.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/hadith_card.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../widgets/space.dart';
import '../controllers/hadithpage_controller.dart';

class HadithpageView extends GetView<HadithpageController> {
  HadithpageView({Key? key}) : super(key: key);
  final hadithcntrl = Get.put(HadithpageController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "hadith".tr,
          action: [
            Image.asset("assets/images/bookmark.png", width: 20,),
            Space(20)
          ],
        ),
        body: Obx(() {
          return hadithcntrl.isLoadings.value ? loading(context) : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: hadithcntrl.gethadithdata.value.getHadithsCollection!.length,
              itemBuilder: (context, index) {
                var hadith = hadithcntrl.gethadithdata.value
                    .getHadithsCollection![index];
                Color backgroundColor = index % 2 == 0
                    ? Color(0xffDCDBD7)
                    : Color(0xffBCDDF2);
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 4, top: 4),
                  child: HadithCard(
                    color: backgroundColor,
                    title: "${hadith.collectionNameEn}",
                    subtit: "${hadith.collectionNameArb}",
                    tit: "${hadith.totalChapters} Hadith",
                    image: "bukari",
                    border: Border.all(
                        color: Colors.red
                    ),
                    onTap: () {
                      hadithcntrl.hadithChapters(hadith.collectionNameEn);
                      Get.to(HadithChapter());
                    },),
                );
              }
          );
        })
    );
  }
}


