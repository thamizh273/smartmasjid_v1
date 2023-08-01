import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../widgets/gotoverse.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../../routes/app_pages.dart';
import '../controllers/quranpage_controller.dart';
import 'bookmark.dart';

class QuranpageView extends StatefulWidget {
  QuranpageView({Key? key}) : super(key: key);

  @override
  State<QuranpageView> createState() => _QuranpageViewState();
}

final QuranpageController c = Get.put(QuranpageController());

class _QuranpageViewState extends State<QuranpageView> {
  ScrollController scrollController = ScrollController();

  List<dynamic> get filteredSurah {
    final List<dynamic> quranChapterList = c
        .getqurandata.value.quranFilter!; // Replace with your actual surah list

    if (c.searchQuery.value.isEmpty) {
      return c.getqurandata.value
          .quranFilter!; // Return the original list when the search query is empty
    } else {
      // Filter the surah list based on the search query
      final lowercaseQuery = c.searchQuery.value.toLowerCase();
      final filteredList = quranChapterList.where((sura) {
        var quranChapterList = c.getqurandata.value.quranFilter!;
        return quranChapterList.contains(lowercaseQuery);
      }).toList();
      return filteredList;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (c.isSearchEnabled.value) {
            c.toggleSearch(); // Close search field
            return false; // Prevent back navigation
          }
          return true; // Allow back navigation
        },
        child: DefaultTabController(
            length: 2,
            child: Obx(() {
              return c.isLoadings.value
                  ? loading(context)
                  : Scaffold(
                  appBar: AppBar(
                    // backgroundColor: Color(0xff16627C),
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(
                              MaterialPageRoute(builder: (_) => HomeView()));
                        },
                        child:
                        // c.isSearchEnabled.value
                        //     ? null
                        //     :
                        SvgPicture.asset("assets/svg/backnew.svg",
                            fit: BoxFit.scaleDown,
                            color: c.isSearchEnabled.value? Colors.black : Colors.white )),
                    backgroundColor: c.isSearchEnabled.value
                        ? Colors.white
                        : Color(0xff16627C),
                    // backgroundColor: isSearchEnabled ? Colors.transparent : Color(0xff16627C),
                    title: Obx(() {
                      if (c.isSearchEnabled.value) {
                        return TextField(
                          keyboardType: TextInputType.text,
                          showCursor: true,
                          decoration: InputDecoration(
                              hintText: "Search Sura"
                          ),
                        );
                      } else {
                        return Text(
                          "Holy Quran",
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    }),
                    actions: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                c.toggleSearch(); // Toggle search field
                              },
                              icon: Icon(Icons.search),
                              color:c.isSearchEnabled.value? Colors.black: Colors.white
                          ),
                          // Image.asset(
                          //   "assets/images/bookmark.png",
                          //   width: 18,
                          // ),
                          Space(20)
                        ],
                      )
                    ],
                    bottom: c.isSearchEnabled.value
                        ? null
                        : TabBar(
                      tabs: [
                        Tab(
                          text: 'Surah',
                        ),
                        Tab(
                          text: 'Juz',
                        ),
                      ],
                    ),
                  ),
                  body: FrostedBottomBar(
                    width: 330.w,
                    opacity: .8,
                    sigmaX: 10,
                    sigmaY: 10,
                    bottomBarColor: Theme.of(context).colorScheme.primary,
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
                                          // onTap: () => c.openDrawer()
                                          onTap: () {
                                            GotoVerse(context);
                                          },
                                        ),
                                        Space(4),
                                        Text("Go To")
                                      ],
                                    ),
                                    Space(25),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (c.lastReadIndex != -1) {
                                              c.quranDetailList(
                                                  c.lastReadIndex + 1);
                                              c.scrollToCurrentIndex(
                                                  c.lastReadIndex);
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
                                        Text("Last Read")
                                      ],
                                    ),
                                    Space(25),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
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
                                        Text("Bookmarks")
                                      ],
                                    ),
                                    Space(25),
                                    Column(
                                      children: [
                                        Container(
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
                                        Space(4),
                                        Text("Notes")
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
                                    Text("Quick Links:"),
                                    Space(8),
                                    SizedBox(
                                      width: 280,
                                      height: 30,
                                      child: ListView.separated(
                                        // physics: NeverScrollablePhysics(),
                                          separatorBuilder:
                                              (BuildContext context,
                                              int index) =>
                                          const Space(8),
                                          itemCount: 7,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            var sura = [
                                              filteredSurah[35],
                                              filteredSurah[54],
                                              filteredSurah[17],
                                              filteredSurah[55],
                                              filteredSurah[66],
                                              filteredSurah[111],
                                              filteredSurah[112],
                                            ];
                                            return GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        4),
                                                    border: Border.all(
                                                        color: Theme.of(context)
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
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                print(
                                                    "ddd ${sura[index].suraNameEn}");
                                                if (sura[index].suraNameEn ==
                                                    "Ya-Sin") {
                                                  c.quranDetailList(36);
                                                } else if (sura[index]
                                                    .suraNameEn ==
                                                    'Ar-Rahman') {
                                                  c.quranDetailList(55);
                                                }else if (sura[index]
                                                    .suraNameEn ==
                                                    'Al-Kahf') {
                                                  c.quranDetailList(18);
                                                }
                                                else if (sura[index].suraNameEn ==
                                                    "Al-Waqi'ah") {
                                                  c.quranDetailList(56);
                                                }else if (sura[index]
                                                    .suraNameEn ==
                                                    'Al-Mulk') {
                                                  c.quranDetailList(67);
                                                }else if (sura[index]
                                                    .suraNameEn ==
                                                    'Al-Ikhlas') {
                                                  c.quranDetailList(112);
                                                }else if (sura[index]
                                                    .suraNameEn ==
                                                    'Al-Falaq') {
                                                  c.quranDetailList(113);
                                                } else {
                                                  c.quranDetailList(18);
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
                                  thumbVisibility: true,
                                  thickness: 10,
                                  controller: c.scrollController,
                                  radius: Radius.circular(20),
                                  child: ListView.builder(
                                    key: PageStorageKey<String>("page"),

                                    ///store the current page in the list items
                                    //  primary: true,
                                    padding: EdgeInsets.all(0),
                                    controller: c.scrollController,
                                    itemCount: filteredSurah.length,
                                    itemBuilder: (context, index) {
                                      var sura = filteredSurah[index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                            index < filteredSurah.length - 1
                                                ? 10.0
                                                : 0.0),
                                        child: Stack(children: [
                                          ListTile(
                                            minVerticalPadding: 0,
                                            dense: true,
                                            title: GestureDetector(
                                              onTap: () {
                                                print("mmmmmmmm ${index}");
                                                c.quranDetailList(index + 1);
                                                c.result.value=0.toString();
                                                c.passint.value = (index + 1);
                                                print("dddd${c.passint.value}");
                                                c.scrollToCurrentIndex(index);
                                                c.setLastReadIndex(index);
                                              },
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                heightFactor: 0.75,
                                                child: Container(
                                                  alignment:
                                                  Alignment.topCenter,
                                                  width: c.media.size.width -
                                                      c.padExtend / 2.0,
                                                  height: 80.h,
                                                  padding: EdgeInsets.all(
                                                      c.padExtend),
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
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Image(
                                                            image: "${sura.quranType}" ==
                                                                "Makki"
                                                                ? AssetImage(
                                                                'assets/images/makka.png')
                                                                : AssetImage(
                                                                'assets/images/madina.png'),
                                                            width: 18,
                                                          ),
                                                          Stxt(
                                                              text:
                                                              "${sura.quranType}",
                                                              size: f0)
                                                        ],
                                                      ),
                                                      Space(8),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(16),
                                                      //   child: Container(
                                                      //     width: 40.w,
                                                      //     height: 40.w,
                                                      //     child: Transform.rotate(
                                                      //       angle: 40 *
                                                      //           (3.1415926535897932 / 180),
                                                      //       // Converting 30 degrees to radians
                                                      //       child: Container(
                                                      //         width: 200,
                                                      //         height: 200,
                                                      //         decoration: BoxDecoration(
                                                      //           borderRadius: BorderRadius
                                                      //               .circular(8),
                                                      //           color: Color(0xff16627C),
                                                      //         ),
                                                      //         child: Center(
                                                      //           child: Transform.rotate(
                                                      //             angle: -40 *
                                                      //                 (3.1415926535897932 /
                                                      //                     180),
                                                      //             child: Text(
                                                      //               "${sura.suraChapterNo}",
                                                      //               style: TextStyle(
                                                      //                   fontSize: 15,
                                                      //                   fontWeight: FontWeight
                                                      //                       .bold,
                                                      //                   color: Colors.white),
                                                      //             ),
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   ),
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
                                                                  "${sura.suraChapterNo}"),
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
                                                            Text(
                                                              "${sura.suraNameEn}",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff16627C),
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                            Space(4),
                                                            SizedBox(
                                                              width: 100.w,
                                                              child: Stxt(
                                                                text:
                                                                "${sura.titleEn}",
                                                                size: f1,
                                                                color: Color(
                                                                    0xff16627C),
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                          ],
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
                                                      Image.asset("assets/images/alltext.png", color: Colors.black, scale: 12,),
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
                                                              "${sura.totalVerses}",
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
                                  ),
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
                                  thumbVisibility: true,
                                  thickness: 10,
                                  controller: c.scrollControllerjuz,
                                  radius: Radius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(0),
                                      controller: c.scrollControllerjuz,
                                      itemCount: c.getquranjuz.value
                                          .getQuranJuzChapter!.length,
                                      itemBuilder: (context, index) {
                                        var juz = c.getquranjuz.value
                                            .getQuranJuzChapter![index];
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: index <
                                                  filteredSurah.length - 1
                                                  ? 10.0
                                                  : 0.0),
                                          child: Stack(children: [
                                            ListTile(
                                              minVerticalPadding: 0,
                                              dense: true,
                                              title: GestureDetector(
                                                onTap: () {
                                                  // print("mmmmmmmm ${index}");
                                                  // c.quranDetailList(
                                                  //     index + 1);
                                                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuranDetails()));
                                                },
                                                child: Align(
                                                  alignment:
                                                  Alignment.topCenter,
                                                  heightFactor: 0.75,
                                                  child: Container(
                                                    alignment:
                                                    Alignment.topCenter,
                                                    width: c.media.size.width -
                                                        c.padExtend / 2.0,
                                                    height: 80.h,
                                                    padding: EdgeInsets.all(
                                                        c.padExtend),
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
                                                                    "${juz.juzChapterNo}"),
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
                                                                c.screenWidth *
                                                                    0.4,
                                                                child: Text(
                                                                  "${juz.juzNameEn}",
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
                                                        Align(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              Obx(() {
                                                                double
                                                                fontSize =
                                                                20.0;
                                                                TextStyle
                                                                textStyle =
                                                                TextStyle(
                                                                  fontSize:
                                                                  fontSize,
                                                                  fontFamily: c
                                                                      .fontFamily
                                                                      .value ==
                                                                      "indopak"
                                                                      ? "Indopak"
                                                                      : c.fontFamily.value ==
                                                                      "qalam"
                                                                      ? "Qalam"
                                                                      : c.fontFamily.value == "uthami"
                                                                      ? "Uthami"
                                                                      : c.fontFamily.value == "amiri"
                                                                      ? "Amiri"
                                                                      : c.fontFamily.value == "noorehira"
                                                                      ? "Noorehira"
                                                                      : c.fontFamily.value == "noorehuda"
                                                                      ? "Noorehuda"
                                                                      : c.fontFamily.value == "noorehidayat"
                                                                      ? "Noorehidayat"
                                                                      : c.fontFamily.value == "arabictitle"
                                                                      ? "Arabictitle"
                                                                      : null, // Use the default font if "Amiri" is not selected
                                                                );
                                                                return SizedBox(
                                                                  width: 65.w,
                                                                  child: c.isCheckedArabic
                                                                      .value ==
                                                                      true
                                                                      ? Text(
                                                                    "${juz.juzNameArb}",
                                                                    style:
                                                                    textStyle,
                                                                    textAlign:
                                                                    TextAlign.end,
                                                                  )
                                                                      : SizedBox(),
                                                                );
                                                              }),
                                                            ],
                                                          ),
                                                        ),
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
                                                                "${juz.totalVerses}",
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
                                    ),
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