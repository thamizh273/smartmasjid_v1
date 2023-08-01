

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/widgets/space.dart';

import '../app/modules/quranpage/views/qurandetails.dart';

Future GotoVerse (BuildContext context) {
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
        child: Row(
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
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: false,
                      interactive: true,
                      thickness: 8,
                      controller: c.scrollControllerbot,
                      radius: Radius
                          .circular(
                          20),
                      child: ListView
                          .builder(
                        controller: c.scrollControllerbot,
                        itemCount: c
                            .getqurandata
                            .value
                            .quranFilter!
                            .length,
                        itemBuilder:
                            (context,
                            index) {
                          var sura = c
                              .getqurandata
                              .value
                              .quranFilter![index];
                          return Obx(
                                  () {
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
                                          "${index + 1}.",
                                          style: TextStyle(
                                            color: c.currentSelected.value == index ? Color(0xff16627C) : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${sura.suraNameEn}",
                                          style: TextStyle(
                                            color: c.currentSelected.value == index ? Color(0xff16627C) : Colors.white,
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
                      ),
                    ),
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
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
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
                            "${c.getqurandata.value.quranFilter![c.currentSelected.value].totalVerses}")
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
                  Expanded(
                    child: Scrollbar(
                      interactive: true,
                      isAlwaysShown:
                      true,
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
                        itemCount: c.currentSelected
                            .value ==
                            c.currentSelected
                                .value
                            ? int.parse(
                            "${c.getqurandata.value.quranFilter![c.currentSelected.value].totalVerses}")
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
          ],
        ),
      );
    },
  );
}
