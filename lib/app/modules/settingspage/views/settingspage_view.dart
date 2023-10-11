import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/language_page/views/language_page_view.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/space.dart';
import '../../guestmode/controllers/guestmode_controller.dart';
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


  void showRatingDialog() {
    // actual store listing review & rating
    void _rateAndReviewApp() async {
      // refer to: https://pub.dev/packages/in_app_review
      final _inAppReview = InAppReview.instance;

      if (await _inAppReview.isAvailable()) {
        print('request actual review from store');
        _inAppReview.requestReview();
      } else {
        print('open actual store listing');
        // TODO: use your own store ids
        _inAppReview.openStoreListing(
          appStoreId: '<your app store id>',
          microsoftStoreId: '<your microsoft store id>',
        );
      }
    }

    final _dialog = RatingDialog(
      starColor: Theme
          .of(context)
          .primaryColor,
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Ummati',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.asset("assets/images/slogonw.png", fit: BoxFit.scaleDown,),
      submitButtonText: 'Submit',
      commentHint: 'Comment our app',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar(tittle: 'settings'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {

          return controller.load.value==true?Center(child: CupertinoActivityIndicator()):Column(
            children: [
              Row(
                children: [

                  SvgPicture.asset("assets/svg/thememode.svg", color: Get.theme.hoverColor,),
                  Space(16),
                  Text("dark_Mode".tr,
                    style: TextStyle(
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
              Divider(
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
                        style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w500),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Space(16),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/feedback.svg", color: Get.theme.hoverColor,),
                  Space(16),
                  Text("feedback".tr,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Space(16),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/contact.svg", color: Get.theme.hoverColor,),
                  Space(16),
                  Text("contact".tr,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              Divider(
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Space(16),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/versionew.svg", color: Get.theme.hoverColor,),
                  Space(16),
                  Text("version".tr,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Space(16),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/share.svg", color: Get.theme.hoverColor,),
                  Space(16),
                  Text("share".tr,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              Divider(
                thickness: 1,
              ),
            ],
          );
        }),
      ),
    );
  }
}

