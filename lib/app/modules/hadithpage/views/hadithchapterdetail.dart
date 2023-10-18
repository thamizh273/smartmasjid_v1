import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/controllers/hadithpage_controller.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../widgets/space.dart';


class Hadithchapterdetail extends GetView<HadithpageController> {
  Hadithchapterdetail({Key? key}) : super(key: key);
  final HadithpageController detail_cntrl = Get.put(HadithpageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(
          tittle: "Hadith",
          action: [
            Image.asset("assets/images/notes.png", width: 20,),
            Space(16)
          ],
        ),
        body:  detail_cntrl.isLoadings5.value? DialogHelper.showLoading():Padding(
          padding: const EdgeInsets.all(16),
          child: Scrollbar(
            controller: detail_cntrl.scrollControllerd,
            interactive: true,
            radius: Radius.circular(20),
            thickness: 10,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: detail_cntrl.scrollControllerd,
              children: [
                Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Color(0xff16627C)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("${detail_cntrl.gethadithdetail.value.getHadithsVerseByCollection!.collectionNameEn}", style: TextStyle(fontSize: 18, color: Get.theme.primaryColor),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Chapter: ${detail_cntrl.gethadithdetail.value.getHadithsVerseByCollection!.chapterNo}", style: TextStyle(color: Get.theme.primaryColor),),
                              Space(4),
                              SizedBox(
                                width: 120.w,
                                  child: Text("(${detail_cntrl.gethadithdetail.value.getHadithsVerseByCollection!.hadithsChapterNameEn})", style: TextStyle(color: Get.theme.primaryColor),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Space(16),
                  Text(
                      "${detail_cntrl.gethadithdetail.value.getHadithsVerseByCollection!.hadisVersList![0].titleNameEn}"),
                  Space(16),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: detail_cntrl.gethadithdetail.value.getHadithsVerseByCollection!.hadisVersList!.length,
                      itemBuilder: (context, index) {
                        var detail = detail_cntrl.gethadithdetail.value.getHadithsVerseByCollection!.hadisVersList![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      color: Get.theme.shadowColor,
                                      blurRadius: 4,
                                      spreadRadius: 2
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("${detail.hadithsNo}", style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15, color: Get.theme.primaryColor),),
                                      Spacer(),
                                      PopupMenuButton(
                                          shadowColor: Get.theme.shadowColor,
                                          itemBuilder: (BuildContext context) {
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
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/notes.png",
                                                          width: 20,
                                                          color: Colors.black,),
                                                        Space(12),
                                                        Text("Create Notes"),
                                                      ],
                                                    ),
                                                  )),
                                            ];
                                          }
                                      )
                                    ],
                                  ),
                                  Text(
                                    "${detail.arabicHadiths}",
                                    style: TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.w400, color: Get.theme.primaryColor),),
                                  Space(8),
                                  Text("${detail.narrated}:",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 18),),
                                  Space(8),
                                  Text(
                                      "${detail.englishHadiths}", style: TextStyle(color: Get.theme.primaryColor, fontSize: 16),),
                                  Space(8),
                                  Text("${detail.collectionNameEn}, ${detail.chapterNo}", style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),)
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  )
                ],
              ),
              ]
            ),
          ),
        ),
      );
    });
  }
}

class CustomDialogBox extends StatelessWidget {
  final TextEditingController pass = TextEditingController();
  final TextEditingController c = TextEditingController();
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