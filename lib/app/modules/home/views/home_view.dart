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
import 'package:smartmasjid_v1/app/modules/loginPage/Model/GetUserIDModel.dart';
import 'package:smartmasjid_v1/app/modules/masjidhistory/views/masjidhistory_view.dart';
import 'package:smartmasjid_v1/app/modules/mediapage/views/mediapage_view.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/views/prayerpage_view.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import 'package:smartmasjid_v1/app/modules/servicepage/views/servicepage_view.dart';
import 'package:smartmasjid_v1/app/modules/specialdayspage/views/specialdayspage_view.dart';
import 'package:smartmasjid_v1/app/modules/zakathpage/views/zakathpage_view.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../utils/ansomeNotification.dart';
import '../../../../utils/fcm_notification/fcm_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../../masjidnearme/helper/custom_marker_info_window.dart';
import '../Drawer_List/masjid_history.dart';
import '../Drawer_List/masjid_imam.dart';
import '../Drawer_List/well_wisher.dart';
import '../controllers/home_controller.dart';
import '../widgets/imanTracker.dart';
import '../widgets/mediumCard.dart';
import '../widgets/prayerTimes.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();

  CarouselController _carouselController = CarouselController();
  final List<String> items = ["Pondicherry", "villupuram"];

  // final List<String> imgList = ['fajr', 'dhuhar'];

  List quranImg = ['quran_list_img1', 'quran_list_img2', 'quran_list_img3'];
  List duaImg = ['dua_img1', 'dua_img2', 'dua_img3'];

  @override
  Widget build(BuildContext context) {
    var guest =controller.ggg==true;
    final themeData = Theme.of(context);
    return Obx(() {

      return controller.isloading.value
          ? loading(context)
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
              padding:  EdgeInsets.only(top: 10, left: 10, bottom: 6),
              child: GestureDetector(
                onTap: () { guest?guestmessage(): controller.openDrawer();},

                child: Image.asset("assets/images/slogonw.png",),
              ),
            ),
            title: Text(guest?"Ummati":
              "${controller.getUserData.value.getUserById!.masjidId!
                  .masjidName}",
              style: TextStyle(color: Theme
                  .of(context)
                  .primaryColor),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    // List<int> imageBytes =  base64Decode("${controller.getUserData.value.getUserById!.profileImage!.data}");
                    // print("${controller.getUserData.value.getUserById!.profileImage!.data}");
                    // print('wwww $imageBytes');
                    guest?guestmessage(): Get.toNamed(Routes.PROFILE_PAGE);
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
                       var guestnull= controller.getUserData.value.getUserById==null;
                        return (guestnull||controller.getUserData.value.getUserById!
                            .profileImage == "null")
                            ? CircleAvatar(
                          foregroundImage:
                          AssetImage("assets/images/avathar.png"),
                          radius: 20,
                          backgroundColor: Colors.white,
                        )
                            : CircleAvatar(
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
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
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
                              width: 0.45.sw,
                              child: Stxt(text: "${controller.getUserData.value.getUserById!.masjidId!
                                  .masjidName}",
                                size: f5,
                                weight: FontWeight.w600,
                                color: Colors.white,))
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidFacility()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/Masjiddr.svg"),
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
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidHistory()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/Historydr.svg"),
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
                  onTap: (){
                    Navigator.pop(context);
                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidAdmin()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/Admindr.svg"),
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
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidImam()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/imamdr.svg"),
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
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => WellWisher()));
                  },
                  child: ListTile(
                    title: Row(
                      children: [
                        SvgPicture.asset("assets/svg/voldr.svg"),
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
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                // height: 75.h,
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
                                          color: Colors.grey.shade400
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/prayerdr.svg", width: 60,),
                                    Stxt(text: "prayer_time".tr,
                                      size: f1,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,textAlign: TextAlign.center,)
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
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                // height: 65.h,
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
                                          color: Colors.grey.shade400
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/memberdr.svg", width: 80,),
                                    Stxt(
                                      text: "membership".tr, size: f1, color: Theme
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
                              onTap:(){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ServicepageView()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                // height: 65.h,
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
                                          color: Colors.grey.shade400
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/servicedr.svg", width: 40,),
                                    Stxt(text: "services".tr, size: f1, color: Theme
                                        .of(context)
                                        .primaryColor,)
                                  ],
                                ),
                              ),
                            ),
                            Space(30),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                Get.toNamed(Routes.EVENTS);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                // height: 65.h,
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
                                          color: Colors.grey.shade400
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/eventsdr.svg", width: 40,),
                                    Stxt(text: "events".tr, size: f1, color: Theme
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
                Space(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stxt(text: "leave_masjid".tr,
                      size: f3,
                      weight: FontWeight.w600,
                      color: Theme
                          .of(context)
                          .primaryColor,),
                    Space(16),
                    Icon(Icons.logout, color: Theme
                        .of(context)
                        .primaryColor)
                  ],
                )
              ],
            ),
          ),
          body: StreamBuilder<LocationData>(
            stream: Location.instance.onLocationChanged,
            builder: (context, snap){
              // if(snap.data == null) return CupertinoActivityIndicator();
              return FrostedBottomBar(
                  width: 330.w,
                  opacity: .8,
                  sigmaX: 10,
                  sigmaY: 10,
                  bottomBarColor: themeData.colorScheme.primary,
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
                                       guest?guestmessage():     Get.toNamed(
                                                Routes.NOTIFICATIONPAGE);
                                          },
                                          child: SvgPicture.asset(
                                              "assets/svg/notifynew.svg",
                                              height: 65.h),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.WEATHERPAGE);
                                          },
                                          child: SvgPicture.asset(
                                              "assets/svg/weathernew.svg",
                                              height: 65.h),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            guest?guestmessage():      Get.toNamed(Routes.MESSAGEPAGE);
                                          },
                                          child: SvgPicture.asset(
                                              "assets/svg/messagenew.svg",
                                              height: 65.h),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.SETTINGSPAGE);
                                          },
                                          child: SvgPicture.asset(
                                              "assets/svg/settingsnew.svg",
                                              height: 65.h),
                                        ),
                                        Space(2),
                                      ],
                                    ),
                                    guest?Container():    Space(8),
                                    Obx(() {
                                      return controller.isloading1.value
                                          ? CupertinoActivityIndicator()
                                          : PrayerTimes();
                                    }),
                                    Obx(() {
                                      return controller.isloadingEvent.value?CupertinoActivityIndicator(): Events(
                                          carouselController:
                                          _carouselController);
                                    }),
                                    guest?Container(): SizedBox(
                                      height: 5.h,
                                    ),
                                    buildDivider(themeData),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.QURANPAGE);
                                      },
                                      child: LargerCard(
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
                                                guest?guestmessage():   Get.toNamed(Routes.EVENTS);
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    buildDivider(themeData),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MediapageView()));
                                      },
                                      child: LargerCard(
                                        quranImg: quranImg,
                                        buttonTxt: 'view_all'.tr,
                                        image: 'media',
                                        title: 'media'.tr,
                                        subtitle:
                                        'islamic_videos_for_ease_and_success_in_life'.tr,
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
                                            guest?guestmessage():     Navigator.of(context).push(MaterialPageRoute(builder: (_) => ServicepageView()));
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
                                                guest?guestmessage():     Get.toNamed(Routes.MEMBERSHIP);
                                              },
                                            ),
                                            SmallCard(
                                              image: 'donation',
                                              title: 'donation'.tr,
                                              onTap: () {
                                                guest?guestmessage():    Get.toNamed(Routes.DONATIONPAGE);
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
                                              title: 'history'.tr,
                                              onTap: () {
                                                guest?guestmessage():       Navigator.of(context).push(
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
                                      height: 30.h,
                                    )
                                  ],
                                ))
                          ]),
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.MASJIDNEARME);
                                },
                                child: SvgPicture.asset("assets/svg/masjidbot.svg")),
                            Space(8),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.QURANPAGE);
                                },
                                child: SvgPicture.asset(
                                    "assets/svg/quranbot.svg")),
                            Space(8),
                            SvgPicture.asset("assets/svg/homebot.svg"),
                            Space(8),
                            InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.MEDIAPAGE);
                                },
                                child: SvgPicture.asset("assets/svg/mediabot.svg")),
                            Space(8),
                            InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.DONATIONPAGE);
                                },
                                child: SvgPicture.asset("assets/svg/donatebot.svg")),
                          ])));
            },
          ),
      );
    });
  }

  Divider buildDivider(ThemeData themeData) {
    return Divider(
      color: themeData.primaryColor.withOpacity(.4),
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
          color: Get.isDarkMode == false  ? Color(0xffD8E4E8) : Color(0xff4C7380),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                    hint:  Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Get.theme.primaryColor ,
                          size: 21,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Puducherry',
                          style: TextStyle(fontSize: 14, color: Get.theme.primaryColor
                            // color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((e) =>
                        DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                        .toList()),
              ),
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
                          color: Colors.white,
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
      body:  AlertDialog(
        actions: [
          IconButton(onPressed: ()  {

          }, icon: Icon(Icons.location_on))
        ],
      ),
    );
  }
}

