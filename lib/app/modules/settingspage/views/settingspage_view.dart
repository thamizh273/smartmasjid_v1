
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../../language_page/controllers/language_page_controller.dart';
import '../controllers/settingspage_controller.dart';
import 'languageList.dart';

class SettingspageView extends StatefulWidget {
  const SettingspageView();

  @override
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingspageView> {
  final con = Get.put(LanguagePageController());
  final controller = Get.put(SettingspageController());
  final GlobalKey key = GlobalKey();

  void showContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Contact Us', style: TextStyle(color: Get.theme.primaryColor),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('If you have any questions or feedback, please email us at', style: TextStyle(color: Colors.black),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('support@smasjid.com.', style: TextStyle(color: Get.theme.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close', style: TextStyle(fontWeight: FontWeight.w600),),
            ),
          ],
        );
      },
    );
  }
  void showVersionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Version', style: TextStyle(color: Get.theme.primaryColor),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Version Number : ', style: TextStyle(color: Colors.black),),
                  Text('V2.0.0', style: TextStyle(color: Get.theme.primaryColor, fontSize: 18, fontWeight: FontWeight.w600),),
                ],
              ),
              Space(8),
              Row(
                children: [
                 Text("𝘓𝘢𝘴𝘵 𝘜𝘱𝘥𝘢𝘵𝘦𝘥 𝘰𝘯 :", style: TextStyle(fontSize: 14,color: Colors.black ),),
                 Text("12 Oct 2023",style: TextStyle(fontSize: 14, color: Colors.black),),
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close', style: TextStyle(fontWeight: FontWeight.w600),),
            ),
          ],
        );
      },
    );
  }


  void showRatingDialog() {
    final _inAppReview = InAppReview.instance;

    // Function to open the Android store listing with your app's package name.
    _rateAndReviewApp() {
      final androidPackage = 'com.safa.ummati'; // Replace with your app's Android package name

      if (Platform.isAndroid) {
        final playStoreUrl = 'https://play.google.com/store/apps/details?id=$androidPackage';
        launch(playStoreUrl);
      } else if (Platform.isIOS) {
        // Handle iOS store listing (if needed)
      }
    }

    final _dialog = RatingDialog(
      starColor: Theme
          .of(context)
          .primaryColor,
      initialRating: 1.0,
      title: const Text(
        'Ummati',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: const Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // Set a different image for Android.
      image: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/slogonew.png",),
        ],
      ),
      submitButtonText: 'Submit',
      commentHint: 'Write a Feedback',
      onCancelled: () {
        print('Cancelled on Android');
        // Add your Android-specific logic here, if needed.
      },
      onSubmitted: (response) {
        print('Rating: ${response.rating}, Comment: ${response.comment}');

        // Your logic here.
        if (response.rating < 3.0) {
          // Handle low ratings differently, if needed.
          controller.sendEmail('mbbasha@smasjid.com', 'User Feedback', response.comment);
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // Show the dialog.
    showDialog(
      context: context,
      barrierDismissible: true, // Set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar(tittle: 'settings'.tr,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {

                return controller.load.value==true?Center(child: CupertinoActivityIndicator()):Column(
                  children: [
                    Row(
                      children: [

                        SvgPicture.asset("assets/svg/thememode.svg", color: Get.theme.hoverColor,),
                        Space(16),
                        Text("dark_Mode".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),),
                        Spacer(),
                        Switch(
                          value: controller.switchValue.value,
                          onChanged: (newValue) async {
                            controller.switchValue.value = newValue;
                            ThemeService().changeTheme();
                            controller.load.value=true;
                            controller.update();
                            Future.delayed(Duration(milliseconds: 200),() async{

                          controller.load.value=false;
                          controller.update();

                            });
                            controller.update();




                          },
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Space(16),
                    GestureDetector(
                      onTap: () {
                        Get.to(LanguageList());
                      },
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svg/language.svg",
                              color: Get.theme.hoverColor,),
                            Space(16),
                            Text("language".tr,
                              style: const TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.w500),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    // const Divider(
                    //   thickness: 1,
                    // ),
                    // Space(16),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       "assets/svg/feedback.svg", color: Get.theme.hoverColor,),
                    //     Space(16),
                    //     Text("feedback".tr,
                    //       style: const TextStyle(
                    //           fontSize: 18, fontWeight: FontWeight.w500),),
                    //     Spacer(),
                    //     Icon(Icons.arrow_forward_ios),
                    //   ],
                    // ),
                    const Divider(
                      thickness: 1,
                    ),
                    Space(16),
                    InkWell(
                      onTap: (){
                        showContactDialog();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/contact.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("contact".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Space(16),
                    InkWell(
                      onTap: () {
                        showRatingDialog();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/rating.svg", color: Get.theme.hoverColor,),
                          const Space(16),
                          Text("rate_our_app".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Space(16),
                    InkWell(
                      onTap: (){
                        showVersionDialog();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/versionew.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("version".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Space(16),
                    InkWell(
                      onTap: (){
                        controller.shareApp();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/share.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("share".tr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stxt(text: "Powered by ", size: f1),
                Stxt(text: "Smart Masjid", size: f1, color: Get.theme.primaryColor, weight: FontWeight.w500,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

