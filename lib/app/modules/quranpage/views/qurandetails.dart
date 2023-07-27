import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/tajweed_rules.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/space.dart';
import '../../audioplayer/controllers/audioplayer_controller.dart';
import '../controllers/quranpage_controller.dart';
import '../model/quran_detail_model.dart';
import '../model/quran_model.dart';

class QuranDetails extends StatefulWidget {
  QuranDetails({super.key});

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

final QuranpageController c = Get.put(QuranpageController());
final AudioplayerController controller = Get.put(AudioplayerController());

class _QuranDetailsState extends State<QuranDetails> {
  var makki = c.getqurandetail.value.getQuranAyahVerse![0].makkiMadina;
  var madni = c.getqurandetail.value.getQuranAyahVerse![0].makkiMadina;
  var chapterno = c.getqurandetail.value.getQuranAyahVerse![0].suraChapterNo;
  var sura = c.getqurandetail.value.getQuranAyahVerse![0].suraNameEn;
  var title = c.getqurandetail.value.getQuranAyahVerse![0].titleEn;
  var verse = c.getqurandetail.value.getQuranAyahVerse![0].totalVerses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: c.scaffoldKey,
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            controller: c.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Space(20),
                Text(
                  "Customize your Quran",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600
                  ),
                ),
                Space(16),
                Text(
                  "View",
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
                        Text("Sura"),
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
                        Text("Page"),
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
                        Text("Juz"),
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
                        Text("Hizb"),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
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
                // Divider(
                //   thickness: 1,
                // ),
                Space(8),
                Text(
                  "Arabic Font",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff16627C)),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      title: Text("IndoPak Script"),
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
                                    Text("Noorehira"),
                                    Spacer(),
                                    SvgPicture.asset(
                                        "assets/svg/noorehira.svg", width: 60,
                                        color: Colors.black.withOpacity(0.6))
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
                                    Text("Noorehuda"),
                                    Spacer(),
                                    SvgPicture.asset(
                                        "assets/svg/noorehuda.svg", width: 60,
                                        color: Colors.black.withOpacity(0.6))
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
                                    Text("Noorehidayat"),
                                    Spacer(),
                                    SvgPicture.asset(
                                        "assets/svg/noorehidayat.svg",
                                        width: 60,
                                        color: Colors.black.withOpacity(0.6))
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
                      title: Text("Uthmani/Madani Script"),
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
                                    Text("Quran"),
                                    Spacer(),
                                    SvgPicture.asset(
                                        "assets/svg/quran.svg", width: 60,
                                        color: Colors.black.withOpacity(0.6))
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
                                    Text("Qalam"),
                                    Spacer(),
                                    SvgPicture.asset(
                                        "assets/svg/qalam.svg", width: 60,
                                        color: Colors.black.withOpacity(0.6))
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
                                    Text("KFGQPC Hafs"),
                                    Spacer(),
                                    SvgPicture.asset(
                                        "assets/svg/KFGQPC.svg", width: 60,
                                        color: Colors.black.withOpacity(0.6))
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
                                    Text("Amiri"),
                                    Spacer(),
                                    SvgPicture.asset(
                                      "assets/svg/amiri.svg", width: 60,
                                      color: Colors.black.withOpacity(0.5),),
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
                      Text("Tajweed Rules", style: TextStyle(
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
                    Text('Medium', style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
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
                    Text('Medium', style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text('Large', style: TextStyle(
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
      body: Padding(
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
                                image: makki == "Makki" ? AssetImage(
                                    'assets/images/makka.png') : AssetImage(
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
                              Stxt(text: "${makki}", size: f2, color: Theme
                                  .of(context)
                                  .primaryColor, weight: FontWeight.w500,)
                            ],
                          )),
                    ),
                    // Space(60),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8, right: 32, left: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
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
                                                  isAlwaysShown: true,
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
                                                    itemBuilder: (context,
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
                                                    itemBuilder: (context,
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
                                                    itemBuilder: (context,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${chapterno}. ", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),),
                                SizedBox(
                                  width: 90.w,
                                  child: Stxt(
                                    text: "${sura}",
                                    size: f2,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    weight: FontWeight.w500,
                                    maxLines: 1,),
                                ),
                                // Text(
                                //   "${sura}",
                                //   style: TextStyle(
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w500,
                                //       color: Theme
                                //           .of(context)
                                //           .primaryColor),
                                // ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                          ),
                          Stxt(text: "${title}", size: f1,
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
                            Stxt(text: "Ayah", size: f1, color: Theme
                                .of(context)
                                .primaryColor, weight: FontWeight.w500,),
                            Stxt(text: "${verse}", size: f2, color: Theme
                                .of(context)
                                .primaryColor, weight: FontWeight.w500,)
                          ],
                        )),
                    Space(30)
                  ],
                ),
              ),
            ),
            Space(16),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: 8,
                controller: c.scrollController,
                radius: Radius.circular(20),
                child: Obx(() {
                  return c.isLoadings.value
                      ? loading(context)
                      : ListView.builder(
                      itemCount: c.getqurandetail.value
                          .getQuranAyahVerse![0].ayahList!.length,
                      itemBuilder: (context, index) {
                        var sura = c.getqurandetail.value
                            .getQuranAyahVerse![0].ayahList![index];
                        return Container(
                            width: double.infinity,
                            // color: Colors.red,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.r),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Space(12),
                                          Text(
                                            "${sura.versesKey}",
                                            style: TextStyle(
                                                color: Theme
                                                    .of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          20.horizontalSpace,
                                          Space(10.w),
                                          Align(
                                              alignment:
                                              Alignment.centerLeft,
                                              child: Obx(() {
                                                double fontSize = 35.0;
                                                String fontFamily = c.fontFamily
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
                                                  fontSize: fontSize,
                                                  fontFamily: c.fontFamily
                                                      .value == "indopak"
                                                      ? "Indopak"
                                                      : c.fontFamily.value ==
                                                      "qalam"
                                                      ? "Qalam" : c.fontFamily
                                                      .value == "uthami"
                                                      ? "Uthami" : c.fontFamily
                                                      .value == "amiri"
                                                      ? "Amiri" : c.fontFamily
                                                      .value == "noorehira"
                                                      ? "Noorehira" : c
                                                      .fontFamily
                                                      .value == "noorehuda"
                                                      ? "Noorehuda" : c
                                                      .fontFamily
                                                      .value == "noorehidayat"
                                                      ? "Noorehidayat"
                                                      : null, // Use the default font if "Amiri" is not selected
                                                );
                                                return SizedBox(
                                                  width: c.screenWidth * 0.65,
                                                  child: c.isCheckedArabic
                                                      .value == true
                                                      ? Text(
                                                    "${sura.arabicText}",
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          PopupMenuButton(
                                              shadowColor: Colors.grey.shade400,
                                              itemBuilder: (
                                                  BuildContext context) {
                                                return [
                                                  PopupMenuItem(child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/bookmark.png",
                                                        width: 20,
                                                        color: Colors.black,),
                                                      Space(12),
                                                      Text("Bookmark"),
                                                    ],
                                                  )),
                                                  PopupMenuItem(child: Row(
                                                    children: [
                                                      Icon(Icons.copy),
                                                      Space(12),
                                                      Text("Copy"),
                                                    ],
                                                  )),
                                                  PopupMenuItem(child: Row(
                                                    children: [
                                                      Icon(Icons.share),
                                                      Space(12),
                                                      Text("Share"),
                                                    ],
                                                  )),
                                                  PopupMenuItem(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (
                                                                BuildContext context) {
                                                              return CustomDialogBox1(
                                                                title: 'Custom Dialog Title',
                                                                content:
                                                                'This is the content of the custom dialog box.',
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context); // Closes the dialog box when the button is pressed.
                                                                },
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
                                          )
                                        ],
                                      ),
                                      // Space(8),
                                      Row(
                                        children: [
                                          Space(12),
                                          Icon(
                                            Icons.play_circle,
                                            color: Theme
                                                .of(context)
                                                .primaryColor,
                                          ),
                                          // Container(
                                          //   width: 20.w,
                                          //   height: 20.w,
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
                                          //             "${sura.ayahNo}",
                                          //             style: TextStyle(
                                          //                 fontSize: 10,
                                          //                 fontWeight: FontWeight
                                          //                     .bold,
                                          //                 color: Colors.white),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Space(8),
                                      Row(
                                        children: [
                                          Space(12),
                                          GestureDetector(
                                            onTap: (){
                                              c.toggleBookmark();
                                            },

                                            child: Obx(() {
                                              final isBookmarked = c.isBookmarked.value;
                                              return Icon(
                                                isBookmarked
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_outline,
                                                color: isBookmarked
                                                    ? Theme
                                                    .of(context)
                                                    .primaryColor
                                                    : Colors
                                                    .grey, // Use different colors for bookmarked and not bookmarked states
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
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
                                                child:
                                                c.isCheckedEnglish.value == true
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
                                                child: c.isCheckedTamil.value
                                                    ? Text(
                                                  "${sura.tamilTranslation}",
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
                                ),
                              ],
                            ));
                      });
                }),
              ),
            )
          ],
        ),
      ),
    );
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
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomDialogBox1({
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

