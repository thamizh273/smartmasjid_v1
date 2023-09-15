import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/duapage/model/dua_model.dart';
import 'package:smartmasjid_v1/app/modules/duapage/views/daily_dua.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/model/quran_model.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../widgets/space.dart';
import '../../language_page/controllers/language_page_controller.dart';
import '../controllers/duapage_controller.dart';
import 'dua_detail.dart';

class DuapageView extends GetView<DuapageController> {
  DuapageView({Key? key}) : super(key: key);

  final DuapageController c = Get.put(DuapageController());
  final Color oddItemColor = Color(0xffB5CCD4);
  final Color evenItemColor = Color(0xff6C9AA9);
  final Color other = Color(0xff84ABB7);
  final langCtrl = Get.put(LanguagePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "dua".tr,
      ),
      body: Center(
        child: Obx(() {
          return c.isLoadings.value
              ? loading(context)
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.start,
                    controller: c.scrollController,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "i_am_feeling".tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            return SizedBox(
                              //height: 400,
                              child: GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                controller: c.scrollController,
                                itemCount: c.isExpanded.value
                                    ? c.getduadata.value.getDuasTitleList!
                                        .feeling!.length
                                    : 9,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.landscape
                                          ? 3
                                          : 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: (2 / 1),
                                ),
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  var dua = c.getduadata.value.getDuasTitleList!
                                      .feeling![index];
                                  Color color = index % 2 == 0
                                      ? evenItemColor
                                      : oddItemColor;
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => DuaDetail()));
                                      Get.to(DuaDetail());
                                      c.duadetailList(dua.duasNameEn);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      // color: RandomColorModel().getColor(),
                                      child: Center(
                                        child: Text(
                                            langCtrl
                                                        .selectedLang.value ==
                                                    "ENGLISH"
                                                ? dua.duasNameEn.toString()
                                                : langCtrl.selectedLang
                                                            .value ==
                                                        "Tamil(தமிழ்)"
                                                    ? dua.duasNameTamil
                                                        .toString()
                                                    : langCtrl.selectedLang
                                                                .value ==
                                                            "Urdu(اردو)"
                                                        ? dua
                                                            .duasNameUrdu
                                                            .toString()
                                                        : langCtrl
                                                                    .selectedLang
                                                                    .value ==
                                                                "Hindi(हिंदी)"
                                                            ? dua
                                                                .duasNameHindi
                                                                .toString()
                                                            : langCtrl.selectedLang
                                                                        .value ==
                                                                    "Malayalam(മലയാളം)"
                                                                ? dua
                                                                    .duasNameMalayalam
                                                                    .toString()
                                                                : langCtrl.selectedLang
                                                                            .value ==
                                                                        "Telugu(తెలుగు)"
                                                                    ? dua
                                                                        .duasNameTelugu
                                                                        .toString()
                                                                    : dua
                                                                        .duasNameEn
                                                                        .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        ),
                        Obx(() {
                          return GestureDetector(
                            child: Container(
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    c.isExpanded.value
                                        ? "See Less"
                                        : "See More",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    c.isExpanded.value
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              c.isExpanded.toggle();
                            },
                          );
                        }),
                        Space(16),
                        Stxt(
                          text: "daily".tr,
                          size: f4,
                          weight: FontWeight.w500,
                        ),
                        Space(16),
                        Obx(() {
                          return SizedBox(
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              controller: c.scrollController,
                              shrinkWrap: true,
                              itemCount: c.isExpanded1.value
                                  ? c.getduadata.value.getDuasTitleList!.daily!
                                      .length
                                  : 4,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? 3
                                        : 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: (2 / 1),
                              ),
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                var daily = c.getduadata.value.getDuasTitleList!
                                    .daily![index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(index);
                                      },
                                    );
                                  },
                                  child: FractionallySizedBox(
                                    heightFactor: 0.8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: Color(0xff17637D)),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Image.asset(
                                                  "assets/images/${c.getduadata.value.getDuasTitleList!.daily![index].duasNameEn!.toLowerCase()}.png")),
                                          SizedBox(width: 8),
                                          SizedBox(
                                            width: .16.sw,
                                            child: Text(
                                              langCtrl.selectedLang.value ==
                                                      "ENGLISH"
                                                  ? daily.duasNameEn.toString()
                                                  : langCtrl.selectedLang.value ==
                                                          "Tamil(தமிழ்)"
                                                      ? daily.duasNameTamil
                                                          .toString()
                                                      : langCtrl.selectedLang
                                                                  .value ==
                                                              "Hindi(हिंदी)"
                                                          ? daily.duasNameHindi
                                                              .toString()
                                                          : langCtrl.selectedLang
                                                                      .value ==
                                                                  "Urdu(اردو)"
                                                              ? daily
                                                                  .duasNameUrdu
                                                                  .toString()
                                                              : langCtrl.selectedLang
                                                                          .value ==
                                                                      "Malayalam(മലയാളം)"
                                                                  ? daily
                                                                      .duasNameMalayalam
                                                                      .toString()
                                                                  : langCtrl.selectedLang
                                                                              .value ==
                                                                          "Telugu(తెలుగు)"
                                                                      ? daily
                                                                          .duasNameTelugu
                                                                          .toString()
                                                                      : daily
                                                                          .duasNameEn
                                                                          .toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          return GestureDetector(
                            child: Container(
                              width: 90.w,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    c.isExpanded1.value
                                        ? "See Less"
                                        : "See More",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                      c.isExpanded1.value
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                            onTap: () {
                              c.isExpanded1.toggle();
                            },
                          );
                        }),
                        Space(16),
                        Stxt(
                          text: "occasion".tr,
                          size: f4,
                          weight: FontWeight.w500,
                        ),
                        Space(8),
                        SizedBox(
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            controller: c.scrollController1,
                            shrinkWrap: true,
                            itemCount: c.getduadata.value.getDuasTitleList!
                                .occasion!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? 3
                                      : 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 1,
                              childAspectRatio: (2 / 1),
                            ),
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              var occasion = c.getduadata.value
                                  .getDuasTitleList!.occasion![index];
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox1(index);
                                    },
                                  );
                                },
                                child: FractionallySizedBox(
                                  heightFactor: 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border:
                                          Border.all(color: Color(0xff17637D)),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.asset(
                                                "assets/images/${c.getduadata.value.getDuasTitleList!.occasion![index].duasNameEn!.toLowerCase()}.png")),
                                        SizedBox(width: 8),
                                        SizedBox(
                                          width: .2.sw,
                                          child: Text(
                                            langCtrl.selectedLang.value ==
                                                    "ENGLISH"
                                                ? occasion.duasNameEn.toString()
                                                : langCtrl.selectedLang.value ==
                                                        "Tamil(தமிழ்)"
                                                    ? occasion.duasNameTamil
                                                        .toString()
                                                    : langCtrl.selectedLang
                                                                .value ==
                                                            "Urdu(اردو)"
                                                        ? occasion.duasNameUrdu
                                                            .toString()
                                                        : langCtrl.selectedLang
                                                                    .value ==
                                                                "Hindi(हिंदी)"
                                                            ? occasion
                                                                .duasNameHindi
                                                                .toString()
                                                            : langCtrl
                                                                        .selectedLang
                                                                        .value ==
                                                                    "Malayalam(മലയാളം)"
                                                                ? occasion
                                                                    .duasNameMalayalam
                                                                    .toString()
                                                                : langCtrl.selectedLang
                                                                            .value ==
                                                                        "Telugu(తెలుగు)"
                                                                    ? occasion
                                                                        .duasNameTelugu
                                                                        .toString()
                                                                    : occasion
                                                                        .duasNameEn
                                                                        .toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController c = TextEditingController();
  final duaCtrl = Get.put(DuapageController());
  final langCtrl = Get.put(LanguagePageController());

  CustomDialogBox(this.index);

  int index;

  @override
  Widget build(BuildContext context) {
    var duaList = duaCtrl.getduadata.value.getDuasTitleList!.daily!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(
          context,

          ///title
          langCtrl.selectedLang.value == "ENGLISH"
              ? duaList[index].duasNameEn
              : langCtrl.selectedLang.value == "Tamil(தமிழ்)"
                  ? duaList[index].duasNameTamil
                  : langCtrl.selectedLang.value == "Urdu(اردو)"
                      ? duaList[index].duasNameUrdu
                      : langCtrl.selectedLang.value == "Hindi(हिंदी)"
                          ? duaList[index].duasNameHindi
                          : langCtrl.selectedLang.value == "Malayalam(മലയാളം)"
                              ? duaList[index].duasNameMalayalam
                              : langCtrl.selectedLang.value == "Telugu(తెలుగు)"
                                  ? duaList[index].duasNameTelugu
                                  : duaList[index].duasNameEn,

          ///items
          langCtrl.selectedLang.value == "ENGLISH"
              ? duaList[index].titlesList!.map((e) => e.title).toList()
              : langCtrl.selectedLang.value == "Tamil(தமிழ்)"
                  ? duaList[index].titlesList!.map((e) => e.titleTamil).toList()
                  : langCtrl.selectedLang.value == "Urdu(اردو)"
                      ? duaList[index]
                          .titlesList!
                          .map((e) => e.titleUrdu)
                          .toList()
                      : langCtrl.selectedLang.value == "Hindi(हिंदी)"
                          ? duaList[index]
                              .titlesList!
                              .map((e) => e.titleHindi)
                              .toList()
                          : langCtrl.selectedLang.value == "Malayalam(മലയാളം)"
                              ? duaList[index]
                                  .titlesList!
                                  .map((e) => e.titleMalayalam)
                                  .toList()
                              : langCtrl.selectedLang.value == "Telugu(తెలుగు)"
                                  ? duaList[index]
                                      .titlesList!
                                      .map((e) => e.titleTelugu)
                                      .toList()
                                  : duaList[index]
                                      .titlesList!
                                      .map((e) => e.title),

          ///Count
          duaList[index].titlesList!.length),
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    String? title,
    items,
    int count,
  ) {
    var duaList = duaCtrl.getduadata.value.getDuasTitleList!.daily!;
    print(count);
    print(items);
    print(title);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xffB5CCD4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100.h,
            width: 180.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Image.asset(
              "assets/images/${duaList[index].duasNameEn!.toLowerCase()}.png",
              fit: BoxFit.fill,
            ),
          ),
          Space(16),
          Stxt(
            text: "${title}",
            size: f5,
            weight: FontWeight.w500,
          ),
          Space(16),
          Container(
            constraints: BoxConstraints(
              maxHeight: 400,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: count,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(DailyDua());
                      print(
                          " ffff${duaList[index].titlesList!.map((e) => e.title).toList()}");
                      duaCtrl.duadaily(duaList[index]
                          .titlesList!
                          .map((e) => e.title)
                          .toList()[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Space(8),
                            SizedBox(
                                width: 200.w,
                                child: Stxt(
                                  text: "${items[index]}",
                                  size: f3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                            ),
                            Space(8)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class CustomDialogBox1 extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController c = TextEditingController();
  final duaCtrl = Get.put(DuapageController());
  final langCtrl = Get.put(LanguagePageController());

  CustomDialogBox1(this.index);

  int index;

  @override
  Widget build(BuildContext context) {
    var occasionList = duaCtrl.getduadata.value.getDuasTitleList!.occasion!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(
          context,

          ///title
          langCtrl.selectedLang.value == "ENGLISH"
              ? occasionList[index].duasNameEn
              : langCtrl.selectedLang.value == "Tamil(தமிழ்)"
                  ? occasionList[index].duasNameTamil
                  : langCtrl.selectedLang.value == "Urdu(اردو)"
                      ? occasionList[index].duasNameUrdu
                      : langCtrl.selectedLang.value == "Hindi(हिंदी)"
                          ? occasionList[index].duasNameUrdu
                          : langCtrl.selectedLang.value == "Malayalam(മലയാളം)"
                              ? occasionList[index].duasNameMalayalam
                              : langCtrl.selectedLang.value == "Telugu(తెలుగు)"
                                  ? occasionList[index].duasNameTelugu
                                  : occasionList[index].duasNameEn,

          ///items
          langCtrl.selectedLang.value == "ENGLISH"
              ? occasionList[index].titlesList!.map((e) => e.title).toList()
              : langCtrl.selectedLang.value == "Tamil(தமிழ்)"
                  ? occasionList[index]
                      .titlesList!
                      .map((e) => e.titleTamil)
                      .toList()
                  : langCtrl.selectedLang.value == "Urdu(اردو)"
                      ? occasionList[index]
                          .titlesList!
                          .map((e) => e.titleUrdu)
                          .toList()
                      : langCtrl.selectedLang.value == "Hindi(हिंदी)"
                          ? occasionList[index]
                              .titlesList!
                              .map((e) => e.titleHindi)
                              .toList()
                          : langCtrl.selectedLang.value == "Malayalam(മലയാളം)"
                              ? occasionList[index]
                                  .titlesList!
                                  .map((e) => e.titleMalayalam)
                                  .toList()
                              : langCtrl.selectedLang.value == "Telugu(తెలుగు)"
                                  ? occasionList[index]
                                      .titlesList!
                                      .map((e) => e.titleTelugu)
                                      .toList()
                                  : occasionList[index]
                                      .titlesList!
                                      .map((e) => e.title)
                                      .toList(),

          ///count
          occasionList[index].titlesList!.length),
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    String? title,
    items,
    int count,
  ) {
    var occasionList = duaCtrl.getduadata.value.getDuasTitleList!.occasion!;
    print(count);
    print(items);
    print(title);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xffB5CCD4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100.h,
            width: 180.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Image.asset(
              "assets/images/${occasionList[index].duasNameEn!.toLowerCase()}.png",
              fit: BoxFit.fill,
            ),
          ),
          Space(16),
          Stxt(
            text: "${title}",
            size: f5,
            weight: FontWeight.w500,
          ),
          Space(16),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: count,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(DailyDua());
                      print("ffff${items[index]}");
                      duaCtrl.duadaily(occasionList[index]
                          .titlesList!
                          .map((e) => e.title)
                          .toList()[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Space(8),
                            SizedBox(
                                width: 200.w,
                                child: Stxt(
                                  text: "${items[index]}",
                                  size: f3,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                            ),
                            Space(8)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
