import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smartmasjid_v1/app/modules/audioplayer/views/audioplayer_view.dart';
import 'package:smartmasjid_v1/app/modules/duapage/views/duapage_view.dart';
import 'package:smartmasjid_v1/app/modules/guestmode/views/prayer_page.dart';
import 'package:smartmasjid_v1/app/modules/guestmode/widgets/prayertime.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/views/hadithpage_view.dart';
import 'package:smartmasjid_v1/app/modules/hijripage/views/hijripage_view.dart';
import 'package:smartmasjid_v1/app/modules/home/Drawer_List/masjid_admins.dart';
import 'package:smartmasjid_v1/app/modules/home/Drawer_List/masjid_facility.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/events.dart';
import 'package:smartmasjid_v1/app/modules/librarypage/views/librarypage_view.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/Model/GetUserIDModel.dart';
import 'package:smartmasjid_v1/app/modules/masjidhistory/views/masjidhistory_view.dart';
import 'package:smartmasjid_v1/app/modules/mediapage/views/mediapage_view.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/views/prayerpage_view.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import 'package:smartmasjid_v1/app/modules/register_login/views/register_login_view.dart';
import 'package:smartmasjid_v1/app/modules/servicepage/views/servicepage_view.dart';
import 'package:smartmasjid_v1/app/modules/specialdayspage/views/specialdayspage_view.dart';
import 'package:smartmasjid_v1/app/modules/zakathpage/views/zakathpage_view.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../utils/ansomeNotification.dart';
import '../../../../utils/fcm_notification/fcm_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../home/widgets/mediumCard.dart';
import '../../masjidnearme/helper/custom_marker_info_window.dart';
import '../../settingspage/controllers/settingspage_controller.dart';
import '../../settingspage/views/languageList.dart';
import '../controllers/guestmode_controller.dart';


class GuestmodeView extends StatefulWidget {
  GuestmodeView({Key? key}) : super(key: key);

  @override
  State<GuestmodeView> createState() => _GuestmodeViewState();
}

class _GuestmodeViewState extends State<GuestmodeView> {
  final GuestmodeController controller = Get.find<GuestmodeController>();
  final  sctrl = Get.put(SettingspageController());

  CarouselController _carouselController = CarouselController();

  final List<String> items = ["Pondicherry", "villupuram"];

  // final List<String> imgList = ['fajr', 'dhuhar'];
  List quranImg = ['quran_list_img1', 'quran_list_img2', 'quran_list_img3'];

  List duaImg = ['dua_img1', 'dua_img2', 'dua_img3'];
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
      starColor: Theme.of(context).primaryColor,
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
    final themeData = Theme.of(context);
    return Obx(() {
      return controller.isloading.value
          ?  DialogHelper.showLoading()
          : Scaffold(
        backgroundColor: themeData.scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 10,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              //color: Color(0xffD8E4E8),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: 10, left: 10, bottom: 6),
            child: GestureDetector(
              onTap: () {
                controller.openDrawer();
                controller.update();
              },

              child: Image.asset("assets/images/slogonw.png",),
            ),
          ),
          title: Text(
            "Ummati",
            style: TextStyle(color: Get.theme.hoverColor),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                },
                child: Hero(
                  //  transitionOnUserGestures : true,
                  tag: 'avatarTag',
                  child: CircleAvatar(
                    radius: 21.5,
                    backgroundColor: themeData.primaryColor,
                    child: CircleAvatar(
                        foregroundImage:
                        AssetImage("assets/images/guestlogo.png",),
                        radius: 15,
                        backgroundColor: Colors.transparent,
                      ),
                ),
              ),
            )

//             ),
          )
          ],
          bottom: buildPreferredSize(context),
        ),
        key: controller.scaffoldKey,
        drawer: Drawer(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Get.theme.scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  height: 150.h,
                  child: DrawerHeader(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Get.theme.hoverColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(
                                "assets/svg/slogonew.svg",
                                height: 70.00,
                                width: 80.00,
                              ),
                            ),
                            SizedBox(width: 16),
                            SizedBox(
                              width: 0.45.sw,
                              child: Text(
                                "Ummati",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Get.theme.scaffoldBackgroundColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/thememode.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("dark_Mode".tr,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Switch(
                              value: sctrl.switchValue.value ,
                              onChanged: (newValue) {
                                sctrl.switchValue.value = newValue;


                                ThemeService().changeTheme();
                                sctrl.update();


                              },
                            ),

                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Space(16),
                      GestureDetector(
                        onTap: (){
                          Get.to(LanguageList());
                        },
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/svg/language.svg", color: Get.theme.hoverColor,),
                              Space(16),
                              Text("language".tr,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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
                          SvgPicture.asset("assets/svg/feedback.svg",color: Get.theme.hoverColor,),
                          Space(16),
                          Text("feedback".tr,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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
                          SvgPicture.asset("assets/svg/contact.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("contact".tr,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Space(16),
                      InkWell(
                        onTap: (){
                          showRatingDialog();
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svg/rating.svg", color: Get.theme.hoverColor,),
                            const Space(16),
                            Text("rate_our_app".tr,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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
                          SvgPicture.asset("assets/svg/versionew.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("version".tr,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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
                          SvgPicture.asset("assets/svg/share.svg", color: Get.theme.hoverColor,),
                          Space(16),
                          Text("share".tr,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
               Spacer(),
                InkWell(
                  onTap: (){
                    controller.guesttoken.remove("guest");
                    Get.offAllNamed(AppPages.INITIAL);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stxt(text: "Exit Guest".tr,
                          size: f3,
                          weight: FontWeight.w600,
                          color: Get.theme.hoverColor),
                      Space(16),
                      Icon(Icons.logout, color: Get.theme.hoverColor)
                    ],
                  ),
                ),
               Space(40)
              ],
            ),
          ),
        ),
        body: StreamBuilder<LocationData>(
          stream: Location.instance.onLocationChanged,
          builder: (context, snap) {
            // if(snap.data == null) return CupertinoActivityIndicator();
            return FrostedBottomBar(
                width: 330.w,
                opacity: .8,
                sigmaX: 10,
                sigmaY: 10,
                bottomBarColor: Get.theme.hoverColor,
                borderRadius: BorderRadius.circular(500),
                duration: const Duration(milliseconds: 800),
                hideOnScroll: true,
                body: (context, controllers) =>
                    TabBarView(
                        controller: controller.tabController,
                        dragStartBehavior: DragStartBehavior.down,
                        physics: BouncingScrollPhysics(),
                        children: [
                          SingleChildScrollView(
                            // controller: tabController,
                            //   padding: EdgeInsets.only(left: 10),
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Space(2),
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
                                                    Navigator.pop(context); // Closes the dialog box when the button is pressed.
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 48.h,
                                            width: 48.h,
                                            decoration: BoxDecoration(
                                                color: Get.theme.hoverColor,
                                                borderRadius: BorderRadius
                                                    .circular(50),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(0,2),
                                                  blurRadius: 4,
                                                  spreadRadius: 3,
                                                  color: Get.theme.highlightColor
                                                )
                                              ]
                                            ),
                                            child: Image.asset(
                                              "assets/images/notifydark.png",
                                              color: Get.theme.appBarTheme
                                                  .backgroundColor, scale: 3,),
                                          )
                                        // SvgPicture.asset(
                                        //     "assets/svg/notifynew.svg",
                                        //     height: 65.h),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.WEATHERPAGE);
                                          },
                                          child: Container(
                                            height: 48.h,
                                            width: 48.h,
                                            decoration: BoxDecoration(
                                                color: Get.theme.hoverColor,
                                                borderRadius: BorderRadius
                                                    .circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0,2),
                                                      blurRadius: 4,
                                                      spreadRadius: 3,
                                                      color: Get.theme.highlightColor
                                                  )
                                                ]
                                            ),
                                            child: Image.asset(
                                              "assets/images/weatherdark.png",
                                              color: Get.theme.appBarTheme
                                                  .backgroundColor, scale: 3,),
                                          )
                                        // SvgPicture.asset(
                                        //     "assets/svg/weathernew.svg",
                                        //     height: 65.h),
                                      ),
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
                                          child: Container(
                                            height: 48.h,
                                            width: 48.h,
                                            decoration: BoxDecoration(
                                                color: Get.theme.hoverColor,
                                                borderRadius: BorderRadius
                                                    .circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0,2),
                                                      blurRadius: 4,
                                                      spreadRadius: 3,
                                                      color: Get.theme.highlightColor
                                                  )
                                                ]
                                            ),
                                            child: Image.asset(
                                              "assets/images/messagedark.png",
                                              color: Get.theme.appBarTheme
                                                  .backgroundColor, scale: 3,),
                                          )

                                        // SvgPicture.asset(
                                        //     "assets/svg/messagenew.svg",color: Get.theme.hoverColor,
                                        //     height: 65.h),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.SETTINGSPAGE);
                                          },
                                          child: Container(
                                            height: 48.h,
                                            width: 48.h,
                                            decoration: BoxDecoration(
                                                color: Get.theme.hoverColor,
                                                borderRadius: BorderRadius
                                                    .circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(0,2),
                                                      blurRadius: 5,
                                                      spreadRadius: 4,
                                                      color: Get.theme.highlightColor
                                                  )
                                                ]
                                            ),
                                            child: Image.asset(
                                              "assets/images/settingsdark.png",
                                              color: Get.theme.appBarTheme
                                                  .backgroundColor, scale: 3,),
                                          )
                                        // SvgPicture.asset(
                                        //     "assets/svg/settingsnew.svg",
                                        //     height: 65.h),
                                      ),
                                      Space(2),
                                    ],
                                  ),
                                  Space(20),
                                  Space(8),
                                  Obx(() {
                                    return controller.isloading1.value
                                        ? CupertinoActivityIndicator()
                                        : PrayerTimes();
                                  }),
                                  Space(16),
                                  // Obx(() {
                                  //   return controller.isloadingEvent.value
                                  //       ? CupertinoActivityIndicator()
                                  //       : Events(
                                  //       carouselController:
                                  //       _carouselController);
                                  // }),
                                  MarqueeText(
                                    marqueeDirection: MarqueeDirection.ltr,
                                    alwaysScroll: true,
                                    text: TextSpan(
                                        text: 'Connect to Smart Masjid...📢',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 18,
                                            color: Get.theme.hoverColor
                                        )
                                    ),
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    speed: 20,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: Center(
                                      child: Obx(() {
                                        if (controller.showFirstImage.value) {
                                          return Image.asset('assets/images/guestad1new.png');
                                        } else if (controller.showSecondImage.value) {
                                          return Image.asset('assets/images/guestad2.png');
                                        } else {
                                          return Image.asset('assets/images/guestad3.png');
                                        }
                                      }),
                                    ),
                                  ),
                                  Space(16),
                                  // buildDivider(themeData),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.QURANPAGE);
                                    },
                                    child: LargerCard(
                                      ignorOntap: true,
                                      quranImg: quranImg,
                                      buttonTxt: 'continue'.tr,
                                      image: 'quran',
                                      title: 'quran'.tr,
                                      subtitle: '114_surah_30_juz'.tr,
                                     // lastseen: 'last_read_13_hrs_ago'.tr,
                                      // onPressed: getQuranChaptersList,
                                    ),
                                  ),
                                  buildDivider(themeData),
                                  Row(
                                    children: [
                                      SmallCard(
                                        image: 'hadith',
                                        title: 'hadith'.tr,
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      HadithpageView()));
                                        },
                                      ),
                                      SmallCard(
                                        image: 'library',
                                        title: 'library'.tr,
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LibrarypageView()));
                                        },
                                      ),
                                    ],
                                  ),
                                  buildDivider(themeData),
                                  Row(
                                    children: [
                                      MediumCard(
                                        color:
                                        themeData.colorScheme.secondary,
                                        title: 'masjid_near_me'.tr,
                                        image: 'masjidFinder',
                                        onTap: () {
                                          Get.to(CustomMarketInfoWindow());
                                        },
                                      ),
                                      Column(
                                        children: [
                                          SmallCard(
                                            color: themeData
                                                .colorScheme.secondary,
                                            image: 'qibla_finder',
                                            title: 'qibla_finder'.tr,
                                            onTap: () {
                                              Get.to(QiblaFinder());
                                            },
                                          ),
                                          SmallCard(
                                            color: themeData
                                                .colorScheme.secondary,
                                            image: 'prayer_time',
                                            title: 'prayer_time'.tr,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PrayerPage(),
                                                  ));
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  buildDivider(themeData),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => DuapageView()));
                                    },
                                    child: LargerCard(
                                      ignorOntap: true,
                                      quranImg: duaImg,
                                      buttonTxt: 'view_all'.tr,
                                      image: 'dua',
                                      title: 'dua'.tr,
                                      subtitle:
                                      'dua_for_ease_and_success_in_life'.tr,
                                      //lastseen: 'Opened 13 hrs ago',
                                    ),
                                  ),
                                  buildDivider(themeData),
                                  Row(
                                    children: [
                                      MediumCard(
                                        color:
                                        themeData.colorScheme.secondary,
                                        title: 'special_days'.tr,
                                        image: 'special_days',
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      SpecialdayspageView()));
                                        },
                                      ),
                                      Column(
                                        children: [
                                          SmallCard(
                                            color: themeData
                                                .colorScheme.secondary,
                                            image: 'hijri_calender',
                                            title: 'hijri_calender'.tr,
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          HijripageView()));
                                            },
                                          ),
                                          SmallCard(
                                            color: themeData
                                                .colorScheme.secondary,
                                            image: 'events',
                                            title: 'events'.tr,
                                            onTap: () {
                                              //Get.toNamed(Routes.EVENTS);
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
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  buildDivider(themeData),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => MediapageView()));
                                    },
                                    child: LargerCard(
                                      ignorOntap: true,
                                      quranImg: quranImg,
                                      buttonTxt: 'view_all'.tr,
                                      image: 'media',
                                      title: 'media'.tr,
                                      subtitle:
                                      'islamic_videos_for_ease_and_success_in_life'
                                          .tr,
                                      //lastseen: 'Opened 13 hrs ago',
                                    ),
                                  ),
                                  buildDivider(themeData),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //
                                  //     // Stxt(text: "Connect to Smart Masjid", size: f3, weight: FontWeight.bold, color: Get.theme.hoverColor,)
                                  //   ],
                                  // ).animate(
                                  //   onPlay: (controller) => controller.repeat(),
                                  // )
                                  //     .shimmer(
                                  //     duration: Duration(
                                  //       seconds: 3,
                                  //     ),color: Colors.orange.withOpacity(0.5)),
                                  MarqueeText(
                                    marqueeDirection: MarqueeDirection.ltr,
                                    alwaysScroll: true,
                                    text: TextSpan(
                                      text: '💠...Connect to Smart Masjid...💠',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18,
                                        color: Get.theme.hoverColor
                                      )
                                    ),
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    speed: 20,
                                  ),
                                  Space(8),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16, left: 16),
                                    child: Center(
                                      child: Obx(() {
                                        if (controller.showFirstImage.value) {
                                          return Image.asset('assets/images/guestad1new.png');
                                        } else if (controller.showSecondImage.value) {
                                          return Image.asset('assets/images/guestad2.png');
                                        } else {
                                          return Image.asset('assets/images/guestad3.png');
                                        }
                                      }),
                                    ),
                                  ),
                                  Space(4),
                                  Row(
                                    children: [
                                      MediumCard(
                                        title: 'services'.tr,
                                        image: 'donation',
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
                                      ),
                                      Column(
                                        children: [
                                          SmallCard(
                                            rightpad: 3,
                                            maxLines: 1,
                                            image: 'membership',
                                            title: 'membership'.tr,
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
                                          ),
                                          SmallCard(
                                            image: 'donation',
                                            title: 'donation'.tr,
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
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  buildDivider(themeData),
                                  // Obx(() {
                                  //   return controller.isloadingiman.value
                                  //       ? CupertinoActivityIndicator()
                                  //       : ImanTracker_widget(
                                  //       themeData: themeData);
                                  // }),
                                  // buildDivider(themeData),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      MediumCard(
                                        title: 'zakath'.tr,
                                        image: 'zakath',
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      ZakathpageView()));
                                        },
                                      ),
                                      Column(
                                        children: [
                                          SmallCard(
                                            image: 'history',
                                            title: 'history'.tr,
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
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                  ),
                                ],
                              ))
                        ]),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.toNamed(Routes.MASJIDNEARME);
                              },
                              child: SvgPicture.asset(
                                "assets/svg/masjidbot.svg",
                                color: Get.theme.appBarTheme.backgroundColor,)),
                          Space(8),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.QURANPAGE);
                              },
                              child: SvgPicture.asset(
                                  "assets/svg/quranbot.svg",
                                  color: Get.theme.appBarTheme
                                      .backgroundColor)),
                          Space(8),
                          SvgPicture.asset("assets/svg/homebot.svg", color: Get
                              .theme.appBarTheme.backgroundColor),
                          Space(8),
                          InkWell(
                              onTap: () {
                                Get.toNamed(Routes.MEDIAPAGE);
                              },
                              child: SvgPicture.asset("assets/svg/mediabot.svg",
                                  color: Get.theme.appBarTheme
                                      .backgroundColor)),
                          Space(8),
                          InkWell(
                              onTap: () {
                                Get.toNamed(Routes.QIBLAFINDERPAGE);
                              },
                              child: SvgPicture.asset("assets/svg/qiblabot.svg",
                                  color: Get.theme.appBarTheme
                                      .backgroundColor)),
                        ])));
          },
        ),
      );
    });
  }

  Divider buildDivider(ThemeData themeData) {
    return Divider(
      color: themeData.dividerColor.withOpacity(.4),
      thickness: 1,
      height: 18.h,
      endIndent: 8,
      indent: 8,
    );
  }

  PreferredSize buildPreferredSize(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Container(
          height: 35,
          color: Get.theme.hoverColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Space(16),
              Icon(
                Icons.location_on_sharp,
                color: Get.theme.appBarTheme.backgroundColor,
                size: 21,
              ),
              SizedBox(
                width: 5,
              ),
              Obx(() {
                return Text(
                  '${controller.cityName.value}',
                  style: TextStyle(
                      fontSize: 14, color: Get.theme.appBarTheme.backgroundColor
                    // color: Theme.of(context).hintColor,
                  ),
                );
              }),
              Spacer(),
              Row(
                children: [
                  IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        // Get.changeTheme(ThemeData.dark());
                        // Get.changeTheme(ThemeData.dark());

                        ThemeService().changeTheme();
                        sctrl.switchValue.value =  !sctrl.switchValue.value;
                        print("DDDD${Get.isDarkMode}");
                      },
                      icon: Container(
                        child: Icon(
                          Icons.sunny,
                          color: Get.theme.appBarTheme.backgroundColor,
                          size: 20,
                        ),
                      )),

                ],
              )
            ],
          ),
        ));
  }
}

class Imanprogress extends StatelessWidget {
  const Imanprogress({
    super.key,
    required this.themeData,
    required this.text, required this.percent,
  });

  final ThemeData themeData;
  final String text;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stxt(
            text: text,
            size: f2,
            color: Get.theme.primaryColor,

          ),
          SizedBox(
            height: 5,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.symmetric(horizontal: 2),
            barRadius: Radius.circular(5),
            width: 80.0,
            lineHeight: 7,
            percent: percent,
            backgroundColor: Colors.grey,
            progressColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;

  const TabsIcon({Key? key,
    this.color = Colors.white,
    this.height = 60,
    this.width = 50,
    required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icons,
          color: color,
        ),
      ),
    );
  }
}

class Location_permission extends StatelessWidget {
  Location_permission({super.key});

  final GuestmodeController con = Get.find<GuestmodeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.location_on))
        ],
      ),
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  final TextEditingController pass = TextEditingController();
  final TextEditingController c = TextEditingController();
  final GuestmodeController controller = Get.find<GuestmodeController>();
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
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/guestmasjidnew.png", width: 150,),
          Space(8),
          Text("Register with your Masjid to Join \n➽ MemberShip,\n➽ Donation\n➽ Services of Masjid", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),),
          Space(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  controller.guesttoken.remove("guest");
                  Get.offAllNamed(AppPages.INITIAL);
                },
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Get.theme.focusColor,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(child: Stxt(text: "Register", size: f3, color: Get.theme.primaryColor,)),
                  ),
                ),
              ) ,
              Space(16),
              InkWell(
                onTap: (){
                  controller.guesttoken.remove("guest");
                  Get.offAllNamed(AppPages.INITIAL);
                },
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(color: Get.theme.focusColor),
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(child: Stxt(text: "Login", size: f3, color: Get.theme.focusColor,)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
