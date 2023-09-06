
import 'dart:ffi';

import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/notes.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/quran_juz_details.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import '../../../../global.dart';
import '../../../../widgets/gotoverse.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';
import '../controllers/quranpage_controller.dart';
import 'bookmark.dart';

class QuranpageView extends StatelessWidget {
  QuranpageView({Key? key}) : super(key: key);

  final quranCtrl = Get.put(QuranpageController());


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (quranCtrl.isSearchEnabled.value) {
          quranCtrl.clearSearch(); // Close search field
          return false; // Prevent back navigation
        }
        return true; // Allow back navigation
      },
      child: DefaultTabController(
        length: 2,
        child: Obx(() {
          return quranCtrl.isLoadings0.value
              ? loading(context)
              : Scaffold(
              appBar: AppBar(
                // backgroundColor: Color(0xff16627C),
                leading: GestureDetector(
                    onTap: () {
                      if (quranCtrl.isSearchEnabled.value) {
                        quranCtrl
                            .clearSearch(); // Clear search and show all items
                      } else {
                        // quranCtrl.toggleSearch(); // Toggle search field
                        Navigator.of(context).pop(MaterialPageRoute(builder: (
                            _) => HomeView()));
                      }
                    },
                    child: SvgPicture.asset("assets/svg/backnew.svg",
                        fit: BoxFit.scaleDown,
                        color: quranCtrl.isSearchEnabled.value
                            ? Colors.black
                            : Colors
                            .white)),
                backgroundColor: quranCtrl.isSearchEnabled.value
                    ? Colors.white
                    : Color(0xff16627C),
                // backgroundColor: isSearchEnabled ? Colors.transparent : Color(0xff16627C),
                title: Obx(() {
                  if (quranCtrl.isSearchEnabled.value) {
                    return TextField(
                      // controller: TextEditingController(text: quranCtrl.isSearchEnabled.value ? quranCtrl.savedSearchQuery.value : ''), // Set the initial text
                      controller: quranCtrl.searchController,
                      keyboardType: TextInputType.text,
                      showCursor: true,
                      decoration: InputDecoration(
                          hintText: "search_sura".tr
                      ),
                      onChanged: (value) {
                        quranCtrl.searchQuery.value = value;
                        quranCtrl.savedSearchQuery.value =
                            value; // Save the search query
                        quranCtrl.filterItems();
                        quranCtrl.filterjuzItems();
                      },
                    );
                  } else {
                    return Text(
                      "holy_quran".tr,
                      style: TextStyle(color: Colors.white),
                    );
                  }
                }),
                actions: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (quranCtrl.isSearchEnabled.value) {
                              quranCtrl
                                  .clearSearch(); // Clear search and show all items
                            } else {
                              quranCtrl.toggleSearch(); // Toggle search field
                            }
                          },
                          icon: quranCtrl.isSearchEnabled.value
                              ? Icon(Icons.close)
                              : Icon(Icons.search),
                          color: quranCtrl.isSearchEnabled.value
                              ? Colors.black
                              : Colors
                              .white
                      ),
                      // Image.asset(
                      //   "assets/images/bookmark.png",
                      //   width: 18,
                      // ),
                      Space(20)
                    ],
                  )
                ],
                bottom: quranCtrl.isSearchEnabled.value
                    ? null
                    : TabBar(
                  tabs: [
                    Tab(
                      text: 'surah'.tr,
                    ),
                    Tab(
                      text: 'juz'.tr,
                    ),
                  ],
                ),
              ),
              body: FrostedBottomBar(
                width: 330.w,
                opacity: .8,
                sigmaX: 10,
                sigmaY: 10,
                bottomBarColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                borderRadius: BorderRadius.circular(500),
                duration: const Duration(milliseconds: 800),
                hideOnScroll: true,
                body: (BuildContext context, ScrollController controller) {
                  return TabBarView(children: [
                    Center(
                      child: Column(
                        children: [
                          Space(16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                8.horizontalSpace,
                                Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff16627C),
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/images/goto.png",
                                            width: 25,
                                          ),
                                        ),

                                        // Row(
                                        //   children: [
                                        //     Space(8),
                                        //     Text(
                                        //         "Go to verse", style: TextStyle(
                                        //         color: Colors.white)),
                                        //     Space(8),
                                        //
                                        //   ],
                                        // ),
                                      ),
                                      // onTap: () => quranCtrl.openDrawer()
                                      onTap: () {
                                        GotoVerse(context);
                                      },
                                    ),
                                    Space(4),
                                    Text("go_to".tr)
                                  ],
                                ),
                                Space(25),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (quranCtrl.lastReadIndex != -1) {
                                          quranCtrl.quranDetailList(
                                              quranCtrl.lastReadIndex + 1);
                                          // quranCtrl.scrollToCurrentIndex(
                                          //     quranCtrl.lastReadIndex);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff16627C),
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/images/lastread.png",
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Space(4),
                                    Text("last_read".tr)
                                  ],
                                ),
                                Space(25),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(Bookmark());
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff16627C),
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/images/bookmark.png",
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Space(4),
                                    Text("book".tr)
                                  ],
                                ),
                                Space(25),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => QuranNotes()));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff16627C),
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/images/notes.png",
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Space(4),
                                    Text("notes".tr)
                                  ],
                                ),
                                8.horizontalSpace
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("quick_links:".tr),
                                Space(8),
                                SizedBox(
                                  width: 260.w,
                                  height: 30,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      // physics: NeverScrollablePhysics(),
                                      separatorBuilder:
                                          (BuildContext context,
                                          int index) =>
                                      const Space(8),
                                      itemCount: 7,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var sura = [
                                          quranCtrl.getqurandata.value
                                              .quranFilter![35],
                                          quranCtrl.getqurandata.value
                                              .quranFilter![54],
                                          quranCtrl.getqurandata.value
                                              .quranFilter![17],
                                          quranCtrl.getqurandata.value
                                              .quranFilter![55],
                                          quranCtrl.getqurandata.value
                                              .quranFilter![66],
                                          quranCtrl.getqurandata.value
                                              .quranFilter![111],
                                          quranCtrl.getqurandata.value
                                              .quranFilter![112],
                                        ];
                                        return GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                                border: Border.all(
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor)),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(4.0),
                                              child: Text(
                                                "${sura[index].suraNameEn}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            print(
                                                "ddd ${sura[index]
                                                    .suraNameEn}");
                                            if (sura[index].suraNameEn ==
                                                "Ya-Sin") {
                                              quranCtrl.quranDetailList(36);
                                            } else if (sura[index]
                                                .suraNameEn ==
                                                'Ar-Rahman') {
                                              quranCtrl.quranDetailList(55);
                                            } else if (sura[index]
                                                .suraNameEn ==
                                                'Al-Kahf') {
                                              quranCtrl.quranDetailList(18);
                                            }
                                            else if (sura[index].suraNameEn ==
                                                "Al-Waqi'ah") {
                                              quranCtrl.quranDetailList(56);
                                            } else if (sura[index]
                                                .suraNameEn ==
                                                'Al-Mulk') {
                                              quranCtrl.quranDetailList(67);
                                            } else if (sura[index]
                                                .suraNameEn ==
                                                'Al-Ikhlas') {
                                              quranCtrl.quranDetailList(112);
                                            } else if (sura[index]
                                                .suraNameEn ==
                                                'Al-Falaq') {
                                              quranCtrl.quranDetailList(113);
                                            } else {
                                              quranCtrl.quranDetailList(18);
                                            }
                                          },
                                        );
                                      }),
                                ),

                                // Space(8),
                                // Container(
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(
                                //           4),
                                //       border: Border.all(color: Theme
                                //           .of(context)
                                //           .primaryColor)
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(4.0),
                                //     child: Text("Ar Rahaman",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 14,
                                //           color: Theme
                                //               .of(context)
                                //               .primaryColor),),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Space(8),
                          Expanded(
                            child: Scrollbar(
                              interactive: true,
                              // thumbVisibility: true,
                              thickness: 10,
                              controller: quranCtrl.scrollController,
                              radius: Radius.circular(20),
                              child: Obx(() {
                                return quranCtrl.isLoadings.value ? loading(
                                    context) : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  key: PageStorageKey<String>("page"),

                                  ///store the current page in the list items
                                  //  primary: true,
                                  padding: EdgeInsets.all(0),
                                  controller: quranCtrl.scrollController,
                                  itemCount: quranCtrl.filteredItems.length,
                                  itemBuilder: (context, index) {
                                    var sura = quranCtrl.filteredItems[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                          index <
                                              quranCtrl.filteredItems.length - 1
                                              ? 10.0
                                              : 0.0),
                                      child: Stack(children: [
                                        ListTile(
                                          minVerticalPadding: 0,
                                          dense: true,
                                          title: GestureDetector(
                                            onTap: () {
                                              print("mmmmmmmm ${index}");
                                              quranCtrl.quranDetailList(
                                                  index + 1);
                                              quranCtrl.qurandetsilIndex.value =
                                              (index + 1);
                                              quranCtrl.result.value =
                                                  0.toString();
                                              quranCtrl.passint.value =
                                              (index + 1);
                                              print("dddd${quranCtrl.passint
                                                  .value}");
                                              // quranCtrl.scrollToCurrentIndex(index);
                                              quranCtrl.setLastReadIndex(index);
                                            },
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              heightFactor: 0.75,
                                              child: Container(
                                                alignment:
                                                Alignment.topCenter,
                                                width: quranCtrl.media.size
                                                    .width -
                                                    quranCtrl.padExtend / 2.0,
                                                height: 80.h,
                                                padding: EdgeInsets.all(
                                                    quranCtrl.padExtend),
                                                // width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    // topRight: Radius.circular(8),
                                                    topLeft:
                                                    Radius.circular(12),
                                                    topRight:
                                                    Radius.circular(12),
                                                    // bottomRight: Radius.circular(12),
                                                    // bottomLeft: Radius.circular(12),
                                                  ),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      blurRadius: 5.0,
                                                      spreadRadius: 2.0,
                                                      offset: Offset(0, -4),
                                                    ),
                                                  ],
                                                  // border: Border.all(
                                                  //     color: Color(0xff16627C)
                                                  // )
                                                ),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          height: 48.h,
                                                          width: 50.h,
                                                          decoration:
                                                          BoxDecoration(
                                                            // color: Colors.red,
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/quranneww.png"),
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            child: Text(
                                                                sura
                                                                    .suraChapterNo!),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Space(8),
                                                    SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            bottom: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              ('sura_name_en_${sura.suraNameEn}').tr,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff16627C),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                            Space(4),
                                                            Row(
                                                              children: [
                                                                Image(
                                                                  image: sura
                                                                      .quranType! ==
                                                                      "Makki"
                                                                      ? AssetImage(
                                                                      'assets/images/makka.png')
                                                                      : AssetImage(
                                                                      'assets/images/madina.png'),
                                                                  width: 11,
                                                                ),
                                                                Space(8),
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child: Stxt(
                                                                   // text:langCtrl.selectedLang.value=="ENGLISH"?"${sura.titleEn}":sura.titleTamil.toString(),
                                                                 text: ("sura_name_title_${sura.titleEn}").tr,
                                                                    size: f1,
                                                                    color: Color(
                                                                        0xff16627C),
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    // Align(
                                                    //   child: Row(
                                                    //     crossAxisAlignment:
                                                    //         CrossAxisAlignment
                                                    //             .center,
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .end,
                                                    //     children: [
                                                    //       Obx(() {
                                                    //         double fontSize =
                                                    //             20.0;
                                                    //         TextStyle
                                                    //             textStyle =
                                                    //             TextStyle(
                                                    //           fontSize:
                                                    //               fontSize,
                                                    //           fontFamily: c
                                                    //                       .fontFamily
                                                    //                       .value ==
                                                    //                   "indopak"
                                                    //               ? "Indopak"
                                                    //               : c.fontFamily.value ==
                                                    //                       "qalam"
                                                    //                   ? "Qalam"
                                                    //                   : c.fontFamily.value ==
                                                    //                           "uthami"
                                                    //                       ? "Uthami"
                                                    //                       : c.fontFamily.value == "amiri"
                                                    //                           ? "Amiri"
                                                    //                           : c.fontFamily.value == "noorehira"
                                                    //                               ? "Noorehira"
                                                    //                               : c.fontFamily.value == "noorehuda"
                                                    //                                   ? "Noorehuda"
                                                    //                                   : c.fontFamily.value == "noorehidayat"
                                                    //                                       ? "Noorehidayat"
                                                    //                                       : c.fontFamily.value == "arabictitle"
                                                    //                                           ? "Arabictitle"
                                                    //                                           : null, // Use the default font if "Amiri" is not selected
                                                    //         );
                                                    //         return SizedBox(
                                                    //           child: c.isCheckedArabic
                                                    //                       .value ==
                                                    //                   true
                                                    //               ? Text(
                                                    //                   "${sura.titleArabic}",
                                                    //                   style:
                                                    //                       textStyle,
                                                    //                   textAlign:
                                                    //                       TextAlign.end,
                                                    //                 )
                                                    //               : SizedBox(),
                                                    //         );
                                                    //       }),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // Space(8),
                                                    for(var q in quranCtrl
                                                        .images)
                                                      (q['sura']
                                                          .toString()
                                                          .contains(
                                                          sura
                                                              .suraNameEn as Pattern))
                                                          ?
                                                      Image.asset(
                                                        "${q['image']}",
                                                        color: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        scale: 10,)
                                                          : Container(),
                                                    Space(8),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          right: 8,
                                                          bottom: 8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/bookmarkout.png",
                                                            width: 16,
                                                          ),
                                                          Space(8),
                                                          Text(
                                                            "${sura
                                                                .totalVerses}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff16627C),
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                          Space(80)
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: Scrollbar(
                              interactive: true,
                              // thumbVisibility: true,
                              thickness: 10,
                              controller: quranCtrl.scrollControllerjuz,
                              radius: Radius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Obx(() {
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    key: PageStorageKey<String>("page"),
                                    padding: EdgeInsets.all(0),
                                    controller: quranCtrl.scrollControllerjuz,
                                    itemCount: quranCtrl.filteredjuzItems
                                        .length,
                                    itemBuilder: (context, index) {
                                      var juz = quranCtrl
                                          .filteredjuzItems[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: index <
                                                quranCtrl.filteredjuzItems
                                                    .length - 1
                                                ? 10.0
                                                : 0.0),
                                        child: Stack(children: [
                                          ListTile(
                                            minVerticalPadding: 0,
                                            dense: true,
                                            title: GestureDetector(
                                              onTap: () {
                                                print("mmmmmmmm ${index}");

                                                quranCtrl.quranjuzdetailList(
                                                    index + 1);
                                                quranCtrl.qurandetsilIndex
                                                    .value = (index + 1);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            QuranJuzDetails()));
                                              },
                                              child: Align(
                                                alignment:
                                                Alignment.topCenter,
                                                heightFactor: 0.75,
                                                child: Container(
                                                  alignment:
                                                  Alignment.topCenter,
                                                  width: quranCtrl.media.size
                                                      .width -
                                                      quranCtrl.padExtend / 2.0,
                                                  height: 80.h,
                                                  padding: EdgeInsets.all(
                                                      quranCtrl.padExtend),
                                                  // width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      // topRight: Radius.circular(8),
                                                      topLeft:
                                                      Radius.circular(12),
                                                      topRight:
                                                      Radius.circular(12),
                                                      // bottomRight: Radius.circular(12),
                                                      // bottomLeft: Radius.circular(12),
                                                    ),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        blurRadius: 5.0,
                                                        spreadRadius: 2.0,
                                                        offset: Offset(0, -4),
                                                      ),
                                                    ],
                                                    // border: Border.all(
                                                    //     color: Color(0xff16627C)
                                                    // )
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      // Column(
                                                      //   mainAxisAlignment: MainAxisAlignment
                                                      //       .center,
                                                      //   children: [
                                                      //     Image(
                                                      //       image: "${sura
                                                      //           .quranType}" ==
                                                      //           "Makki"
                                                      //           ? AssetImage(
                                                      //           'assets/images/makka.png')
                                                      //           : AssetImage(
                                                      //           'assets/images/madina.png'),
                                                      //       width: 18,
                                                      //     ),
                                                      //     Stxt(text: "${juz.quranType}", size: f0)
                                                      //   ],
                                                      // ),
                                                      // Space(8),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Container(
                                                            height: 48.h,
                                                            width: 50.h,
                                                            decoration:
                                                            BoxDecoration(
                                                              // color: Colors.red,
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/quranneww.png"),
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                              Alignment
                                                                  .center,
                                                              child: Text(
                                                                  "${juz
                                                                      .juzChapterNo!}"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Space(8),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            bottom: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                              quranCtrl
                                                                  .screenWidth *
                                                                  0.3,
                                                              child: Text(
                                                                juz.juzNameEn!,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff16627C),
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                              ),
                                                            ),
                                                            Space(4),
                                                            // Stxt(
                                                            //   text: "The Opening",
                                                            //   size: f1,
                                                            //   color: Color(
                                                            //       0xff16627C),
                                                            //   maxLines: 1,),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      for(var j in quranCtrl
                                                          .juz)
                                                        (j['juz']
                                                            .toString()
                                                            .contains(juz
                                                            .juzNameEn as Pattern))
                                                            ?
                                                        Image.asset(
                                                          "${j['image']}",
                                                          color: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          scale: 16,)
                                                            : Container(),
                                                      Space(4),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            right: 8,
                                                            bottom: 8),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/bookmarkout.png",
                                                              width: 16,
                                                            ),
                                                            Space(8),
                                                            Text(
                                                              "${juz
                                                                  .totalVerses}",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff16627C),
                                                                  fontSize:
                                                                  12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ),
                          ),
                          Space(80),
                        ],
                      ),
                    ),
                  ]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/svg/masjidbot.svg"),
                      Space(8),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.QURANPAGE);
                          },
                          child:
                          SvgPicture.asset("assets/svg/quranbot.svg")),
                      Space(8),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (_) => HomeView()));
                          },
                          child:
                          SvgPicture.asset("assets/svg/homebot.svg")),
                      Space(8),
                      SvgPicture.asset("assets/svg/mediabot.svg"),
                      Space(8),
                      SvgPicture.asset("assets/svg/donatebot.svg"),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
