import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/hadith_chapter.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/mediumCard.dart';
import 'package:smartmasjid_v1/widgets/hadith_card.dart';

import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';
import '../controllers/hadithpage_controller.dart';

class HadithpageView extends GetView<HadithpageController> {
   HadithpageView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Hadith",
        action: [
          IconButton(onPressed: (){}, icon: Icon(Icons.bookmark))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 8),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:10,
                itemBuilder: (context, index){
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey,
                              offset: Offset(4, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: HadithCard(
                          color: Color(0xffBCDDF2),
                          title: 'صحيح البخاري',
                          subtit: "Sahih Al-Bukhari",
                          tit: "7563 Hadith",
                          image: 'book',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => HadithChapter()));
                          },
                          shadow: true,),
                      ),
                      Space(16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.grey,
                              offset: Offset(4, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: HadithCard(
                          color: Color(0xffDCDBD7),
                          title: 'صحيح البخاري',
                          subtit: "Sahih Al-Bukhari",
                          tit: "7563 Hadith",
                          image: 'book',
                          onTap: () {

                          },
                          shadow: true,),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


