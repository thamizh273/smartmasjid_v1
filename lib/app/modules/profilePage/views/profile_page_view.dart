import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/controllers/edit_profile_controller.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/views/edit_profile_view.dart';

import '../../../routes/export.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<EditProfileController> {
  ProfilePageView({Key? key}) : super(key: key);

  static HomeController get homeController => Get.find();

  List<Map<String, dynamic>> profile = [
    {
      'name': "Edit Profile",
      'icon': Icon(Icons.person),
      "page": EditProfileView()
    },
    {'name': "Bookmarks", 'icon': Icon(Icons.bookmarks_outlined)},
    {
      'name': "My Masjid",
      'icon': SvgPicture.asset(
        'assets/icons/masjid_icon.svg', color: Get.theme.primaryColor,)
    },
    {'name': "Activities", 'icon': Icon(Icons.history)},
    {'name': "Family Tree", 'icon': Icon(Icons.family_restroom_outlined)}
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
            text: "Profile",
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
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Profile Photo", style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),),
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
                                                    "assets/images/camera.png"),
                                                Text("Camera",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontSize: 20,
                                                      color: Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .secondary),)
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
                                                    "assets/images/gallery.png"),
                                                Text("Gallery",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      fontSize: 20,
                                                      color: Theme
                                                          .of(context)
                                                          .colorScheme
                                                          .secondary),)
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
                        child: Icon(Icons.edit,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      alignment: Alignment.bottomRight,
                      smallSize: 25,
                      largeSize: 25,
                      child: homectrl.profileImage == "null" ? CircleAvatar(
                        // foregroundImage:
                        // AssetImage('assets/images/avathar.png',),
                        foregroundImage: AssetImage(
                          'assets/images/avathar.png',),

                        radius: 50,
                        backgroundColor: Colors.white,
                      ) : Obx(() {
                        return controller.isLoadingPic.value
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                          // foregroundImage:
                          // AssetImage('assets/images/avathar.png',),
                          foregroundImage: MemoryImage(base64Decode(homectrl
                              .profileImage.toString())),
                          radius: 50,
                          backgroundColor: Colors.white,
                        );
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    children: [ Text("${homectrl
                        .firstName}${homectrl
                          .lastName}", style: TextStyle(
                          color: Colors.white),),



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
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => i['page']
                    ));
                    print("click ${i['page']}");
                  },
                  splashColor: Colors.grey.shade300,
                  // shape: Border(bottom: BorderSide(color: Colors.grey)),
                  iconColor: Theme
                      .of(context)
                      .primaryColor,
                  leading: IconButton(onPressed: () {},
                    icon: i['icon'],
                    color: Get.theme.primaryColor,),
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
            onTap: () async {
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()),(_)=>false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login_outlined, color: Get.theme.primaryColor,),
                SizedBox(
                  width: 5,
                ),
                Stxt(
                  text: 'Logout',
                  size: f3,
                  weight: FontWeight.bold,
                  color: Get.theme.primaryColor,
                ),
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