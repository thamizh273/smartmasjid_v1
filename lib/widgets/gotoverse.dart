import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/controllers/quranpage_controller.dart';
import 'package:smartmasjid_v1/widgets/space.dart';

import '../app/modules/quranpage/views/qurandetails.dart';

final QuranpageController quranPageCtrl_ = Get.put(QuranpageController());

Future GotoVerse(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xff16627C),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          // getQuranChaptersList();
                        },
                        child: Text(
                          'Surah',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Space(2),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          // getQuranChaptersList();
                        },
                        child: Text(
                          'Ayah',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // Space(2),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 60,
                      child: GestureDetector(
                        onTap: () {
                          // getQuranChaptersList();
                        },
                        child: Text(
                          'Pages',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // Space(1)
                  ],
                ),
              ),
              Space(16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ///surah
                  Obx(() {
                    return SizedBox(
                        width: quranPageCtrl_.screenWidth * 0.43,
                        height: 250.h,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Center(
                                child: Container(
                                  width: 150, // Adjust the width as needed
                                  height: 40, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                              ),
                            ),
                            ListWheelScrollView(
                              useMagnifier: true,
                              magnification: 1.1,
                              physics: FixedExtentScrollPhysics(),
                              itemExtent: 50,
                              // Adjust the item height as needed
                              diameterRatio: 2.0,
                              onSelectedItemChanged: (v) {
                                quranPageCtrl_.gotoSura.value = int.parse(
                                    quranPageCtrl_.getqurandata.value
                                        .quranFilter![v].totalVerses!);
                                quranPageCtrl_.currentSelected.value = v;
                                quranPageCtrl_.currentSelectedpassaya.value = v;
                                print(quranPageCtrl_.currentSelected.value);


                                    quranPageCtrl_.pagesint.value= quranPageCtrl_.pagesSura[v]-1;
                                    quranPageCtrl_.scrollToPage();


                                quranPageCtrl_.update();


                              },
                              // Adjust as needed
                              children: List.generate(
                                quranPageCtrl_
                                    .getqurandata.value.quranFilter!.length,
                                    (index) {
                                  var sura = quranPageCtrl_.getqurandata.value
                                      .quranFilter![index].suraNameEn;
                                  var chap = quranPageCtrl_.getqurandata.value
                                      .quranFilter![index].suraChapterNo;

                                  return Container(
                                    height: 50, // Adjust the height as needed
                                    child: ListTile(
                                      dense: true,
                                      title: Row(
                                        children: [
                                          Text(
                                            "${chap!}.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            sura!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ));
                  }),

                  ///ayah
                  Obx(() {
                    return SizedBox(
                      width: quranPageCtrl_.screenWidth * 0.17,
                      height: 250.h,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ),
                          ),
                          ListWheelScrollView(
                            useMagnifier: true,
                            magnification: 1.1,
                            itemExtent: 50,
                            diameterRatio: 2.0,
                            physics: FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (v) async{
                              quranPageCtrl_.result.value = v;


                                      //quranPageCtrl_.pagesint.value=surano==(quranPageCtrl_.pages[int.parse('${quranPageCtrl_.currentSelectedpassaya.value}${v-1}')]["verse"].toString())?(pagenoss):0;



                                quranPageCtrl_.scrollToPage();

                              quranPageCtrl_.update();
                              // Synchronize the "pages" ListWheelScrollView
                            },
                            children: List.generate(
                              quranPageCtrl_.gotoSura.value,
                                  (index) {
                                return Container(
                                  height: 50,
                                  child: ListTile(
                                    dense: true,
                                    title: Row(
                                      children: [
                                        Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  ///pages
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: quranPageCtrl_.screenWidth * 0.17,
                    height: 250.h,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                        ),
                        ListWheelScrollView(
                          controller:quranPageCtrl_.controllerffPage ,
                          useMagnifier: true,
                          magnification: 1.1,
                          itemExtent: 50,
                          diameterRatio: 2.0,
                          children: List.generate(
                            604,
                                (index) {

                              return  AutoScrollTag(
                                key: ValueKey(index),
                                controller: quranPageCtrl_.controllerffPage,
                                index: index,
                                child: Container(
                                  height: 50,
                                  child: ListTile(
                                    dense: true,
                                    title: Row(
                                      children: [
                                        Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          quranPageCtrl_.quranDetailList(quranPageCtrl_
                              .currentSelected.value + 1);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(130, 30),
                          backgroundColor:
                          Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4.0,
                        ),
                        child: Text(
                          "Go To Surah",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Theme
                                  .of(context)
                                  .primaryColor),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
