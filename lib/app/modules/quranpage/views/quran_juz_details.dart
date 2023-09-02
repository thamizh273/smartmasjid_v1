import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/tajweed_rules.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../widgets/gotoverse.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/quranpage_controller.dart';

class QuranJuzDetails extends StatefulWidget {
  const QuranJuzDetails({super.key});

  @override
  State<QuranJuzDetails> createState() => _QuranJuzDetailsState();
}

final c = Get.put(QuranpageController());


class _QuranJuzDetailsState extends State<QuranJuzDetails> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return c.isLoadingsJuz.value ? loading(context) : Scaffold(
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
                      children:  [
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
                      children:  [
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
            tittle: "",
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
            // controller: c.pageController,
            onPageChanged: (page) {
              c.quranjuzdetailList(c.qurandetsilIndex.value + (page+1));
            },
            itemCount: c.getquranjuz.value.getQuranJuzChapter!.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                return (c.isLoadingsJuz.value)?loading(context):Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 80.h,
                        width: 350.w,
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        // Image(
                                        //   image: makki == "Makki" ? AssetImage(
                                        //       'assets/images/makka.png') : AssetImage(
                                        //       'assets/images/madina.png'),
                                        //   width: 20,
                                        //   height: 20,
                                        // ),
                                        Space(4),
                                        Obx(() {
                                          final ctrl = c.getquranjuzdetail.value
                                              .getQuranJuzVersesList![0];
                                          return Text(
                                            "${ctrl.juzChapterNo}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Theme
                                                    .of(context)
                                                    .primaryColor),
                                          );
                                        }),
                                        Stxt(text: "Juz",
                                          size: f2,
                                          color: Theme
                                              .of(context)
                                              .primaryColor,
                                          weight: FontWeight.w500,)
                                      ],
                                    )),
                              ),
                              Space(30),
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
                                      child: Obx(() {
                                        final ctrl = c.getquranjuzdetail.value
                                            .getQuranJuzVersesList![0];
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "${ctrl.juzChapterNo}.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor),),
                                            SizedBox(
                                              width: 73.w,
                                              child: Stxt(
                                                text: "${ctrl.juzNameEn}",
                                                size: f2,
                                                color: Theme
                                                    .of(context)
                                                    .primaryColor,
                                                weight: FontWeight.w500,
                                                maxLines: 1,),
                                            ),
                                            // Icon(Icons.arrow_drop_down_outlined)
                                          ],
                                        );
                                      }),
                                    ),
                                    Obx(() {
                                      final ctrl = c.getquranjuzdetail.value
                                          .getQuranJuzVersesList![0];
                                      return Stxt(
                                        text: "${ctrl.juzNameArb}", size: f1,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,);
                                    })
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
                                      Obx(() {
                                        final ctrl = c.getquranjuzdetail.value
                                            .getQuranJuzVersesList![0];
                                        return Stxt(
                                          text: "${ctrl.totalVerses}",
                                          size: f2,
                                          color: Theme
                                              .of(context)
                                              .primaryColor,
                                          weight: FontWeight.w500,);
                                      })
                                    ],
                                  )),
                              Space(40)
                            ],
                          ),
                        ),
                      ),
                      Space(16),
                      Expanded(
                          child:

                          Obx(() {
                            return c.isLoadingsJuz.value
                                ? loading(context)
                                : ListView
                                .builder(
                                itemCount: c.getquranjuzdetail.value
                                    .getQuranJuzVersesList![0].ayahList!.length,
                                itemBuilder: (context, index) {
                                  var juz = c.getquranjuzdetail.value
                                      .getQuranJuzVersesList![0]
                                      .ayahList![index];
                                  return Container(
                                      width: double.infinity,
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(10.r),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .end,
                                                  children: [
                                                    // Space(8),
                                                    ...c.pages.map((e) =>
                                                    e['verse'] == juz.versesKey
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
                                                                  color: Colors
                                                                      .white,
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
                                                        print('ssss${c
                                                            .getquranjuzdetail
                                                            .value
                                                            .getQuranJuzVersesList![0]
                                                            .juzNameEn}');
                                                        // if(c.passint.value==sura.versesKey![0]){
                                                        //   print("ggg");
                                                        //   c.toogle(index);
                                                        // }
                                                        c.toogle(
                                                            "${c
                                                                .getquranjuzdetail
                                                                .value
                                                                .getQuranJuzVersesList![0]
                                                                .juzNameEn} ${juz
                                                                .versesKey}");

                                                        //   c.toggleBookmark();

                                                      },

                                                      child:
                                                      //   print("eeee${c.objectList}");
                                                      // print("eeee${sura.versesKey
                                                      //     .toString()}");
                                                      // final isBookmarked = c.isBookmarked.value;
                                                      Obx(() {
                                                        //   print("eeee${c.objectList}");
                                                        print(
                                                            "eeee${juz.versesKey
                                                                .toString()}");
                                                        // final isBookmarked = c.isBookmarked.value;
                                                        return Icon(
                                                          c.buttonsSelected
                                                              .contains(
                                                              "${c
                                                                  .getquranjuzdetail
                                                                  .value
                                                                  .getQuranJuzVersesList![0]
                                                                  .juzNameEn} ${juz
                                                                  .versesKey}")
                                                              ? Icons.bookmark
                                                              : Icons
                                                              .bookmark_outline,
                                                          color: c
                                                              .buttonsSelected
                                                              .contains(
                                                              "${c
                                                                  .getquranjuzdetail
                                                                  .value
                                                                  .getQuranJuzVersesList![0]
                                                                  .juzNameEn} ${juz
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
                                                            // PopupMenuItem(child: Row(
                                                            //   children: [
                                                            //     Image.asset(
                                                            //       "assets/images/bookmark.png",
                                                            //       width: 20,
                                                            //       color: Colors.black,),
                                                            //     Space(12),
                                                            //     Text("Bookmark"),
                                                            //   ],
                                                            // )),
                                                            PopupMenuItem(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .copy),
                                                                    Space(12),
                                                                    Text(
                                                                        "Copy"),
                                                                  ],
                                                                )),
                                                            PopupMenuItem(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .share),
                                                                    Space(12),
                                                                    Text(
                                                                        "Share"),
                                                                  ],
                                                                )),
                                                            // PopupMenuItem(
                                                            //     child: GestureDetector(
                                                            //       onTap: (){
                                                            //         QuranPlanner(context);
                                                            //       },
                                                            //       child: Row(
                                                            //         children: [
                                                            //           Icon(Icons
                                                            //               .next_plan),
                                                            //           Space(12),
                                                            //           Text("Planner"),
                                                            //         ],
                                                            //       ),
                                                            //     )),
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
                                                                      Image
                                                                          .asset(
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
                                                    // Space(12),
                                                    Text(
                                                      "${juz.versesKey}",
                                                      style: TextStyle(
                                                          color: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          fontSize: 18),
                                                    ),
                                                    28.horizontalSpace,
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
                                                              .sliderValue
                                                              .value;
                                                          if (sliderValue ==
                                                              1) {
                                                            // Set font size to 35.0 when sliderValue is 1 (Medium)
                                                            fontSize = 45.0;
                                                          } else
                                                          if (sliderValue ==
                                                              2) {
                                                            // Set font size to 40.0 when sliderValue is 2 (Large)
                                                            fontSize = 55.0;
                                                          }
                                                          TextStyle textStyle = TextStyle(
                                                            wordSpacing: 10,
                                                            fontSize: fontSize,
                                                            fontFamily: c
                                                                .fontFamily
                                                                .value ==
                                                                "indopak"
                                                                ? "Indopak"
                                                                : c.fontFamily
                                                                .value ==
                                                                "qalam"
                                                                ? "Qalam" : c
                                                                .fontFamily
                                                                .value ==
                                                                "uthami"
                                                                ? "Uthami" : c
                                                                .fontFamily
                                                                .value ==
                                                                "amiri"
                                                                ? "Amiri" : c
                                                                .fontFamily
                                                                .value ==
                                                                "noorehira"
                                                                ? "Noorehira"
                                                                : c
                                                                .fontFamily
                                                                .value ==
                                                                "noorehuda"
                                                                ? "Noorehuda"
                                                                : c
                                                                .fontFamily
                                                                .value ==
                                                                "noorehidayat"
                                                                ? "Noorehidayat"
                                                                : c
                                                                .fontFamily
                                                                .value ==
                                                                "arabictit"
                                                                ? "Arabictitle"
                                                                : null, // Use the default font if "Amiri" is not selected
                                                          );
                                                          return SizedBox(
                                                            width: c
                                                                .screenWidth *
                                                                0.65,
                                                            child: c
                                                                .isCheckedArabic
                                                                .value == true
                                                                ? Text(
                                                              "${juz
                                                                  .arabicText}ِ",
                                                              style: textStyle,
                                                              textAlign:
                                                              TextAlign.end,
                                                            )
                                                                : SizedBox(),
                                                            // Text(
                                                            //   "${sura.arabicText}",
                                                            //   style: TextStyle(
                                                            //
                                                            //       fontSize: 25,
                                                            //       fontWeight: FontWeight.w500,
                                                            //       color:
                                                            //       Theme
                                                            //           .of(context)
                                                            //           .colorScheme.primary),
                                                            //   textAlign: TextAlign.end,
                                                            // ),
                                                          );
                                                        })
                                                    ),
                                                  ],
                                                ),
                                                // Container(
                                                //   width: 21.w,
                                                //   height: 21.w,
                                                //   child: Transform.rotate(
                                                //     angle: 40 *
                                                //         (3.1415926535897932 / 180),
                                                //     // Converting 30 degrees to radians
                                                //     child: Container(
                                                //       width: 200,
                                                //       height: 200,
                                                //       decoration: BoxDecoration(
                                                //         borderRadius:
                                                //         BorderRadius.circular(4),
                                                //         color: Color(0xff16627C),
                                                //       ),
                                                //       child: Center(
                                                //         child: Transform.rotate(
                                                //           angle: -40 *
                                                //               (3.1415926535897932 /
                                                //                   180),
                                                //           child: Text(
                                                //             "${sura.versesKey}",
                                                //             style: TextStyle(
                                                //                 fontSize: 11,
                                                //                 fontWeight: FontWeight
                                                //                     .bold,
                                                //                 color: Colors.white),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment
                                                //       .start,
                                                //   children: [
                                                //
                                                //   ],
                                                // ),
                                                // Space(8),
                                                // Row(
                                                //   children: [
                                                //     Space(12),
                                                //
                                                //     // Container(
                                                //     //   width: 20.w,
                                                //     //   height: 20.w,
                                                //     //   child: Transform.rotate(
                                                //     //     angle: 40 *
                                                //     //         (3.1415926535897932 / 180),
                                                //     //     // Converting 30 degrees to radians
                                                //     //     child: Container(
                                                //     //       width: 200,
                                                //     //       height: 200,
                                                //     //       decoration: BoxDecoration(
                                                //     //         borderRadius:
                                                //     //         BorderRadius.circular(4),
                                                //     //         color: Color(0xff16627C),
                                                //     //       ),
                                                //     //       child: Center(
                                                //     //         child: Transform.rotate(
                                                //     //           angle: -40 *
                                                //     //               (3.1415926535897932 /
                                                //     //                   180),
                                                //     //           child: Text(
                                                //     //             "${sura.ayahNo}",
                                                //     //             style: TextStyle(
                                                //     //                 fontSize: 10,
                                                //     //                 fontWeight: FontWeight
                                                //     //                     .bold,
                                                //     //                 color: Colors.white),
                                                //     //           ),
                                                //     //         ),
                                                //     //       ),
                                                //     //     ),
                                                //     //   ),
                                                //     // ),
                                                //   ],
                                                // ),
                                                Space(8),

                                                // Row(
                                                //   children: [
                                                //     Space(12),
                                                //
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Obx(
                                                //           () => IconButton(
                                                //         icon: Icon(controller.isPlaying.value
                                                //             ? Icons.pause
                                                //             : Icons.play_arrow),
                                                //         iconSize: 40.0,
                                                //         onPressed: () {
                                                //           if (controller.isPlaying.value) {
                                                //             controller.pause();
                                                //           } else {
                                                //             controller.play();
                                                //           }
                                                //         },
                                                //       ),
                                                //     ),
                                                //     Obx(
                                                //           () => Slider(
                                                //         value: controller.sliderValue.value,
                                                //         min: 0.0,
                                                //         max: controller.totalDuration.inMilliseconds.toDouble(),
                                                //         onChanged: (value) {
                                                //           controller.seekTo(value);
                                                //         },
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                Space(16),
                                                Obx(() {
                                                  double fontSize = 18.0;
                                                  double sliderValue = c
                                                      .sliderValue1
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
                                                              .center,
                                                          child:
                                                          c.isCheckedEnglish
                                                              .value ==
                                                              true
                                                              ? Text(
                                                            "${juz
                                                                .engTranslation}",
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
                                                  double sliderValue = c
                                                      .sliderValue1
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
                                                              .center,
                                                          child: c
                                                              .isCheckedTamil
                                                              .value
                                                              ? Text(
                                                            "${juz
                                                                .tamilTranslation}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: fontSize),
                                                          )
                                                              : SizedBox
                                                              .shrink()));
                                                }),
                                                Space(16),
                                                Image.asset(
                                                  "assets/images/qurandivider.png",
                                                  scale: 4,
                                                  width: 310.w,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  );
                                }
                            );
                          })


                      )

                    ],
                  ),
                );
              });
            },
          )
      );
    });
  }
}
