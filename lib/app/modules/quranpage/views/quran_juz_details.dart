
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/tajweed_rules.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import '../../../../widgets/Stextfield.dart';
import '../../../../widgets/gotoverse.dart';
import '../../../routes/export.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/quranpage_controller.dart';

class QuranJuzDetails extends StatelessWidget {
   QuranJuzDetails({super.key});
  final QuranpageController juzquranCtrl_ = Get.put(QuranpageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return juzquranCtrl_.isLoading.value ?  DialogHelper.showLoading() : Scaffold(
          key: juzquranCtrl_.scaffoldKey,
          endDrawer: Drawer(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600
                      ),
                    ),
                    Space(16),
                    Text(
                      "view".tr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.hoverColor),
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
                                groupValue: juzquranCtrl_.view.value,
                                onChanged: (groupValue) =>
                                    juzquranCtrl_.view(groupValue!),
                              );
                            }),
                            Text("surah".tr),
                            Obx(() {
                              return Radio(
                                activeColor: Get.theme.primaryColor,
                                // title: Text("Amiri"),
                                value: "page",
                                groupValue: juzquranCtrl_.view.value,
                                onChanged: (groupValue) =>
                                    juzquranCtrl_.view(groupValue!),
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
                                groupValue: juzquranCtrl_.view.value,
                                onChanged: (groupValue) =>
                                    juzquranCtrl_.view(groupValue!),
                              );
                            }),
                            Text("juz".tr),
                            Obx(() {
                              return Radio(
                                activeColor: Get.theme.primaryColor,
                                // title: Text("Amiri"),
                                value: "hizb",
                                groupValue: juzquranCtrl_.view.value,
                                onChanged: (groupValue) =>
                                    juzquranCtrl_.view(groupValue!),
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
                          color: Get.theme.hoverColor),
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
                                value: juzquranCtrl_.isCheckedArabic.value,
                                onChanged: (value) {
                                  juzquranCtrl_.isCheckedArabic.value = value!;
                                  Future.delayed(
                                      Duration(milliseconds: 500), () {
                                    juzquranCtrl_.getqurandetail();
                                  });
                                  juzquranCtrl_.update();
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
                                value: juzquranCtrl_.isCheckedEnglish.value,
                                onChanged: (value) {
                                  juzquranCtrl_.isCheckedEnglish.value = value!;
                                  Future.delayed(
                                      Duration(milliseconds: 500), () {
                                    juzquranCtrl_.getqurandetail();
                                  });
                                  juzquranCtrl_.update();
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
                                value: juzquranCtrl_.isCheckedTamil.value,
                                onChanged: (value) {
                                  juzquranCtrl_.isCheckedTamil.value = value!;
                                  Future.delayed(
                                      Duration(milliseconds: 500), () {
                                    juzquranCtrl_.getqurandetail();
                                  });
                                  juzquranCtrl_.update();
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
                      onTap: () async {
                        const String downloadedItemsKey = 'downloadedItems';
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        showModalBottomSheet(
                          backgroundColor:
                          Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            List<String> downloadedItems = prefs.getStringList(downloadedItemsKey) ?? [];
                            List<String> featuredLanguages = prefs.getStringList(downloadedItemsKey) ??[];
                            List<String> courseNames  = [
                              "Urdu (اردو)",
                              "Hindi (हिंदी)",
                              "Malayalam (മലയാളം)",
                              "Telugu (తెలుగు)",
                            ];
                            return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                List<RxBool> checkedStates = List.generate(featuredLanguages.length, (_) => RxBool(false));
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Get.theme.scaffoldBackgroundColor,
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
                                            color: Get.theme.hoverColor),
                                        Space(4),
                                        Safa_textfield(
                                          hint: "Search",
                                          fillColor: Colors.grey.shade50,
                                          suffixIcon: GestureDetector(
                                              onTap: (){
                                              },
                                              child: Icon(Icons.search)),
                                        ),
                                        Space(8),
                                        Expanded(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Stxt(text: "Downloads",
                                                      size: f4,
                                                      weight: FontWeight.w600,
                                                      color: Get.theme.hoverColor),
                                                ],
                                              ),
                                              Space(8),
                                              featuredLanguages.isEmpty? Center(child: Text("No Downloads Found")):ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: featuredLanguages.length,
                                                itemBuilder: (context, index) {
                                                  final featuredLanguage = featuredLanguages[index];
                                                  return ListTile(
                                                    leading: featuredLanguage== "Urdu (اردو)"? Obx(() {
                                                      return Container(
                                                        height: 30.h,
                                                        width: 30.w,
                                                        child: Transform.scale(
                                                          scale: 1,
                                                          child: Checkbox(
                                                            activeColor: Get.theme.primaryColor,
                                                            checkColor: Colors.white,
                                                            value: juzquranCtrl_.isCheckedUrdu.value,
                                                            onChanged: (value) {
                                                              juzquranCtrl_.isCheckedUrdu(value!);
                                                              Future.delayed(Duration(milliseconds: 500), () {
                                                                juzquranCtrl_.getquranjuzdetail();
                                                              });
                                                              juzquranCtrl_.update();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }): featuredLanguage== "Telugu (తెలుగు)"? Obx(() {
                                                      return Container(
                                                        height: 30.h,
                                                        width: 30.w,
                                                        child: Transform.scale(
                                                          scale: 1,
                                                          child: Checkbox(
                                                            activeColor: Get.theme.primaryColor,
                                                            checkColor: Colors.white,
                                                            value: juzquranCtrl_.isCheckedTelugu.value,
                                                            onChanged: (value) {
                                                              juzquranCtrl_.isCheckedTelugu(value!);
                                                              Future.delayed(Duration(milliseconds: 500), () {
                                                                juzquranCtrl_.getquranjuzdetail();
                                                              });
                                                              juzquranCtrl_.update();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }): featuredLanguage== "Malayalam (മലയാളം)"? Obx(() {
                                                      return Container(
                                                        height: 30.h,
                                                        width: 30.w,
                                                        child: Transform.scale(
                                                          scale: 1,
                                                          child: Checkbox(
                                                            activeColor: Get.theme.primaryColor,
                                                            checkColor: Colors.white,
                                                            value: juzquranCtrl_.isCheckedMalayalam.value,
                                                            onChanged: (value) {
                                                              juzquranCtrl_.isCheckedMalayalam(value!);
                                                              Future.delayed(Duration(milliseconds: 500), () {
                                                                juzquranCtrl_.getquranjuzdetail();
                                                              });
                                                              juzquranCtrl_.update();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }) : featuredLanguage== "Hindi (हिंदी)"? Obx(() {
                                                      return Container(
                                                        height: 30.h,
                                                        width: 30.w,
                                                        child: Transform.scale(
                                                          scale: 1,
                                                          child: Checkbox(
                                                            activeColor: Get.theme.primaryColor,
                                                            checkColor: Colors.white,
                                                            value: juzquranCtrl_.isCheckedHindi.value,
                                                            onChanged: (value) {
                                                              juzquranCtrl_.isCheckedHindi(value!);
                                                              Future.delayed(Duration(milliseconds: 500), () {
                                                                juzquranCtrl_.getquranjuzdetail();
                                                              });
                                                              juzquranCtrl_.update();
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }) : null,
                                                    trailing: GestureDetector(
                                                      onTap: () async {
                                                        // Delete the item from the list and update the downloaded items list
                                                        setState(() {
                                                          featuredLanguages.removeAt(index);
                                                          downloadedItems.remove(featuredLanguage);
                                                          checkedStates.removeAt(index);
                                                        });
                                                        await prefs.setStringList(downloadedItemsKey, downloadedItems);
                                                      },
                                                      child: Icon(Icons.delete),
                                                    ),
                                                    title: Text(featuredLanguage),
                                                  );
                                                },
                                              ),
                                              Space(16),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Stxt(text: "Featured Languages",
                                                      size: f4,
                                                      weight: FontWeight.w600,
                                                      color: Get.theme.hoverColor),
                                                ],
                                              ),
                                              ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: courseNames.length,
                                                itemBuilder: (context, index) {
                                                  final courseName = courseNames[index];
                                                  final isDownloaded = downloadedItems.contains(courseName);
                                                  print("lll${courseNames}");

                                                  // Check if the item is already downloaded
                                                  if (downloadedItems.contains(courseName)) {
                                                    return ListTile(
                                                      title: Text(courseName),
                                                      // Display a checkmark icon for downloaded items
                                                      trailing: isDownloaded
                                                          ? Icon(Icons.check)
                                                          : GestureDetector(
                                                        onTap: () async {
                                                          // Download the item and update the downloaded items list
                                                          setState(() {
                                                            downloadedItems.add(courseName);
                                                            featuredLanguages.add(courseName);
                                                          });
                                                          await prefs.setStringList(downloadedItemsKey, downloadedItems);
                                                        },
                                                        child: Icon(Icons.download), // Change to your download icon
                                                      ),
                                                    );
                                                  } else {
                                                    // Display a download item for items not downloaded
                                                    return CourseListItem(
                                                      courseName: courseName,
                                                      onDownloadComplete: (String downloadedCourseName) async {
                                                        setState(() {
                                                          // Update the downloadedItems list
                                                          downloadedItems.add(downloadedCourseName);
                                                          // Move the item to the featuredLanguages list
                                                          featuredLanguages.add(downloadedCourseName);
                                                        });
                                                        await prefs.setStringList(downloadedItemsKey, downloadedItems);
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
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
                        );
                      },
                      child: Center(
                        child: Stxt(
                          text: "+ Add Language", size: f2, weight: FontWeight
                            .w600, color: Get.theme.hoverColor,),
                      ),
                    ),
                    Space(8),
                    Text(
                      "arabic_font".tr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.hoverColor),
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                                juzquranCtrl_.changeFontFamily(groupValue!),
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                                juzquranCtrl_.changeFontFamily(groupValue!),
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                            juzquranCtrl_.fontFamily.value = groupValue!,
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                                juzquranCtrl_.changeFontFamily(groupValue!),
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                                juzquranCtrl_.changeFontFamily(groupValue!),
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                            juzquranCtrl_.fontFamily.value = groupValue!,
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
                                            groupValue: juzquranCtrl_.fontFamily.value,
                                            onChanged: (groupValue) =>
                                            juzquranCtrl_.fontFamily.value =
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
                          onChanged: juzquranCtrl_.setSliderValue,
                          // Call the setSliderValue method from the controller
                          value: juzquranCtrl_.sliderValue.value,
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
                          onChanged: juzquranCtrl_.setSliderValue1,
                          // Call the setSliderValue method from the controller
                          value: juzquranCtrl_.sliderValue1.value,
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
          backgroundColor: Get.theme.colorScheme.background,
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
                        juzquranCtrl_.openEndDrawer();
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
            controller: juzquranCtrl_.pageControllerjuz,
            onPageChanged: (page) {
              // print("yyyy${juzquranCtrl_.qurandetsilIndex1.value + 1}");
               print("yyyy${juzquranCtrl_.getquranjuz.value.getQuranJuzChapter!.length}");
               juzquranCtrl_.quranjuzdetailList(juzquranCtrl_.qurandetsilIndex1.value + (page+ 1));
            },
            itemCount: juzquranCtrl_.getquranjuz.value.getQuranJuzChapter!.length,
            itemBuilder: (context, pageIndex) {
               print("plpl${pageIndex}");
              return Obx(() {
                return (juzquranCtrl_.isLoadingsJuz.value)? DialogHelper.showLoading():Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 80.h,
                                width: 330.w,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/quranheader.png",
                                        ),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 40.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Obx(() {
                                            final ctrl = juzquranCtrl_.getquranjuzdetail.value
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
                                            weight: FontWeight.w500,),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 40.sp),
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
                                              final ctrl = juzquranCtrl_.getquranjuzdetail.value
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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15.h,
                              left: .23.sw,
                              child: Container(
                                height: 50.sp,
                                width: 180.sp,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/quranvector.png",
                                        ),
                                        fit: BoxFit.fill)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        GotoVerse(context);
                                      },
                                      child: Obx(() {
                                        final ctrl = juzquranCtrl_.getquranjuzdetail.value
                                            .getQuranJuzVersesList![0];
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "${ctrl.juzChapterNo}. ",
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
                                      final ctrl = juzquranCtrl_.getquranjuzdetail.value
                                          .getQuranJuzVersesList![0];
                                      return Stxt(
                                        text: "${ctrl.juzNameArb}", size: f1,
                                        color: Theme
                                            .of(context)
                                            .primaryColor,);
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                      Space(16),
                      Flexible(
                        flex: 1,
                          child: juzquranCtrl_.isLoadingsJuz.value
                                ?  DialogHelper.showLoading()
                                : Scrollbar(
                              interactive: true,
                              thumbVisibility: false,
                              thickness: 10,
                              //controller: juzquranCtrl_.scrollControllera,
                              controller: juzquranCtrl_.controllerff,
                              radius: Radius.circular(20),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      controller: juzquranCtrl_.controllerff,
                                  itemCount: juzquranCtrl_.getquranjuzdetail.value
                                      .getQuranJuzVersesList![0].ayahList!.length,
                                  itemBuilder: (context, index) {
                                    var juz = juzquranCtrl_.getquranjuzdetail.value
                                        .getQuranJuzVersesList![0]
                                        .ayahList![index];
                                    return  AutoScrollTag(
                                      key: ValueKey(index),
                                      controller: quranPageCtrl_.controllerff,
                                      index: index,
                                      child: Container(
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
                                                        ...juzquranCtrl_.pages.map((e) =>
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
                                                          color: Get.theme.hoverColor,
                                                        ),
                                                        Space(12),
                                                        GestureDetector(

                                                          onTap: () {

                                                            final bookmarkdata = {
                                                              "name": "${juzquranCtrl_.getquranjuzdetail.value.getQuranJuzVersesList![0].juzNameEn} ${juz.versesKey}",
                                                              "type": 'juz',
                                                              "index": index,
                                                              "no": juzquranCtrl_.getquranjuzdetail.value.getQuranJuzVersesList![0].juzChapterNo!,
                                                            };
                                                            juzquranCtrl_.toogle(bookmarkdata);
                                                            juzquranCtrl_.update();
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
                                                        final  isBookmarked =   juzquranCtrl_.buttonsSelected
                                                                .any((item) => item['name'] == "${juzquranCtrl_.getquranjuzdetail.value.getQuranJuzVersesList![0].juzNameEn} ${juz.versesKey}");

                                                            // final isBookmarked = c.isBookmarked.value;
                                                            return Icon(

                                                              isBookmarked ? Icons.bookmark
                                                                  : Icons
                                                                  .bookmark_outline,
                                                              color: isBookmarked? Get.theme.hoverColor
                                                                  : Get.theme.hoverColor, // Use different colors for bookmarked and not bookmarked states
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
                                                              color: Get.theme.hoverColor,
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
                                                              String fontFamily = juzquranCtrl_
                                                                  .fontFamily
                                                                  .value;
                                                              double sliderValue = juzquranCtrl_
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
                                                                fontFamily: juzquranCtrl_.fontFamily.value == "indopak" ? "Indopak"
                                                                    : juzquranCtrl_.fontFamily
                                                                    .value ==
                                                                    "qalam"
                                                                    ? "Qalam" : juzquranCtrl_
                                                                    .fontFamily
                                                                    .value ==
                                                                    "uthami"
                                                                    ? "Uthami" : juzquranCtrl_
                                                                    .fontFamily
                                                                    .value ==
                                                                    "amiri"
                                                                    ? "Amiri" : juzquranCtrl_
                                                                    .fontFamily
                                                                    .value ==
                                                                    "noorehira"
                                                                    ? "Noorehira"
                                                                    : juzquranCtrl_
                                                                    .fontFamily
                                                                    .value ==
                                                                    "noorehuda"
                                                                    ? "Noorehuda"
                                                                    : juzquranCtrl_
                                                                    .fontFamily
                                                                    .value ==
                                                                    "noorehidayat"
                                                                    ? "Noorehidayat"
                                                                    : juzquranCtrl_
                                                                    .fontFamily
                                                                    .value ==
                                                                    "arabictit"
                                                                    ? "Arabictitle"
                                                                    : null, // Use the default font if "Amiri" is not selected
                                                              );
                                                              return SizedBox(
                                                                width: juzquranCtrl_
                                                                    .screenWidth *
                                                                    0.65,
                                                                child: juzquranCtrl_
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
                                                              );
                                                            })
                                                        ),
                                                      ],
                                                    ),
                                                    Space(8),
                                                    Space(16),
                                                    Obx(() {
                                                      double fontSize = 18.0;
                                                      double sliderValue = juzquranCtrl_
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
                                                              juzquranCtrl_.isCheckedEnglish
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
                                                      double sliderValue = juzquranCtrl_
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
                                                              child: juzquranCtrl_
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
                                                    Obx(() {
                                                      double fontSize = 18.0;
                                                      double sliderValue = juzquranCtrl_
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
                                                              child: juzquranCtrl_
                                                                  .isCheckedUrdu
                                                                  .value
                                                                  ? Text(
                                                                "${juz.urduTranslation}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    fontSize: fontSize),
                                                              )
                                                                  : SizedBox
                                                                  .shrink()));
                                                    }),  Obx(() {
                                                      double fontSize = 18.0;
                                                      double sliderValue = juzquranCtrl_
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
                                                              child: juzquranCtrl_
                                                                  .isCheckedHindi
                                                                  .value
                                                                  ? Text(
                                                                "${juz
                                                                    .hindiTranslation}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    fontSize: fontSize),
                                                              )
                                                                  : SizedBox
                                                                  .shrink()));
                                                    }),  Obx(() {
                                                      double fontSize = 18.0;
                                                      double sliderValue = juzquranCtrl_
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
                                                              child: juzquranCtrl_
                                                                  .isCheckedMalayalam
                                                                  .value
                                                                  ? Text(
                                                                "${juz
                                                                    .malayalamTranslation}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    fontSize: fontSize),
                                                              )
                                                                  : SizedBox
                                                                  .shrink()));
                                                    }),  Obx(() {
                                                      double fontSize = 18.0;
                                                      double sliderValue = juzquranCtrl_
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
                                                              child: juzquranCtrl_
                                                                  .isCheckedTelugu
                                                                  .value
                                                                  ? Text(
                                                                "${juz
                                                                    .teluguTranslation}",
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
                                                       color: Get.theme.hoverColor
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    );
                                  }
                            ),
                                ),
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
