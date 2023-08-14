import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/controllers/quranpage_controller.dart';
import 'package:smartmasjid_v1/widgets/space.dart';

import '../app/modules/quranpage/views/qurandetails.dart';

final QuranpageController c = Get.put(QuranpageController());

Future GotoVerse(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor:
    Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xff16627C),
            borderRadius:
            BorderRadius.only(
                topLeft: Radius
                    .circular(32),
                topRight: Radius
                    .circular(
                    32))),
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
                      alignment: Alignment
                          .bottomCenter,
                      height: 60,
                      child:
                      GestureDetector(
                        onTap: () {
                          // getQuranChaptersList();
                        },
                        child: Text(
                          'Surah',
                          style:
                          TextStyle(
                              color: Colors
                                  .white,
                              fontSize:
                              20.0,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    Space(2),
                    Container(
                      alignment: Alignment
                          .bottomCenter,
                      height: 60,
                      child:
                      GestureDetector(
                        onTap: () {
                          // getQuranChaptersList();
                        },
                        child: Text(
                          'Ayah',
                          style:
                          TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600
                          ),
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
                          style:
                          TextStyle(
                              color: Colors
                                  .white,
                              fontSize:
                              20.0,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    // Space(1)
                  ],
                ),
              ),
              Space(16),

              Row(
                children: [
                  Obx(() {
                    return SizedBox(
                      width: c.screenWidth * 0.43,
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
                            ListWheelScrollView.useDelegate(
                              controller: FixedExtentScrollController(
                                initialItem: c.getqurandata.value.quranFilter!
                                    .length *
                                    100, // Initial item index for continuous scrolling
                              ),
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: c.getqurandata.value.quranFilter!
                                    .length * 200,
                                builder: (BuildContext context, int index) {
                                  var adjustedIndex = index % c.getqurandata.value.quranFilter!.length;
                                  var sura = c.getqurandata.value.quranFilter![adjustedIndex].suraNameEn;
                                  var chap = c.getqurandata.value.quranFilter![adjustedIndex].suraChapterNo;
                                  return Container(
                                    child:
                                    ListTile(
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
                              useMagnifier: true,
                              magnification: 1.1,
                              diameterRatio: 3,
                              itemExtent: 50,
                              onSelectedItemChanged: (adjustedIndex) {
                                // Handle selected day change
                                c.currentSelected.value = adjustedIndex  % c.getqurandata.value.quranFilter!.length;
                                // c.currentVerseSelected.value = -1;
                              },
                              physics: FixedExtentScrollPhysics(),
                            ),

                          ]
                      ),

                    );
                  }),
                  Obx(() {
                    return SizedBox(
                      width: c.screenWidth * 0.17,
                      height: 250.h,
                      child: Stack(
                          children: [
                            Positioned.fill(
                              child: Center(
                                child: Container(
                                  width: 100, // Adjust the width as needed
                                  height: 40, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                              ),
                            ),
                            ListWheelScrollView.useDelegate(
                              controller: FixedExtentScrollController(
                                initialItem:(
                                    int.parse(
                                        "${c.getqurandata.value.quranFilter![c.currentSelected.value].totalVerses}") * 100),
                              ),
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: c.currentSelected.value ==
                                    c.currentSelected.value
                                    ? int.parse(
                                    "${c.getqurandata.value.quranFilter![c
                                        .currentSelected.value].totalVerses}") * 200 : 0,

                                builder: (BuildContext context, int index) {
                                  var adjustedIndex = index % int.parse(
                                      "${c.getqurandata.value.quranFilter![c.currentSelected.value].totalVerses}" );
                                  return ListTile(
                                    dense: false,
                                    title: Center(
                                      child: Text(
                                        (adjustedIndex + 1).toString(),
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              useMagnifier: true,
                              magnification: 1.2,
                              diameterRatio: 3,
                              itemExtent: 50,
                              onSelectedItemChanged: (adjustedIndex) {

                              },
                              physics: FixedExtentScrollPhysics(),
                            ),
                          ]
                      ),
                    );
                  }),
                  SizedBox(
                    width: c.screenWidth * 0.31,
                    height: 250.h,
                    child: Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Container(
                                width: 100, // Adjust the width as needed
                                height: 40, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ),
                          ),
                          ListWheelScrollView.useDelegate(
                            controller: FixedExtentScrollController(
                              initialItem:c.pages.length*1 ),// Initial item index for continuous scrolling
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: c.pages.length*2,
                              builder: (BuildContext context, int index) {
                               
                                return ListTile(
                                  dense: false,
                                  title: Center(
                                    child:
                                    Text(
                                      c.pages[index%c.pages.length]['no'].toString(),
                                      style:
                                      TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  onTap:
                                      () {

                                    // Handle item tap event
                                  },
                                );
                              },
                            ),
                            useMagnifier: true,
                            magnification: 1.2,
                            diameterRatio: 3,
                            itemExtent: 50,
                            onSelectedItemChanged: (adjustedIndex) {
                           print(adjustedIndex);

                            },
                            physics: FixedExtentScrollPhysics(),
                          ),
                        ]
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuranDetails()));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(130, 30),
                            backgroundColor: Theme
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


