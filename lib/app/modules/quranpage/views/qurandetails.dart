import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/tajweed_rules.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';
import 'package:smartmasjid_v1/widgets/gotoverse.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import '../../../../widgets/space.dart';
import '../../audioplayer/controllers/audioplayer_controller.dart';
import '../controllers/quranpage_controller.dart';
import 'dart:math' as math;

class QuranDetails extends StatefulWidget {
  late final int index;

  QuranDetails({super.key});

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

final QuranpageController c = Get.put(QuranpageController());
final AudioplayerController controller = Get.put(AudioplayerController());
// final List<QuranpageController> controllers = List.generate(
//     c.getqurandetail.value.getQuranAyahVerse![0].ayahList!.length, (index) =>
//     Get.put(QuranpageController()));


class _QuranDetailsState extends State<QuranDetails> {
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   c.result.value == "0" ? c.scrollToIndex(0) : c.scrollToIndex(
    //       int.parse(c.result.value) - 1);
    // });
    return Obx(() {
      return c.isLoadings.value ? loading(context) : Scaffold(
        key: c.scaffoldKey,
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              // controller: c.scrollControllern,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Space(20),
                  Text(
                    "customize_your_quran".tr,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600
                    ),
                  ),
                  Space(16),
                  Text(
                    "view".tr,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff16627C)),
                  ),
                  Space(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Obx(() {
                            return Radio(
                              activeColor: Get.theme.primaryColor,
                              // title: Text("Amiri"),
                              value: "sura",
                              groupValue: c.view.value,
                              onChanged: (groupValue) =>
                                  c.view(groupValue!),
                            );
                          }),
                          Text("surah".tr),
                          Obx(() {
                            return Radio(
                              activeColor: Get.theme.primaryColor,
                              // title: Text("Amiri"),
                              value: "page",
                              groupValue: c.view.value,
                              onChanged: (groupValue) =>
                                  c.view(groupValue!),
                            );
                          }),
                          Text("page".tr),
                        ],
                      ),
                      Space(4),
                      Row(
                        children: [
                          Obx(() {
                            return Radio(
                              activeColor: Get.theme.primaryColor,
                              // title: Text("Amiri"),
                              value: "juz",
                              groupValue: c.view.value,
                              onChanged: (groupValue) =>
                                  c.view(groupValue!),
                            );
                          }),
                          Text("juz".tr),
                          Obx(() {
                            return Radio(
                              activeColor: Get.theme.primaryColor,
                              // title: Text("Amiri"),
                              value: "hizb",
                              groupValue: c.view.value,
                              onChanged: (groupValue) =>
                                  c.view(groupValue!),
                            );
                          }),
                          Text("hizb".tr),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Space(16),
                  Text(
                    "translation".tr,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff16627C)),
                  ),
                  Space(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Container(
                          height: 25.h,
                          width: 25.w,
                          child: Transform.scale(
                            scale: 0.8,
                            // Adjust this value to change the checkbox size.
                            child: Checkbox(
                              activeColor: Get.theme.primaryColor,
                              checkColor: Colors.white,
                              value: c.isCheckedArabic.value,
                              onChanged: (value) {
                                c.isCheckedArabic.value = value!;
                                Future.delayed(
                                    Duration(milliseconds: 500), () {
                                  c.getqurandetail();
                                });
                                c.update();
                              },
                            ),
                          ),
                        );
                      }),
                      Stxt(size: f2, text: 'arabic'.tr,),
                      Space(8),
                      Obx(() {
                        return Container(
                          height: 25.h,
                          width: 25.w,
                          child: Transform.scale(
                            scale: 0.8,
                            // Adjust this value to change the checkbox size.
                            child: Checkbox(
                              activeColor: Get.theme.primaryColor,
                              checkColor: Colors.white,
                              value: c.isCheckedEnglish.value,
                              onChanged: (value) {
                                c.isCheckedEnglish.value = value!;
                                Future.delayed(
                                    Duration(milliseconds: 500), () {
                                  c.getqurandetail();
                                });
                                c.update();
                              },
                            ),
                          ),
                        );
                      }),
                      Stxt(size: f2, text: 'english'.tr,),
                      Space(8),
                      Obx(() {
                        return Container(
                          height: 25.h,
                          width: 25.w,
                          child: Transform.scale(
                            scale: 0.8,
                            // Adjust this value to change the checkbox size.
                            child: Checkbox(
                              splashRadius: 5,
                              activeColor: Get.theme.primaryColor,
                              checkColor: Colors.white,
                              value: c.isCheckedTamil.value,
                              onChanged: (value) {
                                c.isCheckedTamil.value = value!;
                                Future.delayed(
                                    Duration(milliseconds: 500), () {
                                  c.getqurandetail();
                                });
                                c.update();
                              },
                            ),
                          ),
                        );
                      }),
                      Stxt(size: f2, text: 'tamil'.tr,),
                    ],
                  ),
                  Space(8),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor:
                        Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          List<String> downloadedItems = [];
                          List<String> courseList = [
                            "தமிழ் (Tamil)",
                            "اردو (Urdu)",
                            "മലയാളം (Malayalam)",
                            "తెలుగు (Telugu)",
                          ];
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
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
                                  Stxt(text: "Add Language",
                                    size: f4,
                                    weight: FontWeight.w600,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,),
                                  Space(4),
                                  Safa_textfield(
                                    hint: "Search",
                                    fillColor: Colors.grey.shade50,
                                    suffixIcon: Icon(Icons.search),
                                  ),
                                 Expanded(
                                   child: ListView(
                                     shrinkWrap: true,
                                     children: [
                                     Space(8),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Stxt(text: "Downloads",
                                           size: f4,
                                           weight: FontWeight.w600,
                                           color: Theme
                                               .of(context)
                                               .primaryColor,),
                                       ],
                                     ),
                                     ListView.builder(
                                       shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       itemCount: courseList.length,
                                       itemBuilder: (context, index) {
                                         return CourseListItem(
                                             courseName: courseList[index]);
                                       },
                                     ),
                                     Space(16),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Stxt(text: "Featured Languages",
                                           size: f4,
                                           weight: FontWeight.w600,
                                           color: Theme
                                               .of(context)
                                               .primaryColor,),
                                       ],
                                     ),
                                     ListView.builder(
                                       shrinkWrap: true,
                                       physics: NeverScrollableScrollPhysics(),
                                       itemCount: downloadedItems.length,
                                       itemBuilder: (context, index) {
                                         return CourseListItem(
                                             courseName: courseList[index]);
                                       },
                                     ),
                                   ],),
                                 )
                                  // Divider(
                                  //   thickness: 1,
                                  // )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Stxt(
                        text: "+ Add Language", size: f2, weight: FontWeight
                          .w600, color: Theme
                          .of(context)
                          .primaryColor,),
                    ),
                  ),
                  Space(8),
                  // Divider(
                  //   thickness: 1,
                  // ),
                  Space(8),
                  Text(
                    "arabic_font".tr,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff16627C)),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        title: Text("indoPak_script".tr),
                        children: [
                          ListTile(
                            title: Column(
                              children: [
                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        // color: Colors.red,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Amiri"),
                                          value: "noorehira",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                              c.changeFontFamily(groupValue!),
                                        ),
                                      ),
                                      Text("noorehira".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/svg/noorehira.svg",
                                          width: 60,
                                          color: Colors.black.withOpacity(
                                              0.6))
                                    ],
                                  );
                                }),

                                Space(8),
                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Kalam"),
                                          value: "noorehuda",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                              c.changeFontFamily(groupValue!),
                                        ),
                                      ),
                                      Text("noorehuda".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/svg/noorehuda.svg",
                                          width: 60,
                                          color: Colors.black.withOpacity(
                                              0.6))
                                    ],
                                  );
                                }),
                                Space(8),
                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Amiri"),
                                          value: "noorehidayat",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                          c.fontFamily.value = groupValue!,
                                        ),
                                      ),
                                      Text("noorehidayat".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/svg/noorehidayat.svg",
                                          width: 60,
                                          color: Colors.black.withOpacity(
                                              0.6))
                                    ],
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                      // Divider(
                      //
                      // ),
                      ExpansionTile(
                        title: Text("uthmani_madani".tr),
                        children: [
                          ListTile(
                            title: Column(
                              children: [
                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Amiri"),
                                          value: "indopak",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                              c.changeFontFamily(groupValue!),
                                        ),
                                      ),
                                      Text("quran".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/svg/quran.svg", width: 60,
                                          color: Colors.black.withOpacity(
                                              0.6))
                                    ],
                                  );
                                }),
                                Space(8),
                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Kalam"),
                                          value: "qalam",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                              c.changeFontFamily(groupValue!),
                                        ),
                                      ),
                                      Text("qalam".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/svg/qalam.svg", width: 60,
                                          color: Colors.black.withOpacity(
                                              0.6))
                                    ],
                                  );
                                }),
                                Space(8),

                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Amiri"),
                                          value: "uthami",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                          c.fontFamily.value = groupValue!,
                                        ),
                                      ),
                                      Text("hafs".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/svg/KFGQPC.svg", width: 60,
                                          color: Colors.black.withOpacity(
                                              0.6))
                                    ],
                                  );
                                }),
                                Space(8),
                                Obx(() {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 25.h,
                                        width: 25.w,
                                        child: Radio(
                                          activeColor: Get.theme.primaryColor,
                                          // title: Text("Kalam"),
                                          value: "amiri",
                                          groupValue: c.fontFamily.value,
                                          onChanged: (groupValue) =>
                                          c.fontFamily.value =
                                              groupValue!.toString(),
                                        ),
                                      ),
                                      Text("amiri".tr),
                                      Spacer(),
                                      SvgPicture.asset(
                                        "assets/svg/amiri.svg", width: 60,
                                        color: Colors.black.withOpacity(
                                            0.5),),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Space(16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => TajweedRules()));
                    },
                    child: Row(
                      children: [
                        Text("tajweed_rules".tr, style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined, size: 15,)
                      ],
                    ),
                  ),
                  Space(16),
                  Divider(
                    thickness: 1,
                  ),
                  Space(16),
                  // Divider(
                  //   thickness: 1,
                  // ),
                  Text(
                    "arabic_font_size".tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      sliderTheme: const SliderThemeData(
                        thumbShape: MySliderComponentShape(),
                        // trackShape: SameHeightRoundedSliderTrackShape(),
                        trackHeight: 8,
                      ),
                    ),
                    child: Obx(() {
                      // Use Obx to listen to changes in the controller's sliderValue
                      return Slider(
                        onChanged: c.setSliderValue,
                        // Call the setSliderValue method from the controller
                        value: c.sliderValue.value,
                        // Use the sliderValue from the controller
                        min: 0,
                        max: 2,
                        divisions: 2,
                        activeColor: const Color.fromARGB(255, 231, 231, 231),
                        inactiveColor: const Color.fromARGB(
                            255, 231, 231, 231),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text('small'.tr, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                      ),
                      Text('medium'.tr, style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                      Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Text('large'.tr, style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Space(16),
                  Text(
                    "translation_font_size".tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      sliderTheme: const SliderThemeData(
                        thumbShape: MySliderComponentShape1(),
                        // trackShape: SameHeightRoundedSliderTrackShape(),
                        trackHeight: 8,
                      ),
                    ),
                    child: Obx(() {
                      // Use Obx to listen to changes in the controller's sliderValue
                      return Slider(
                        onChanged: c.setSliderValue1,
                        // Call the setSliderValue method from the controller
                        value: c.sliderValue1.value,
                        // Use the sliderValue from the controller
                        min: 0,
                        max: 2,
                        divisions: 2,
                        activeColor: const Color.fromARGB(255, 231, 231, 231),
                        inactiveColor: const Color.fromARGB(
                            255, 231, 231, 231),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text('small'.tr, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                      ),
                      Text('medium'.tr, style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                      Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Text('large'.tr, style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          tittle: "${c.getqurandetail.value.getQuranAyahVerse![0].titleArb}",
          action: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset("assets/svg/darkmode.svg")),
                Space(20),
                GestureDetector(
                    onTap: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return CustomDialogBox(
                      //       title: 'Custom Dialog Title',
                      //       content:
                      //       'This is the content of the custom dialog box.',
                      //       onPressed: () {
                      //         Navigator.pop(
                      //             context); // Closes the dialog box when the button is pressed.
                      //       },
                      //     );
                      //   },
                      // );
                      c.openEndDrawer();
                    },
                    child: SvgPicture.asset("assets/svg/customize.svg")),
                Space(22),
              ],
            )
          ],
        ),
        body: PageView.builder(
          scrollBehavior: ScrollBehavior(),
          pageSnapping: true,
          physics: ScrollPhysics(),
          controller: c.pageController,
          onPageChanged: (page) {
            c.quranDetailList(c.qurandetsilIndex.value + (page));
          },
          itemCount: c.getqurandata.value.quranFilter!.length,
          // Replace with the actual number of pages
          itemBuilder: (context, pageIndex) {
            // print(pageIndex + 1);

            return Obx(() {
              return (c.isLoadings1.value) ? loading(context) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/qurantitle.png",
                              ),
                              fit: BoxFit.fill)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Space(32),
                            Container(
                              height: 50,
                              width: 50,
                              // color: Colors.red,
                              child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: c.getqurandetail.value
                                            .getQuranAyahVerse![0]
                                            .makkiMadina == "Makki"
                                            ? AssetImage(
                                            'assets/images/makka.png')
                                            : AssetImage(
                                            'assets/images/madina.png'),
                                        width: 20,
                                        height: 20,
                                      ),
                                      Space(4),
                                      // Text(
                                      //   "${makki}",
                                      //   style: TextStyle(
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.w500,
                                      //       color: Theme
                                      //           .of(context)
                                      //           .primaryColor),
                                      // ),
                                      Stxt(text: "${c.getqurandetail.value
                                          .getQuranAyahVerse![0].makkiMadina}",
                                        size: f2,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        weight: FontWeight.w500,)
                                    ],
                                  )),
                            ),
                            // Space(60),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, right: 32, left: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      GotoVerse(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text("${c.getqurandetail.value
                                            .getQuranAyahVerse![0]
                                            .suraChapterNo}. ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor),),
                                        SizedBox(
                                          width: 73.w,
                                          child: Stxt(
                                            text: "${c.getqurandetail.value
                                                .getQuranAyahVerse![0]
                                                .suraNameEn}",
                                            size: f2,
                                            color: Theme
                                                .of(context)
                                                .primaryColor,
                                            weight: FontWeight.w500,
                                            maxLines: 1,),
                                        ),
                                        // Icon(Icons.arrow_drop_down_outlined)
                                      ],
                                    ),
                                  ),
                                  Stxt(text: "${c.getqurandetail.value
                                      .getQuranAyahVerse![0].titleEn}",
                                    size: f1,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,)
                                  // Text(
                                  //   ,
                                  //   style: TextStyle(
                                  //       fontSize: 12,
                                  //       fontFamily: "Roboto",
                                  //       color: Theme
                                  //           .of(context)
                                  //           .primaryColor),
                                  // ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stxt(text: "Ayah",
                                      size: f1,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      weight: FontWeight.w500,),
                                    Stxt(text: "${c.getqurandetail.value
                                        .getQuranAyahVerse![0].totalVerses}",
                                      size: f2,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      weight: FontWeight.w500,)
                                  ],
                                )),
                            Space(40)
                          ],
                        ),
                      ),
                    ),
                    Space(16),
                    Expanded(
                      child: c.isLoadings1.value
                          ? loading(context)
                          : Scrollbar(
                        interactive: true,
                        thumbVisibility: false,
                        thickness: 10,
                        controller: c.scrollControllern,
                        radius: Radius.circular(20),
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: c.scrollControllern,
                            itemCount: c.getqurandetail.value
                                .getQuranAyahVerse![0].ayahList!.length,
                            itemBuilder: (context, index) {
                              var sura = c.getqurandetail.value
                                  .getQuranAyahVerse![0].ayahList![index];
                              print("versess${sura.versesKey}");
                              return Container(
                                  width: double.infinity,
                                  // color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.r),
                                    child: Column(
                                      // crossAxisAlignment:
                                      // CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              "${sura.versesKey}",
                                              style: TextStyle(
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                            ...c.pages.map((e) =>
                                            e['verse'] == sura.versesKey
                                                ? Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        4),
                                                    color: Theme
                                                        .of(context)
                                                        .primaryColor
                                                ),
                                                height: 30,
                                                width: 70,
                                                child: Center(
                                                    child: Text(
                                                      "Page ${e['no']}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w600),)),
                                              ),
                                            )
                                                : Container()).toList(),
                                            Space(40),
                                            Icon(
                                              Icons.play_circle,
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor,
                                            ),
                                            Space(12),
                                            GestureDetector(

                                              onTap: () {
                                                print('ssss${c.getqurandetail
                                                    .value
                                                    .getQuranAyahVerse![0]
                                                    .suraNameEn}');
                                                // if(c.passint.value==sura.versesKey![0]){
                                                //   print("ggg");
                                                //   c.toogle(index);
                                                // }
                                                c.toogle(
                                                    "${c.getqurandetail.value
                                                        .getQuranAyahVerse![0]
                                                        .suraNameEn} ${sura
                                                        .versesKey}");
                                              },

                                              child: Obx(() {
                                                //   print("eeee${c.objectList}");
                                                print("eeee${sura.versesKey
                                                    .toString()}");
                                                return Icon(
                                                  c.buttonsSelected.contains(
                                                      "${c.getqurandetail
                                                          .value
                                                          .getQuranAyahVerse![0]
                                                          .suraNameEn} ${sura
                                                          .versesKey}")
                                                      ? Icons.bookmark
                                                      : Icons
                                                      .bookmark_outline,
                                                  color: c.buttonsSelected
                                                      .contains(
                                                      "${c.getqurandetail
                                                          .value
                                                          .getQuranAyahVerse![0]
                                                          .suraNameEn} ${sura
                                                          .versesKey}")
                                                      ? Theme
                                                      .of(context)
                                                      .primaryColor
                                                      : Theme
                                                      .of(context)
                                                      .primaryColor, // Use different colors for bookmarked and not bookmarked states
                                                );
                                              }),
                                            ),
                                            PopupMenuButton(
                                                shadowColor: Colors.grey
                                                    .shade400,
                                                itemBuilder: (
                                                    BuildContext context) {
                                                  return [
                                                    PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            c.copyToClipboard(
                                                                index);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Obx(() {
                                                                return Icon(
                                                                    c.copy
                                                                        .contains(
                                                                        "${c
                                                                            .getqurandetail
                                                                            .value
                                                                            .getQuranAyahVerse![0]
                                                                            .ayahList![0]
                                                                            .arabicText} ${sura
                                                                            .versesKey} ${sura
                                                                            .engTranslation}")
                                                                        ? Icons
                                                                        .copy
                                                                        : Icons
                                                                        .copy);
                                                              }),
                                                              Space(12),
                                                              Text("Copy"),
                                                            ],
                                                          ),
                                                        )),
                                                    PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            c.shareMessage(
                                                                index);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons
                                                                  .share),
                                                              Space(12),
                                                              Text("Share"),
                                                            ],
                                                          ),
                                                        )),
                                                    PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (
                                                                  BuildContext context) {
                                                                return CustomDialogBox1(
                                                                  // title: 'Custom Dialog Title',
                                                                  // content:
                                                                  // 'This is the content of the custom dialog box.',
                                                                  // onPressed: () {
                                                                  //   Navigator
                                                                  //       .pop(
                                                                  //       context); // Closes the dialog box when the button is pressed.
                                                                  // },
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/images/notes.png",
                                                                width: 20,
                                                                color: Colors
                                                                    .black,),
                                                              Space(12),
                                                              Text(
                                                                  "Create Notes"),
                                                            ],
                                                          ),
                                                        )),
                                                  ];
                                                }
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            50.horizontalSpace,
                                            Space(20.w),
                                            Align(
                                                alignment:
                                                Alignment.centerLeft,
                                                child: Obx(() {
                                                  double fontSize = 40.0;
                                                  String fontFamily = c
                                                      .fontFamily
                                                      .value;
                                                  double sliderValue = c
                                                      .sliderValue.value;
                                                  if (sliderValue == 1) {
                                                    // Set font size to 35.0 when sliderValue is 1 (Medium)
                                                    fontSize = 45.0;
                                                  } else if (sliderValue == 2) {
                                                    // Set font size to 40.0 when sliderValue is 2 (Large)
                                                    fontSize = 55.0;
                                                  }
                                                  TextStyle textStyle = TextStyle(
                                                    wordSpacing: 10,
                                                    fontSize: fontSize,
                                                    fontFamily: c.fontFamily
                                                        .value == "indopak"
                                                        ? "Indopak"
                                                        : c.fontFamily
                                                        .value ==
                                                        "qalam"
                                                        ? "Qalam" : c
                                                        .fontFamily
                                                        .value == "uthami"
                                                        ? "Uthami" : c
                                                        .fontFamily
                                                        .value == "amiri"
                                                        ? "Amiri" : c
                                                        .fontFamily
                                                        .value == "noorehira"
                                                        ? "Noorehira" : c
                                                        .fontFamily
                                                        .value == "noorehuda"
                                                        ? "Noorehuda" : c
                                                        .fontFamily
                                                        .value ==
                                                        "noorehidayat"
                                                        ? "Noorehidayat" : c
                                                        .fontFamily
                                                        .value == "arabictit"
                                                        ? "Arabictitle"
                                                        : null, // Use the default font if "Amiri" is not selected
                                                  );
                                                  return SizedBox(
                                                    width: c.screenWidth *
                                                        0.68,
                                                    child: c.isCheckedArabic
                                                        .value == true
                                                        ? Text(
                                                      "${sura.arabicText}",
                                                      style: textStyle,
                                                      textAlign:
                                                      TextAlign.end,
                                                    )
                                                        : SizedBox(),
                                                  );
                                                })
                                            ),
                                          ],
                                        ),
                                        Space(8),
                                        Space(16),
                                        Obx(() {
                                          double fontSize = 18.0;
                                          double sliderValue = c.sliderValue1
                                              .value;
                                          if (sliderValue == 1) {
                                            // Set font size to 35.0 when sliderValue is 1 (Medium)
                                            fontSize = 22.0;
                                          } else if (sliderValue == 2) {
                                            // Set font size to 40.0 when sliderValue is 2 (Large)
                                            fontSize = 25.0;
                                          }
                                          return SizedBox(
                                              width: .9.sw,
                                              child: Align(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child:
                                                  c.isCheckedEnglish.value ==
                                                      true
                                                      ? Text(
                                                    "${sura.engTranslation}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontSize: fontSize),
                                                  )
                                                      : SizedBox()));
                                        }),
                                        Space(16),
                                        Obx(() {
                                          double fontSize = 18.0;
                                          double sliderValue = c.sliderValue1
                                              .value;
                                          if (sliderValue == 1) {
                                            // Set font size to 35.0 when sliderValue is 1 (Medium)
                                            fontSize = 22.0;
                                          } else if (sliderValue == 2) {
                                            // Set font size to 40.0 when sliderValue is 2 (Large)
                                            fontSize = 25.0;
                                          }
                                          return SizedBox(
                                              width: .9.sw,
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: c.isCheckedTamil
                                                      .value
                                                      ? Text(
                                                    "${sura
                                                        .tamilTranslation}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontSize: fontSize),
                                                  )
                                                      : SizedBox.shrink()));
                                        }),
                                        Space(16),
                                        Image.asset(
                                          "assets/images/qurandivider.png",
                                          scale: 4,
                                          width: 310.w,
                                        )
                                      ],
                                    ),
                                  ));
                            }
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
          },
        ),

      );
    });
  }
}

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomDialogBox({
    required this.title,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Customize your Quran",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Space(16),
          Text(
            "Content",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff16627C)),
          ),
          Space(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Container(
                  height: 25.h,
                  width: 25.w,
                  child: Transform.scale(
                    scale: 0.8,
                    // Adjust this value to change the checkbox size.
                    child: Checkbox(
                      activeColor: Get.theme.primaryColor,
                      checkColor: Colors.white,
                      value: c.isCheckedArabic.value,
                      onChanged: (value) {
                        c.isCheckedArabic.value = value!;
                        Future.delayed(Duration(milliseconds: 500), () {
                          c.getqurandetail();
                        });
                        c.update();
                      },
                    ),
                  ),
                );
              }),
              Stxt(size: f2, text: 'Arabic',),
              Space(8),
              Obx(() {
                return Container(
                  height: 25.h,
                  width: 25.w,
                  child: Transform.scale(
                    scale: 0.8,
                    // Adjust this value to change the checkbox size.
                    child: Checkbox(
                      activeColor: Get.theme.primaryColor,
                      checkColor: Colors.white,
                      value: c.isCheckedEnglish.value,
                      onChanged: (value) {
                        c.isCheckedEnglish.value = value!;
                        Future.delayed(Duration(milliseconds: 500), () {
                          c.getqurandetail();
                        });
                        c.update();
                      },
                    ),
                  ),
                );
              }),
              Stxt(size: f2, text: 'English',),
              Space(8),
              Obx(() {
                return Container(
                  height: 25.h,
                  width: 25.w,
                  child: Transform.scale(
                    scale: 0.8,
                    // Adjust this value to change the checkbox size.
                    child: Checkbox(
                      splashRadius: 5,
                      activeColor: Get.theme.primaryColor,
                      checkColor: Colors.white,
                      value: c.isCheckedTamil.value,
                      onChanged: (value) {
                        c.isCheckedTamil.value = value!;
                        Future.delayed(Duration(milliseconds: 500), () {
                          c.getqurandetail();
                        });
                        c.update();
                      },
                    ),
                  ),
                );
              }),
              Stxt(size: f2, text: 'Tamil',),
            ],
          ),
          Space(8),
          Divider(
            thickness: 1,
          ),
          Text(
            "Font",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff16627C)),
          ),

          Column(
            children: [

              Row(
                children: [
                  Obx(() {
                    return Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Amiri"),
                      value: "indopak",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                          c.changeFontFamily(groupValue!),
                    );
                  }),
                  Text("Indopak"),
                  Space(32),
                  Obx(() {
                    return Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Kalam"),
                      value: "qalam",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                          c.changeFontFamily(groupValue!),
                    );
                  }),
                  Text("Qalam"),
                ],
              ),

              Obx(() {
                return Row(
                  children: [
                    Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Amiri"),
                      value: "uthami",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                      c.fontFamily.value = groupValue!,
                    ),
                    Text("KFGQPC"),
                    Space(32),
                    Radio(
                      activeColor: Get.theme.primaryColor,
                      // title: Text("Kalam"),
                      value: "amiri",
                      groupValue: c.fontFamily.value,
                      onChanged: (groupValue) =>
                      c.fontFamily.value = groupValue!.toString(),
                    ),
                    Text("Amiri"),
                  ],
                );
              }),
            ],
          ),


          Space(8),
          Divider(
            thickness: 1,
          ),
          Text(
            "Arabic Font Size",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              sliderTheme: const SliderThemeData(
                thumbShape: MySliderComponentShape(),
                // trackShape: SameHeightRoundedSliderTrackShape(),
                trackHeight: 8,
              ),
            ),
            child: Obx(() {
              // Use Obx to listen to changes in the controller's sliderValue
              return Slider(
                onChanged: c.setSliderValue,
                // Call the setSliderValue method from the controller
                value: c.sliderValue.value,
                // Use the sliderValue from the controller
                min: 0,
                max: 2,
                divisions: 2,
                activeColor: const Color.fromARGB(255, 231, 231, 231),
                inactiveColor: const Color.fromARGB(255, 231, 231, 231),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text('Small', style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              Text('Medium',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text('Large', style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          Space(16),
          Text(
            "Translation Font Size",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              sliderTheme: const SliderThemeData(
                thumbShape: MySliderComponentShape1(),
                // trackShape: SameHeightRoundedSliderTrackShape(),
                trackHeight: 8,
              ),
            ),
            child: Obx(() {
              // Use Obx to listen to changes in the controller's sliderValue
              return Slider(
                onChanged: c.setSliderValue1,
                // Call the setSliderValue method from the controller
                value: c.sliderValue1.value,
                // Use the sliderValue from the controller
                min: 0,
                max: 2,
                divisions: 2,
                activeColor: const Color.fromARGB(255, 231, 231, 231),
                inactiveColor: const Color.fromARGB(255, 231, 231, 231),
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text('Small', style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              Text('Medium',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text('Large', style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MySliderComponentShape extends SliderComponentShape {
  const MySliderComponentShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(34, 34);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    canvas.drawShadow(
        Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: 30, height: 30),
            const Radius.circular(19),
          )),
        Colors.black,
        5,
        false);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 25, height: 25),
        const Radius.circular(16),
      ),
      Paint()
        ..color = const Color.fromARGB(255, 252, 241, 216),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 20, height: 20),
        const Radius.circular(13),
      ),
      Paint()
        ..color = Color(0xff16627C),
    );
  }
}

class MySliderComponentShape1 extends SliderComponentShape {
  const MySliderComponentShape1();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(34, 34);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    canvas.drawShadow(
        Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: 30, height: 30),
            const Radius.circular(19),
          )),
        Colors.black,
        5,
        false);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 25, height: 25),
        const Radius.circular(16),
      ),
      Paint()
        ..color = const Color.fromARGB(255, 252, 241, 216),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 20, height: 20),
        const Radius.circular(13),
      ),
      Paint()
        ..color = Color(0xff16627C),
    );
  }
}


class ProfilePageController extends GetxController {
  late String selectedGender;
  final List<String> gender = ["Male", "Female"];

  late String select;

  void onClickRadioButton(value) {
    print(value);
    select = value;
    update();
  }
}

class CustomDialogBox1 extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Create New Note", style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Theme
              .of(context)
              .primaryColor),),
          Space(16),
          Container(
            width: 300.w,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      color: Colors.grey.shade400
                  )
                ]
            ),
            child: TextField(
              style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.4), fontWeight: FontWeight.w600),
              controller: pass,
              decoration: InputDecoration(
                hintText: 'Note Title',
                // label: Text("Note Title"),
                filled: true,
                fillColor: Colors.grey.shade100,
                focusColor: Colors.black,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Space(16),
          TextFormField(
            controller: c,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Type ypur notes...',
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black),
            maxLines: 4,
          ),
          Space(16),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 40),
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4.0,
              ),
              child: Text("Save", style: TextStyle(fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white),)),
        ],
      ),
    );
  }
}


class CourseListItem extends StatefulWidget {
  const CourseListItem({Key? key, required this.courseName}) : super(key: key);

  final String courseName;

  @override
  State<CourseListItem> createState() => _CourseListItemPage();
}

class _CourseListItemPage extends State<CourseListItem> {
  int downloadProgress = 0;
  bool isDownloadStarted = false;
  bool isDownloadFinish = false;
  bool isItemDownloaded = false;

  @override
  void initState() {
    super.initState();
    // Load download state from shared preferences
    loadDownloadState();
  }

  void loadDownloadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isItemDownloaded = prefs.getBool(widget.courseName) ?? false;
      if (isItemDownloaded) {
        // If the item is downloaded, set progress to 100%
        downloadProgress = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.courseName),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
        child: Text(
          widget.courseName.substring(0, 1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      trailing: Container(
        width: 70, // Adjust the width as needed
        child: Column(
          children: [
            Visibility(
              visible: isDownloadStarted,
              child: CircularPercentIndicator(
                radius: 20.0,
                lineWidth: 3.0,
                percent: (downloadProgress / 100),
                center: Text(
                  "$downloadProgress%",
                  style:  TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                progressColor:Theme.of(context).primaryColor,
              ),
            ),
            Visibility(
              visible: !isDownloadStarted && !isItemDownloaded,
              // Only show download button if not started and not downloaded
              child: IconButton(
                icon: Icon(Icons.download_for_offline_outlined),
                color: Colors.grey,
                onPressed: downloadCourse,
              ),
            ),
            Visibility(
              visible: isItemDownloaded, // Show checkbox if item is downloaded
              child: Obx(() {
                return Container(
                  height: 30.h,
                  width: 30.w,
                  child: Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      activeColor: Get.theme.primaryColor,
                      checkColor: Colors.white,
                      value: c.isCheckedTamil.value,
                      onChanged: (value) {
                        c.isCheckedTamil.value = value!;
                        Future.delayed(Duration(milliseconds: 500), () {
                          c.getqurandetail();
                        });
                        c.update();
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void saveDownloadState(bool downloaded) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.courseName, downloaded);
  }

  void downloadCourse() async {
    if (isItemDownloaded) {
      // If the item is already downloaded, return without doing anything
      return;
    }

    if (!isDownloadStarted) {
      // If download is not started, set the flag and reset progress
      isDownloadStarted = true;
      downloadProgress = 0;
      setState(() {});
    }

    // Download logic
    while (downloadProgress < 100) {
      // Get download progress
      downloadProgress += 10;
      setState(() {});
      if (downloadProgress == 100) {
        isDownloadFinish = true;
        isDownloadStarted = false;
        isItemDownloaded = true;
        setState(() {});
        // Update the stored value in shared preferences
        saveDownloadState(true);
        moveItemToDownloads();
        break;
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
  void moveItemToDownloads() {
    // Implement the logic to move the item to the downloads list.
    // You can do this by updating a state variable or calling a function in the parent widget.
  }
}



