import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/hadith_chapter.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/mediumCard.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/smallCard.dart';
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          Color backgroundColor = index % 2 == 0 ? Color(0xffDCDBD7) : Color(0xffBCDDF2);
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
            child: HadithCard(
              color: backgroundColor,
              title: "Sahih Al-Bukhari",
              subtit: "صحيح البخاري",
              tit: "7563 Hadith",
              image: "bukari",
              border: Border.all(
                color: Colors.red
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => HadithChapter()));
              },),
          );
        }
      )
    );
  }
}


