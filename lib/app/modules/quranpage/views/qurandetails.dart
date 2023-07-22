import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/space.dart';
import '../controllers/quranpage_controller.dart';
import '../model/quran_detail_model.dart';

class QuranDetails extends StatefulWidget {
  QuranDetails({super.key});

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

final QuranpageController c = Get.put(QuranpageController());

class _QuranDetailsState extends State<QuranDetails> {
  var makki = c.getqurandetail.value.getQuranAyahVerse![0].makkiMadina;
  var chapterno = c.getqurandetail.value.getQuranAyahVerse![0].suraChapterNo;
  var sura = c.getqurandetail.value.getQuranAyahVerse![0].suraNameEn;
  var title = c.getqurandetail.value.getQuranAyahVerse![0].titleEn;
  var verse = c.getqurandetail.value.getQuranAyahVerse![0].totalVerses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
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
              width:330.w,
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
                              Text(
                                "${makki}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),
                              ),
                              Text(
                                "${chapterno}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),
                              ),
                            ],
                          )),
                    ),
                    // Space(60),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 32, left: 32),
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
                            child: Row(
                              children: [
                                Text(
                                  "${sura}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                          ),
                          Text(
                            "${title}",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      width: 50,
                      // color: Colors.red,
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ayah",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),
                              ),
                              Text(
                                "${verse}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),
                              ),
                            ],
                          )),
                    ),
                    Space(24)
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
                                                return SizedBox(
                                                    width: c.screenWidth*0.7,
                                                    child: c.isCheckedArabic
                                                        .value == true
                                                        ? Text(
                                                      "${sura.arabicText}",
                                                      style: GoogleFonts
                                                          .kalam(
                                                        textStyle: Theme
                                                            .of(
                                                            context)
                                                            .textTheme
                                                            .displayLarge,
                                                        fontSize: 30,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .colorScheme
                                                            .primary,
                                                        wordSpacing: 3,
                                                      ),
                                                      textAlign:
                                                      TextAlign.end,
                                                    )
                                                        : SizedBox()
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
                                              })),
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
                                      Space(8),
                                      Row(
                                        children: [
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
                                      Icon(
                                        Icons.bookmark,
                                        color:
                                        Theme
                                            .of(context)
                                            .primaryColor,
                                      ),
                                      Space(16),
                                      Obx(() {
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
                                                      fontSize: 18),
                                                )
                                                    : SizedBox()));
                                      }),
                                      Space(16),
                                      Obx(() {
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
                                                      fontSize: 18),
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
            children: [
              Obx(() {
                return Checkbox(
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
                );
              }),
              Text("Arabic"),
              Obx(() {
                return Checkbox(
                  activeColor: Get.theme.primaryColor,
                  checkColor: Colors.white,
                  value: c.isCheckedEnglish.value,
                  onChanged: (value) => c.isCheckedEnglish.value = value!,
                );
              }),
              Text("English"),
              Obx(() {
                return Checkbox(
                  activeColor: Get.theme.primaryColor,
                  checkColor: Colors.white,
                  value: c.isCheckedTamil.value,
                  onChanged: (value) => c.isCheckedTamil.value = value!,
                );
              }),
              Text("Tamil"),
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
          Obx(() {
            return FocusScope(
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        activeColor: Get.theme.primaryColor,
                        // title: Text("Amiri"),
                        value: "font",
                        groupValue: c.fontAmiri.value,

                        onChanged: (groupValue) => {
                          c.fontAmiri.value = groupValue!,
                        c.radioGroupFocus1.nextFocus(),
                        }
                      ),
                      Text("Amiri"),
                      Space(32),
                      Radio(
                        activeColor: Get.theme.primaryColor,
                        // title: Text("Kalam"),
                        value: "font",
                        groupValue: c.fontKalam.value,
                        onChanged: (groupValue) => {
                          c.fontKalam.value = groupValue!,
                          c.radioGroupFocus1.nextFocus(),
                        }

                      ),
                      Text("Kalam"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Get.theme.primaryColor,
                        // title: Text("Amiri"),
                        value: "font",
                        groupValue: c.fontFont3.value,
                        onChanged: (groupValue) => {c.fontAmiri.value = groupValue!,
                          c.radioGroupFocus2.nextFocus(),
                        }
                      ),
                      Text("Font 3"),
                      Space(32),
                      Radio(
                        activeColor: Get.theme.primaryColor,
                        // title: Text("Kalam"),
                        value: "font",
                        groupValue: c.fontFont4.value,
                        onChanged: (groupValue) => {
                          c.fontAmiri.value = groupValue!,
                          c.radioGroupFocus1.nextFocus(),
                        }
                      ),
                      Text("Font 4"),
                    ],
                  ),
                ],
              ),
            );
          }),
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
                child: Text('Small', style: TextStyle(fontSize: 14)),
              ),
              Text('Medium', style: TextStyle(fontSize: 14)),
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text('Large', style: TextStyle(fontSize: 14)),
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
                child: Text('Small', style: TextStyle(fontSize: 14)),
              ),
              Text('Medium', style: TextStyle(fontSize: 15)),
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text('Large', style: TextStyle(fontSize: 17)),
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
