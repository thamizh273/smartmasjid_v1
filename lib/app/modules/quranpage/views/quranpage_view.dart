import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/views/home_view.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../widgets/space.dart';
import '../../../routes/app_pages.dart';
import '../controllers/quranpage_controller.dart';

class QuranpageView extends StatefulWidget {

  QuranpageView({Key? key}) : super(key: key);

  @override
  State<QuranpageView> createState() => _QuranpageViewState();
}

class _QuranpageViewState extends State<QuranpageView> {
  final QuranpageController c = Get.put(QuranpageController());

  List<Surah> suraList = [
    Surah(name: "Al Fatihah", chapterno: "1", verses: "7")
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(() {
        return c.isLoadings.value ? loading(context) : Scaffold(
          key: c.scaffoldKey,
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
                              shrinkWrap: true,
                              itemCount: c.currentSelected.value==c.currentSelected.value? int.parse("${c.getqurandata.value.quranFilter![c.currentSelected.value].totalVerses}") : 0,
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
                child: SvgPicture.asset(
                    "assets/svg/backnew.svg", fit: BoxFit.scaleDown)),
            backgroundColor: c.isSearchEnabled.value ? Colors.transparent : Color(0xff16627C),
            // backgroundColor: isSearchEnabled ? Colors.transparent : Color(0xff16627C),
              title: c.isSearchEnabled.value
                  ? TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color:Color(0xff16627C)),
                ),
                style: TextStyle(color: Color(0xff16627C)),
                onChanged: (value) {
                    c.searchQuery.value = value; // Update the search query
                },
              )
                  : Text(
                "Holy Quran",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      c.isSearchEnabled = c.isSearchEnabled; // Toggle search field
                    },
                    icon: Icon(Icons.search),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_add),
                    color: Colors.white,
                  ),
                ],
              )
            ],
            bottom: TabBar(
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
              return  TabBarView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Space(16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    child: Container(
                                      height: 25,
                                      width: 120,
                                      color: Color(0xff16627C),
                                      child: Row(
                                        children: [
                                          Icon(Icons.menu, color: Colors.white,),
                                          Space(8),
                                          Text("Go to verse", style: TextStyle(
                                              color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    onTap: () => c.openDrawer()
                                ),
                              ],
                            ),
                          ),
                          Space(8),
                          Expanded(
                            child: ListView.builder(
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
                                                Icon(Icons.bookmark_add_outlined,
                                                  color: Color(0xff16627C),),
                                                Text("${sura.totalVerses}",
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
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
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
                                        angle: 40 * (3.1415926535897932 / 180),
                                        // Converting 30 degrees to radians
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xff16627C),
                                          ),
                                          child: Center(
                                            child: Transform.rotate(
                                              angle: -40 *
                                                  (3.1415926535897932 / 180),
                                              child: Text(
                                                "${sura.suraChapterNo}",
                                                style: TextStyle(fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${sura.suraNameEn}", style: TextStyle(
                                          color: Color(0xff16627C),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),),
                                      Text("The Opening", style: TextStyle(
                                          color: Color(0xff16627C), fontSize: 12),),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bookmark,
                                          color: Color(0xff16627C),),
                                        Text(
                                          "${sura.totalVerses}", style: TextStyle(
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
            }, child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/svg/masjidbot.svg"),
                Space(8),
                GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.QURANPAGE);
                    },
                    child: SvgPicture.asset("assets/svg/quranbot.svg")),
                Space(8),
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop(MaterialPageRoute(builder: (_) => HomeView()));
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