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
        child: Column(
          children: [
            Row(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                SizedBox(
                  width: 170.w,
                  child: Column(
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
                            ),
                          ),
                        ),
                      ),
                      Space(20),
                      SizedBox(
                          height: c.screenWidth * 0.8,
                          child: ListView.builder(
                            controller: c.scrollControllern,
                            itemCount: c.getqurandata.value.quranFilter!.length,
                            itemBuilder:
                                (context,
                                index) {
                              var sura = c.getqurandata.value
                                  .quranFilter![index].suraNameEn;
                              var chap = c.getqurandata.value
                                  .quranFilter![index].suraChapterNo;
                              return Obx(() {
                                return Container(
                                  // Replace this with your color logic
                                  color: c.currentSelected.value ==
                                      index
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff16627C),
                                  child:
                                  ListTile(
                                    dense:
                                    true,
                                    title:
                                    Row(
                                      children: [
                                        Text(
                                          chap!,
                                          style: TextStyle(
                                            color: c.currentSelected.value ==
                                                index
                                                ? Color(0xff16627C)
                                                : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          sura!,
                                          style: TextStyle(
                                            color: c.currentSelected.value ==
                                                index
                                                ? Color(0xff16627C)
                                                : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap:
                                        () {
                                      c.currentSelected.value =
                                          index;
                                      c.update();
                                    },
                                  ),
                                );
                              });
                            },
                          )
                      ),
                    ],
                  ),
                ),
                // VerticalDivider(width: 1,
                //     color: Colors.black),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment
                            .bottomCenter,
                        height: 60,
                        child: Text(
                          'Ayah',
                          style:
                          TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                            20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: c.screenWidth * 0.84,
                        child: Scrollbar(
                          thumbVisibility: false,
                          interactive: true,
                          thickness: 8,
                          controller: c.scrollControllerbot1,
                          radius: Radius
                              .circular(
                              20),
                          child: ListView
                              .builder(
                            controller: c
                                .scrollControllerbot1,
                            shrinkWrap:
                            true,
                            itemCount: c.currentSelected
                                .value ==
                                c.currentSelected
                                    .value
                                ? int.parse(
                                "${c.getqurandata.value.quranFilter![c
                                    .currentSelected.value].totalVerses}")
                                : 0,
                            itemBuilder:
                                (context,
                                index) {
                              // Replace this with your data item
                              return ListTile(
                                dense:
                                false,
                                title:
                                Center(
                                  child:
                                  Text(
                                    (index + 1)
                                        .toString(),
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
                        ),
                      ),
                    ],
                  ),
                ),
                // VerticalDivider(width: 1,
                //     color: Colors.black),
                Space(16),
                SizedBox(
                  width: 60.w,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment
                            .bottomCenter,
                        height: 60,
                        child: Text(
                          'Pages',
                          style:
                          TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                            20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: c.screenWidth * 0.84,
                        child: Scrollbar(
                          interactive: true,
                          thumbVisibility: false,
                          thickness: 8,
                          controller: c.scrollControllerbot2,
                          radius: Radius
                              .circular(
                              20),
                          child: ListView
                              .builder(
                            controller: c
                                .scrollControllerbot2,
                            shrinkWrap:
                            true,
                            itemCount: 604,
                            itemBuilder:
                                (context,
                                index) {
                              final circularIndex = index %
                                  (604);
                              return ListTile(
                                dense:
                                false,
                                title:
                                Center(
                                  child:
                                  Text(
                                    (circularIndex + 1).toString(),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    var sura = c.getqurandata.value
                        .quranFilter![0].suraNameEn;
                    return ElevatedButton(
                        onPressed: () {

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
                        ));
                  }),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
