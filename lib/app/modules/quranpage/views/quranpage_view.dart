import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../../routes/app_pages.dart';
import '../controllers/quranpage_controller.dart';

class QuranpageView extends StatefulWidget {

  QuranpageView({Key? key}) : super(key: key);

  @override
  State<QuranpageView> createState() => _QuranpageViewState();
}
final QuranpageController c = Get.put(QuranpageController());
class _QuranpageViewState extends State<QuranpageView> {

  ScrollController scrollController = ScrollController();
  final List<dynamic> items = [];

  List<Surah> suraList = [
    Surah(name: "Al Fatihah", chapterno: "1", verses: "7")
  ];

  List<dynamic> get filteredSurah {
    final List<dynamic> quranChapterList = c.getqurandata.value
        .quranFilter!; // Replace with your actual surah list

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
    final filteredItems = items.where((item) =>
        item.toLowerCase().contains(c.searchQuery.value.toLowerCase()))
        .toList();
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
          return c.isLoadings.value ? loading(context) : Scaffold(
              // key: c.scaffoldKey,
              drawer: Drawer(
                width: 250.w,
                backgroundColor: Color(0xff16627C),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 170.w,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 60.h,
                            child: GestureDetector(
                              onTap: () {
                                // getQuranChaptersList();
                              },
                              child: Text(
                                'Surah',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
                              isAlwaysShown: true,
                              thickness: 8,
                              controller: c.scrollController,
                              radius: Radius.circular(20),
                              child:
                              ListView.builder(
                                  controller: c.scrollController,
                                  // shrinkWrap: true,
                                  itemCount: c.getqurandata.value.quranFilter!
                                      .length,
                                  itemBuilder: (context, index) {
                                    var sura = c.getqurandata.value
                                        .quranFilter![index];
                                    return Obx(() {
                                      return Container(
                                        color: c.currentSelected.value == index
                                            ? Color(
                                            0xffEBEBEB)
                                            : Color(0xff16627C),
                                        child: ListTile(
                                          dense: true,
                                          title: Row(
                                            children: [
                                              Text("${sura.suraChapterNo}.",
                                                  style: TextStyle(
                                                      color: c.currentSelected
                                                          .value == index
                                                          ? Color(0xff16627C)
                                                          : Colors.white,
                                                      fontSize: 15)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("${sura.suraNameEn}",
                                                  style: TextStyle(
                                                      color: c.currentSelected
                                                          .value ==
                                                          index
                                                          ? Color(0xff16627C)
                                                          : Colors.white,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                          onTap: () {
                                            // getQuranChaptersList();
                                            // setState(() {
                                            //   _currentSelected = index;
                                            // });
                                            c.currentSelected.value = index;
                                            c.update();
                                          },
                                        ),
                                      );
                                    });
                                  }

                              ),


                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(width: 1, color: Colors.black,),
                    SizedBox(
                      width: 60.w,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 60.h,
                            child: Text(
                              'Ayah',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
                              isAlwaysShown: true,
                              thickness: 8,
                              controller: c.scrollController,
                              radius: Radius.circular(20),
                              child: ListView.builder(
                                  controller: c.scrollController,
                                  shrinkWrap: true,
                                  itemCount: c.currentSelected.value ==
                                      c.currentSelected.value
                                      ? int.parse(
                                      "${c.getqurandata.value.quranFilter![c
                                          .currentSelected.value].totalVerses}")
                                      : 0,
                                  itemBuilder: (context, index) {
                                    // var sura = c.getqurandata.value.quranFilter![index];
                                    return ListTile(
                                      dense: false,
                                      title: Center(
                                          child: Text((index + 1).toString(),
                                            style: TextStyle(
                                                color: Colors.white),)),
                                      onTap: () {
                                        // Handle item 1 tap
                                      },
                                    );
                                  }
                                // children: [
                                //
                                //   ListTile(
                                //     dense: true,
                                //     title: Text('2',style: TextStyle(color: Colors.white),),
                                //     onTap: () {
                                //       // Handle item 2 tap
                                //     },
                                //   ),
                                // ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                // backgroundColor: Color(0xff16627C),
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(
                          MaterialPageRoute(builder: (_) => HomeView()));
                    },
                    child: c.isSearchEnabled.value ? null : SvgPicture.asset(
                        "assets/svg/backnew.svg", fit: BoxFit.scaleDown)),
                backgroundColor: c.isSearchEnabled.value
                    ? Color(0xff16627C)
                    : Color(0xff16627C),
                // backgroundColor: isSearchEnabled ? Colors.transparent : Color(0xff16627C),
                title: Obx(() {
                  if (c.isSearchEnabled.value) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: TextField(
                        autofocus: false,
                        // textInputAction: TextInputAction.search,
                        style: TextStyle(color: Theme
                            .of(context)
                            .colorScheme
                            .primary, fontWeight: FontWeight.w600),
                        // textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          hintText: 'Search',
                          // label: Text("Search by Masjid Name", style: TextStyle(fontSize: 12),),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              // Change the border color for focused state
                              width: 2.0, // Change the border width for focused state
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          // suffixIcon: Padding(
                          //   padding: const EdgeInsets.only(right: 10, bottom: 1),
                          //   child: IconButton(onPressed: (){
                          //   }, icon: Icon(Icons.search, size: 25,),
                          //   ),
                          // ),
                        ),
                        onChanged: (value) {
                          c.searchQuery.value = value;
                        },
                        // onSubmitted: (value) {
                        //   if (value.isEmpty) {
                        //     _textEditingController.clear();
                        //     FocusScope.of(context).unfocus();
                        //   }
                        // },
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
                        color: Colors.white,
                      ),
                      Image.asset("assets/images/bookmark.png", width: 18,),
                      Space(20)
                    ],
                  )
                ],
                bottom: c.isSearchEnabled.value ? null : TabBar(
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
                bottomBarColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                borderRadius: BorderRadius.circular(500),
                duration: const Duration(milliseconds: 800),
                hideOnScroll: true,
                body: (BuildContext context, ScrollController controller) {
                  return TabBarView(
                      children: [
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
                                            borderRadius: BorderRadius.circular(30)
                                           ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Image.asset("assets/images/goto.png", width: 25,),
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
                                            showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff16627C),
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(32),
                                                      topRight: Radius.circular(32)
                                                    )
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
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
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  // getQuranChaptersList();
                                                                },
                                                                child: Text(
                                                                  'Surah',
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 20.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Space(20),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                thumbVisibility: false,
                                                                thickness: 8,
                                                                // controller: c.scrollController,
                                                                radius: Radius
                                                                    .circular(20),
                                                                child: ListView
                                                                    .builder(
                                                                  controller: c
                                                                      .scrollController,
                                                                  itemCount: c
                                                                      .getqurandata
                                                                      .value
                                                                      .quranFilter!
                                                                      .length,
                                                                  itemBuilder: (
                                                                      context,
                                                                      index) {
                                                                    var sura = c
                                                                        .getqurandata
                                                                        .value
                                                                        .quranFilter![index];
                                                                    return Obx(() {
                                                                      return Container(
                                                                        // Replace this with your color logic
                                                                        color: c
                                                                            .currentSelected
                                                                            .value ==
                                                                            index
                                                                            ? Color(
                                                                            0xffEBEBEB)
                                                                            : Color(
                                                                            0xff16627C),
                                                                        child: ListTile(
                                                                          dense: true,
                                                                          title: Row(
                                                                            children: [
                                                                              Text(
                                                                                "${index +
                                                                                    1}.",
                                                                                style: TextStyle(
                                                                                  color: c
                                                                                      .currentSelected
                                                                                      .value ==
                                                                                      index
                                                                                      ? Color(
                                                                                      0xff16627C)
                                                                                      : Colors
                                                                                      .white,
                                                                                  fontSize: 15,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                  width: 5),
                                                                              Text(
                                                                                "${sura
                                                                                    .suraNameEn}",
                                                                                style: TextStyle(
                                                                                  color: c
                                                                                      .currentSelected
                                                                                      .value ==
                                                                                      index
                                                                                      ? Color(
                                                                                      0xff16627C)
                                                                                      : Colors
                                                                                      .white,
                                                                                  fontSize: 15,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          onTap: () {
                                                                            c
                                                                                .currentSelected
                                                                                .value =
                                                                                index;
                                                                            c
                                                                                .update();
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
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                isAlwaysShown: true,
                                                                thickness: 8,
                                                                // controller: c.scrollController,
                                                                radius: Radius
                                                                    .circular(20),
                                                                child: ListView
                                                                    .builder(
                                                                  controller: c
                                                                      .scrollController,
                                                                  shrinkWrap: true,
                                                                  itemCount: c
                                                                      .currentSelected
                                                                      .value ==
                                                                      c
                                                                          .currentSelected
                                                                          .value
                                                                      ? int.parse(
                                                                      "${c
                                                                          .getqurandata
                                                                          .value
                                                                          .quranFilter![c
                                                                          .currentSelected
                                                                          .value]
                                                                          .totalVerses}")
                                                                      : 0,
                                                                  itemBuilder: (
                                                                      context,
                                                                      index) {
                                                                    // Replace this with your data item
                                                                    return ListTile(
                                                                      dense: false,
                                                                      title: Center(
                                                                        child: Text(
                                                                          (index + 1)
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white),
                                                                        ),
                                                                      ),
                                                                      onTap: () {
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
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                isAlwaysShown: true,
                                                                thickness: 8,
                                                                // controller: c.scrollController,
                                                                radius: Radius
                                                                    .circular(20),
                                                                child: ListView
                                                                    .builder(
                                                                  controller: c
                                                                      .scrollController,
                                                                  shrinkWrap: true,
                                                                  itemCount: c
                                                                      .currentSelected
                                                                      .value ==
                                                                      c
                                                                          .currentSelected
                                                                          .value
                                                                      ? int.parse(
                                                                      "${c
                                                                          .getqurandata
                                                                          .value
                                                                          .quranFilter![c
                                                                          .currentSelected
                                                                          .value]
                                                                          .totalVerses}")
                                                                      : 0,
                                                                  itemBuilder: (
                                                                      context,
                                                                      index) {
                                                                    // Replace this with your data item
                                                                    return ListTile(
                                                                      dense: false,
                                                                      title: Center(
                                                                        child: Text(
                                                                          (index + 1)
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white),
                                                                        ),
                                                                      ),
                                                                      onTap: () {
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
                                          },
                                        ),
                                        Space(4),
                                        Text("Go To")
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
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset("assets/images/lastread.png", width: 25,),
                                ),
                              ),
                              Space(4),
                              Text("Last Read")
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
                                borderRadius: BorderRadius.circular(30)
                            ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Image.asset("assets/images/bookmark.png", width: 20,),
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
                                borderRadius: BorderRadius.circular(30)
                            ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Image.asset("assets/images/notes.png", width: 25,),
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
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                4),
                                            border: Border.all(color: Theme
                                                .of(context)
                                                .primaryColor)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("Al-Yaasin",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Theme
                                                    .of(context)
                                                    .primaryColor),),
                                        ),
                                      ),
                                      onTap: (){

                                      },
                                    ),
                                    Space(8),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              4),
                                          border: Border.all(color: Theme
                                              .of(context)
                                              .primaryColor)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text("Ar Rahaman",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Space(8),
                              Expanded(
                                child: Scrollbar(
                                  thumbVisibility: false,
                                  thickness: 8,
                                  controller: c.scrollController,
                                  radius: Radius.circular(20),
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    controller: c.scrollController,
                                    itemCount: filteredSurah.length,
                                    itemBuilder: (context, index) {
                                      var sura = filteredSurah[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: index < filteredSurah.length - 1 ? 10.0 : 0.0),
                                        child: Stack(
                                          children: [
                                            ListTile(
                                          minVerticalPadding: 0,
                                          dense: true,
                                          title: GestureDetector(
                                            onTap: () {
                                              print("mmmmmmmm ${index}");
                                              c.quranDetailList(index + 1);
                                              // Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuranDetails()));
                                            },
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              heightFactor: 0.7,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: c.media.size.width - c.padExtend / 2.0,
                                              height: 80.h,
                                                padding: EdgeInsets.all(c.padExtend),
                                              // width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  // topRight: Radius.circular(8),
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                  // bottomRight: Radius.circular(12),
                                                  // bottomLeft: Radius.circular(12),
                                                ),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.2),
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
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 2),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: 48.h,
                                                          width: 50.h,
                                                          decoration: BoxDecoration(
                                                            // color: Colors.red,
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/quranneww.png"),
                                                                fit: BoxFit.fill
                                                            ),
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text("${sura
                                                                .suraChapterNo}"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Space(8),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text("${sura.suraNameEn}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff16627C),
                                                            fontSize: 17,
                                                            fontWeight: FontWeight
                                                                .w600),),
                                                      Space(4),
                                                      Row(
                                                        children: [
                                                          Text("${sura.titleEn}",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff16627C),
                                                                fontSize: 12),),
                                                          Space(8),
                                                          Image(
                                                            image: "${sura.quranType}" == "Makki" ? AssetImage(
                                                                'assets/images/makka.png') : AssetImage(
                                                                'assets/images/madina.png'),
                                                            width: 12,
                                                          ),
                                                          // Space(16),

                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Stxt(text: "${sura.titleArabic}", size: f4, color: Color(
                                                          0xff16627C),),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 8, bottom: 8),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Image.asset("assets/images/bookmarkout.png", width: 16,),
                                                        Space(8),
                                                        Text("${sura
                                                            .totalVerses}",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff16627C),
                                                              fontSize: 12),)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                                ),
                                            ),
                                          ),
                                            ),
                                          ]
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Space(80)
                            ],
                          ),
                        ),
                        ListView.builder(
                          controller: c.scrollController,
                          itemCount: c.getqurandata.value.quranFilter!.length,
                          itemBuilder: (context, index) {
                            var sura = c.getqurandata.value.quranFilter![index];
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xff16627C)
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Container(
                                          width: 40.w,
                                          height: 40.w,
// color: Colors.blue,
                                          child: Transform.rotate(
                                            angle: 40 *
                                                (3.1415926535897932 / 180),
                                            // Converting 30 degrees to radians
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                                color: Color(0xff16627C),
                                              ),
                                              child: Center(
                                                child: Transform.rotate(
                                                  angle: -40 *
                                                      (3.1415926535897932 /
                                                          180),
                                                  child: Text(
                                                    "${sura.suraChapterNo}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${sura.suraNameEn}",
                                            style: TextStyle(
                                                color: Color(0xff16627C),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),),
                                          Text("The Opening", style: TextStyle(
                                              color: Color(0xff16627C),
                                              fontSize: 12),),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.bookmark,
                                              color: Color(0xff16627C),),
                                            Text(
                                              "${sura.totalVerses}",
                                              style: TextStyle(
                                                  color: Color(0xff16627C),
                                                  fontSize: 12),)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },

                        ),
                      ]
                  );
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
                          child: SvgPicture.asset("assets/svg/quranbot.svg")),
                      Space(8),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(
                                MaterialPageRoute(builder: (_) => HomeView()));
                          },
                          child: SvgPicture.asset("assets/svg/homebot.svg")),
                      Space(8),
                      SvgPicture.asset("assets/svg/mediabot.svg"),
                      Space(8),
                      SvgPicture.asset("assets/svg/donatebot.svg"),
                    ],
                  ),
                ),)

          );
        }),
      ),
    );
  }
}

class Surah {
  String? name;
  String? chapterno;
  String? verses;

  Surah({
    this.name,
    this.chapterno,
    this.verses,
  });
}

