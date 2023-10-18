import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartmasjid_v1/app/modules/audioplayer/views/audioplayer_view.dart';
import 'package:smartmasjid_v1/app/modules/duapage/views/duapage_view.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/views/hadithpage_view.dart';
import 'package:smartmasjid_v1/app/modules/hijripage/views/hijripage_view.dart';
import 'package:smartmasjid_v1/app/modules/home/Drawer_List/masjid_admins.dart';
import 'package:smartmasjid_v1/app/modules/home/Drawer_List/masjid_facility.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/events.dart';
import 'package:smartmasjid_v1/app/modules/librarypage/views/librarypage_view.dart';
import 'package:smartmasjid_v1/app/modules/masjidhistory/views/masjidhistory_view.dart';
import 'package:smartmasjid_v1/app/modules/mediapage/views/mediapage_view.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/views/prayerpage_view.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import 'package:smartmasjid_v1/app/modules/servicepage/views/servicepage_view.dart';
import 'package:smartmasjid_v1/app/modules/specialdayspage/views/specialdayspage_view.dart';
import 'package:smartmasjid_v1/app/modules/zakathpage/views/zakathpage_view.dart';


import '../../../../widgets/loading.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../masjidnearme/helper/custom_marker_info_window.dart';
import '../Drawer_List/masjid_imam.dart';
import '../Drawer_List/well_wisher.dart';
import '../controllers/home_controller.dart';
import '../widgets/imanTracker.dart';
import '../widgets/mediumCard.dart';
import '../widgets/prayerTimes.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();
 final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  final CarouselController _carouselController = CarouselController();
  final List<String> items = ["Pondicherry", "villupuram"];

  // final List<String> imgList = ['fajr', 'dhuhar'];

  final List quranImg = [
    'quran_list_img1',
    'quran_list_img2',
    'quran_list_img3'
  ];
  final List duaImg = ['dua_img1', 'dua_img2', 'dua_img3'];

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    final themeData = Theme.of(context);
    return Scaffold(
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
            },

            child: Image.asset("assets/images/slogonw.png",),
          ),
        ),
        title: Obx(() {
          return  controller.isloading.value?CupertinoActivityIndicator():Text(
            "${controller.getUserData.value.getUserById!.masjidId!
                .masjidName}",
            style: TextStyle(color: Get.theme.hoverColor),
          );
        }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                // List<int> imageBytes =  base64Decode("${controller.getUserData.value.getUserById!.profileImage!.data}");
                // print("${controller.getUserData.value.getUserById!.profileImage!.data}");
                // print('wwww $imageBytes');
                Get.toNamed(Routes.PROFILE_PAGE);
              },
              child: Hero(
                //  transitionOnUserGestures : true,
                tag: 'avatarTag',
                child: CircleAvatar(
                  radius: 21.5,
                  backgroundColor: themeData.primaryColor,
                  child: Obx(() {
                    // var imageBytes = base64Decode(controller
                    //     .getUserData.value.getUserById!.profileImage
                    //     .toString());
                    var guestnull = controller.getUserData.value
                        .getUserById == null;
                    return (guestnull ||
                        controller.getUserData.value.getUserById!
                            .profileImage == "null")
                        ? CircleAvatar(
                      foregroundImage:
                      AssetImage("assets/images/avathar.png"),
                      radius: 20,
                      backgroundColor: Colors.white,
                    )
                        :  controller.isloading.value?CupertinoActivityIndicator():CircleAvatar(
                      // foregroundImage: AssetImage("assets/images/avathar.png"),
                      foregroundImage: MemoryImage(base64Decode(controller
                          .getUserData.value.getUserById!.profileImage
                          .toString())),
                      radius: 20,
                      backgroundColor: Colors.white,
                    );
                  }),
                ),
              ),
            ),
          )

//             ),
//           )
        ],
        bottom: buildPreferredSize(context),
      ),
      key: controller.scaffoldKey,
      drawer: Obx(() {
        return controller.isloading.value
            ? CupertinoActivityIndicator()
            : Drawer(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width / devicePixelRatio,
            height: MediaQuery
                .of(context)
                .size
                .height / devicePixelRatio,
            color: Get.theme.scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[

                Container(
                  height: 130.h,
                  child: DrawerHeader(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom:8),
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
                              child: SvgPicture.asset("assets/svg/slogonew.svg",
                                  height: 70.00, width: 80.00),
                            ),
                            Space(16),
                            SizedBox(
                                width: 0.44.sw,
                                child: Stxt(
                                  text: "${controller.getUserData.value.getUserById!
                                      .masjidId!
                                      .masjidName}",
                                  size: f5,
                                  weight: FontWeight.w600,
                                  color: Get.theme.scaffoldBackgroundColor,))
                          ],
                        ),
                      ],
                    ),

                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MasjidFacility()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/Masjiddr.svg",
                          color: Get.theme.hoverColor,),
                        Space(16),
                        Stxt(text: "masjid_facilities".tr,
                          size: f3,
                          weight: FontWeight.w500,)
                      ],
                    ),
                    // onTap: controller.closeDrawer,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(MasjidhistoryView());
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/Historydr.svg",
                            color: Get.theme.hoverColor),
                        Space(16),
                        Stxt(text: "masjid_history".tr,
                          size: f3,
                          weight: FontWeight.w500,)
                      ],
                    ),
                    // onTap: controller.closeDrawer,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MasjidAdmin()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/Admindr.svg",
                            color: Get.theme.hoverColor),
                        Space(16),
                        Stxt(text: "masjid_admins".tr,
                          size: f3,
                          weight: FontWeight.w500,)
                      ],
                    ),
                    // onTap: controller.closeDrawer,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MasjidImam()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset(
                            "assets/svg/imamdr.svg",
                            color: Get.theme.hoverColor),
                        Space(16),
                        Stxt(text: "masjid_imams".tr,
                          size: f3,
                          weight: FontWeight.w500,)
                      ],
                    ),
                    // onTap: controller.closeDrawer,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => WellWisher()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset(
                            "assets/svg/voldr.svg",
                            color: Get.theme.hoverColor),
                        Space(16),
                        Stxt(text: "masjid_well_wishers".tr,
                          size: f3,
                          weight: FontWeight.w500,)
                      ],
                    ),
                    // onTap: controller.closeDrawer,
                  ),
                ),
                Space(16),
                ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stxt(text: "quick_menu".tr, size: f4),
                        Space(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.PRAYERPAGE);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: 65.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: Offset(4, 4),
                                          color: Get.theme.shadowColor
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/prayerdr.svg", width: 50,),
                                    Stxt(text: "prayer_time".tr,
                                      size: f1,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                            ),
                            Space(30),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.MEMBERSHIP);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: 65.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: Offset(-4, 4),
                                          color: Get.theme.shadowColor
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/memberdr.svg", width: 60,),
                                    Stxt(
                                      text: "membership".tr,
                                      size: f1,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Space(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ServicepageView()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: 65.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: Offset(4, 4),
                                          color: Get.theme.shadowColor
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/servicedr.svg", width: 40,),
                                    Stxt(
                                      text: "services".tr,
                                      size: f1,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,)
                                  ],
                                ),
                              ),
                            ),
                            Space(30),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Get.toNamed(Routes.EVENTS);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                height: 65.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                          offset: Offset(-4, 4),
                                          color: Get.theme.shadowColor
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/eventsdr.svg", width: 40,),
                                    Stxt(
                                      text: "events".tr, size: f1, color: Theme
                                        .of(context)
                                        .primaryColor,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stxt(text: "leave_masjid".tr,
                      size: f2.h,
                      weight: FontWeight.w600,
                      color: Get.theme.hoverColor,),
                    Space(16),
                    Icon(Icons.logout, color: Get.theme.hoverColor)
                  ],
                ),
                Space(30),
              ],
            ),
          ),
        );
      }),
      body: Obx(() {
        return controller.isloading.value
            ?DialogHelper.showLoading()
            : StreamBuilder<LocationData>(
          stream: Location.instance.onLocationChanged,
          builder: (context, snap) {
            // if(snap.data == null) return CupertinoActivityIndicator();
            return FrostedBottomBar(
                width: 330.w,
                opacity: 1,
                sigmaX: 10,
                sigmaY: 10,
                bottomBarColor: Get.theme.hintColor,
                borderRadius: BorderRadius.circular(500),
                duration: const Duration(milliseconds: 800),
                hideOnScroll: true,
                body: (context, controllers) =>
                    TabBarView(
                        controller: controller.tabController,
                        dragStartBehavior: DragStartBehavior.down,
                        physics: BouncingScrollPhysics(),
                        children: [
                          RefreshIndicator(
                            key: refreshIndicatorKey,
                            onRefresh: homecntrll.refreshData,
                            child: SingleChildScrollView(
                              // controller: tabController,
                              //   padding: EdgeInsets.only(left: 10),
                                physics: BouncingScrollPhysics(),
                                child:  Column(
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
                                              Get.toNamed(
                                                  Routes.NOTIFICATIONPAGE);
                                            },
                                            child: Container(
                                              height: 48.h,
                                              width: 48.h,
                                              decoration: BoxDecoration(
                                                  color: Get.theme.hoverColor,
                                                  borderRadius: BorderRadius
                                                      .circular(50)
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
                                                      .circular(50)
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
                                              Get.toNamed(Routes.MESSAGEPAGE);
                                            },
                                            child: Container(
                                              height: 48.h,
                                              width: 48.h,
                                              decoration: BoxDecoration(
                                                  color: Get.theme.hoverColor,
                                                  borderRadius: BorderRadius
                                                      .circular(50)
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
                                                      .circular(50)
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
                                    Obx(() {
                                      return controller.isloadingEvent.value
                                          ? CupertinoActivityIndicator()
                                          : Events(
                                          carouselController:
                                          _carouselController);
                                    }),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    buildDivider(themeData),
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
                                        lastseen: 'last_read_13_hrs_ago'.tr,
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
                                                          PrayerpageView(),
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
                                        lastseen: 'Opened 13 hrs ago',
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
                                                Get.toNamed(Routes.EVENTS);
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
                                        lastseen: 'Opened 13 hrs ago',
                                      ),
                                    ),
                                    buildDivider(themeData),
                                    Row(
                                      children: [
                                        MediumCard(
                                          title: 'services'.tr,
                                          image: 'donation',
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) =>
                                                    ServicepageView()));
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
                                                Get.toNamed(Routes.MEMBERSHIP);
                                              },
                                            ),
                                            SmallCard(
                                              image: 'donation',
                                              title: 'donation'.tr,
                                              onTap: () {
                                                Get.toNamed(Routes.DONATIONPAGE);
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    buildDivider(themeData),
                                    Obx(() {
                                      return controller.isloadingiman.value
                                          ? CupertinoActivityIndicator()
                                          : ImanTracker_widget(
                                          themeData: themeData);
                                    }),
                                    buildDivider(themeData),
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
                                              title: 'masjid_history'.tr,
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MasjidhistoryView()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 80.h,
                                    )
                                  ],
                                )),
                          )
                        ]),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.to(CustomMarketInfoWindow());
                              },
                              child: SvgPicture.asset(
                                "assets/svg/masjidbot.svg",
                                color: Get.theme.focusColor,)),
                          Space(8),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.QURANPAGE);
                              },
                              child: SvgPicture.asset(
                                  "assets/svg/quranbot.svg",
                                  color: Get.theme.focusColor)),
                          Space(8),
                          SvgPicture.asset("assets/svg/homebot.svg", color: Get
                              .theme.focusColor),
                          Space(8),
                          InkWell(
                              onTap: () {
                                Get.toNamed(Routes.MEDIAPAGE);
                              },
                              child: SvgPicture.asset("assets/svg/mediabot.svg",
                                  color: Get.theme.focusColor)),
                          Space(8),
                          InkWell(
                              onTap: () {
                                Get.toNamed(Routes.QIBLAFINDERPAGE);
                              },
                              child: SvgPicture.asset("assets/svg/qiblabot.svg",
                                  color: Get.theme.focusColor)),
                        ])));
          },
        );
      }),
    );
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

  final HomeController con = Get.find<HomeController>();

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

