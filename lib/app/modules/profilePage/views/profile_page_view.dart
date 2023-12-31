import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartmasjid_v1/app/modules/activitiespage/views/activitiespage_view.dart';
import 'package:smartmasjid_v1/app/modules/bookmarkpage/views/bookmarkpage_view.dart';
import 'package:smartmasjid_v1/app/modules/familytree/views/familytree_view.dart';
import 'package:smartmasjid_v1/app/modules/mymasjidpage/views/mymasjidpage_view.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/controllers/edit_profile_controller.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/views/edit_profile_view.dart';

import '../../../../utils/localization/localization.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../home/controllers/home_controller.dart';
import '../../language_page/controllers/language_page_controller.dart';
import '../../quranpage/views/bookmark.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<EditProfileController> {
  ProfilePageView({Key? key}) : super(key: key);

  static HomeController get homeController => Get.find();
  final lanctrl = Get.put(LanguagePageController());
  final List<Map<String, dynamic>> profile = [
    {
      'name': "edit_profile".tr,
      'icon': Icon(Icons.person),
      "page": EditProfileView()
    },
    {'name': "bookmarks".tr, 'icon': Icon(Icons.bookmarks_outlined),
      "page": Bookmark()
    },
    {
      'name': "my_masjid".tr,
      'icon': SvgPicture.asset(
        'assets/icons/masjid_icon.svg', color: Get.theme.hoverColor,),
      "page": MymasjidpageView()
    },
    {'name': "activities".tr, 'icon': Icon(Icons.history),
      "page": "Trans"
    },
    {'name': "family_tree".tr, 'icon': Icon(Icons.family_restroom_outlined),
      "page": FamilytreeView()}
  ];

  @override
  Widget build(BuildContext context) {
    var homectrl = homeController.getUserData.value.getUserById!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0.0),
          ),
        ),
        backgroundColor: Get.theme.primaryColor,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/back_icon.png',
            scale: 2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Stxt(
            text: "profile".tr,
            size: f4,
            weight: FontWeight.bold,
            color: Colors.white),

        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: SvgPicture.asset('assets/icons/mobile_vibration.svg',
        //
        //         color: Colors.white,
        //       )),
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.alarm,
        //         color: Colors.white,
        //       ))
        // ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              color: Get.theme.primaryColor,
            ),
            child: Column(
              children: [
                Hero(
                  transitionOnUserGestures: true,
                  tag: 'avatarTag',
                  child: CircleAvatar(
                    radius: 51,
                    backgroundColor: Colors.white,
                    child: Badge(
                      offset: Offset(-3, -2),
// padding: EdgeInsets.symmetric(vertical: ),
                      label: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Profile Photo", style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600, color: Get.theme.primaryColor),),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.pickImage(
                                                  isCamera: true);
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/camera.png", color: Get.theme.primaryColor,),
                                                Text("Camera",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontSize: 20,
                                                      color: Get.theme.primaryColor),)
                                              ],
                                            ),
                                          ),
                                          Space(50),
                                          GestureDetector(
                                            onTap: () {
                                              controller.pickImage(
                                                  isCamera: false);
                                              Navigator.pop(context);
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/gallery.png",color: Get.theme.primaryColor),
                                                Text("Gallery",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontSize: 20,
                                                      color: Get.theme.primaryColor),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          radius: 10,
                            foregroundColor: Get.theme.primaryColor,
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.edit, size: 20,)),
                      ),
                      backgroundColor: Colors.white,
                      alignment: Alignment.bottomRight,
                      smallSize: 25,
                      largeSize: 25,
                      child:homectrl.profileImage == "null"
                          ? Scaffold(
                        body: GestureDetector(
                          onTap: () {
                            // Handle the tap gesture to view the image in full screen
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const Scaffold(
                                  backgroundColor: Colors.black,
                                  body: Center(
                                    child: CircleAvatar(
                                      foregroundImage: AssetImage(
                                        'assets/images/avathar.png',),
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ));
                          },
                          child: const CircleAvatar(
                            foregroundImage: AssetImage('assets/images/avathar.png'),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                          : Obx(() {
                        return controller.isLoadingPic.value
                            ? CircularProgressIndicator()
                            : GestureDetector(
                              onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  backgroundColor: Colors.black,
                                  body: Center(
                                    child: Image(
                                      width: double.infinity,
                                      image: MemoryImage(base64Decode(homectrl.profileImage.toString())),
                                      fit: BoxFit.fill, // Set the width to occupy the entire screen width
                                    ),
                                  ),
                                );
                              },
                            ));
                          },
                              child: CircleAvatar(
                                foregroundImage: MemoryImage(base64Decode(homectrl
                                    .profileImage.toString())),
                                radius: 50,
                                backgroundColor: Colors.white,
                              ),
                            );
                      }),

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    children: [ Obx(() {
                      return Text("${controller.name.value}", style: TextStyle(
                          color: Colors.white),);
                    }),


                      Text("${homectrl.emailId}",
                        style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  // child: Stxt(
                  //   text: 'Abdullah',
                  //   size: f4,
                  //   weight: FontWeight.bold,
                  //   color: Colors.white,
                  // ),
                ),
                Stxt(
                  text: 'Member ID: ${homectrl.userUniqueId}',
                  size: f2,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),


          for (var i in profile)
            Column(
              children: [
                ListTile(
                  onTap: () {
                    i['page'] == "Trans"
                        ? Get.toNamed(Routes.ACTIVITIESPAGE)
                        : Get.to(i['page']);


                    print("click ${i['page']}");
                  },
                  splashColor: Colors.grey.shade300,
                  // shape: Border(bottom: BorderSide(color: Colors.grey)),
                  iconColor: Theme
                      .of(context)
                      .primaryColor,
                  leading: IconButton(onPressed: () {},
                    icon: i['icon'],
                    color: Get.theme.hoverColor,),
                  title: Stxt(
                    text: '${i['name']}',
                    size: f3,
                    weight: FontWeight.bold,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Get.theme.hoverColor,
                      )),
                ),
                Divider(
                  height: 1,
                  endIndent: 25,
                  indent: 20,
                )
              ],
            ),
          Spacer(),
          GestureDetector(
            onTap: () {
              controller.logout();

              // lanctrl.langStore.remove('languageCode');
              // lanctrl.langStore.remove('countryCode');
              // lanctrl.updateLanguage('en_US');
              //  lanctrl.selectedLang.value = "ENGLISH";
              //  Localization().clearPreferredLocale();
              // Get.updateLocale(Locale('en', 'US'));
              // Get.dialog(
              //    // barrierColor:Get.theme.primaryColor.withOpacity(.8),
              //
              //
              //     Padding(
              //         padding: EdgeInsets.symmetric(vertical: 20.h),
              //         child: AlertDialog(
              //           elevation: 10,
              //           backgroundColor: Get.theme.colorScheme
              //               .primary,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(
              //                   10)),
              //           // title: Center(
              //           //     child: Stxt(
              //           //   text: "Are you Sure?",
              //           //   size: f3,
              //           //   weight: FontWeight.bold,
              //           //   color: Colors.white,
              //           //   textAlign: TextAlign.center,
              //           // )),
              //
              //           // contentPadding: EdgeInsets.symmetric(vertical: 20.h,),
              //           content: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment
              //                 .center,
              //             children: [
              //               Stxt(
              //                 text:
              //                 "Logout",
              //                 size: f3,
              //                 // weight: FontWeight.bold,
              //                 color: Colors.white,
              //                 textAlign: TextAlign.center,
              //               ),
              //               SizedBox(height: 8,),
              //               Stxt(text: "Confirm to Logout ?",
              //                 size: f3,
              //                 weight: FontWeight.bold,
              //                 color: Colors.white,)
              //             ],
              //           ),
              //           actionsPadding: EdgeInsets.only(bottom: 20),
              //           actions: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment
              //                   .spaceEvenly,
              //               children: [
              //                 SButton(
              //                     width: 90.w,
              //                     height: 25.h,
              //                     color: Get.theme.colorScheme
              //                         .secondary,
              //                     ontap: () {
              //                       Get.back();
              //                     },
              //                     text: "cancel".tr,
              //                     txtsize: f1,
              //                     txtClr:
              //                     Get.theme.colorScheme.primary),
              //                 SButton(
              //                     height: 25.h,
              //                     width: 90.w,
              //                     ontap: () async {
              //                       controller.logout();
              //                       controller.update();
              //                     },
              //                     text: "confirm".tr,
              //                     txtsize: f1,
              //                     txtClr:
              //                     Get.theme.colorScheme.primary),
              //               ],
              //             )
              //           ],
              //           //iconPadding: EdgeInsets.all(20),
              //         )));


              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()),(_)=>false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login_outlined, color: Get.theme.hoverColor,),
                SizedBox(
                  width: 5,
                ),
                Obx(() {
                  return Stxt(
                    text: controller.isLoadingLogout.value
                        ? 'logout'.tr
                        : 'logout'.tr,
                    size: f3,
                    weight: FontWeight.bold,
                    color: Get.theme.hoverColor,
                  );
                }),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
