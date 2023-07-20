import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/widgets/bgcontainer_auth.dart';

import '../../../../global.dart';
import '../../../../widgets/button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/face_auth_controller.dart';

class FaceAuthView extends GetView<FaceAuthController> {
  const FaceAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaceAuthController>(builder: (c) {
      return Scaffold(
        // backgroundColor: Get.theme.primaryColor,
          body: BGContainerAuth(
            color: Get.theme.primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 35.h),
                  child: IconButton(
                    onPressed: () {
                      c.backss.value =false;
                      print(c.image.value.path.isNotEmpty);
                      controller.update();
                    },
                    icon: Image.asset('assets/images/back_icon.png'),
                    iconSize: 38.w,),
                ),
                Center(
                  child: SizedBox(
                      height: context.mediaQuerySize.height * .7,
                      width: context.mediaQueryShortestSide * .9,
                      child:

                      Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Get.theme.colorScheme.primary,
                        child:
                             Obx(() {
                          return  c.backss.value == true?Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                              CircleAvatar(
                                backgroundColor: Get.theme.primaryColor,
                                radius: 82,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: controller.isPicked.value
                                      ? FileImage(
                                      File(controller.image.value.path))
                                      : null,

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(30.h),
                                child: Text(
                                  "Adjust to crop your Image",
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SButton(
                                      text: "Submit",
                                      txtClr: Get.theme.colorScheme.primary,
                                      height: 35.h,
                                      rad: 25,
                                      width: 150.w,
                                      ontap: () {
                                        Get.toNamed(Routes.SIGNUP_PAGE);
                                      }),
                                ],
                              ),
                            ],
                          ): Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/profilenew.png",
                                      scale: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "A Photo of you",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Please make sure your Photo \n clearly shows your face",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pickImage(isCamera: true);
                                  //  checkCameraPermission();
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 250,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          // blurRadius: 5,
                                          // offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Take a Photo",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .primary,
                                            decorationColor: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                            decorationThickness: 2,
                                            decorationStyle:
                                            TextDecorationStyle.solid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.pickImage(isCamera: false);
                                  //  checkGalleryPermission();
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 250,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                      borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Upload a photo",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .secondary,
                                            decorationColor: Colors.white,
                                            decorationThickness: 2,
                                            decorationStyle:
                                            TextDecorationStyle.solid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          );
                        })

                      ),

                  ),
                ),
                // 70.verticalSpace,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: SButton(
                      txtsize: f2,
                      text: "Skip",
                      txtClr: Get.theme.colorScheme.primary,
                      height: 20.h,
                      rad: 25,
                      width: 80.w,
                      pad: 2,
                      ontap: () {
                        Get.toNamed(Routes.SIGNUP_PAGE);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
