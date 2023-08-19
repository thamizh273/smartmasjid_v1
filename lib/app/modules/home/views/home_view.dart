import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smartmasjid_v1/app/modules/audioplayer/views/audioplayer_view.dart';
import 'package:smartmasjid_v1/app/modules/duapage/views/duapage_view.dart';
import 'package:smartmasjid_v1/app/modules/hadithpage/views/hadithpage_view.dart';
import 'package:smartmasjid_v1/app/modules/hijripage/views/hijripage_view.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/events.dart';
import 'package:smartmasjid_v1/app/modules/masjidhistory/views/masjidhistory_view.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/views/prayerpage_view.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import 'package:smartmasjid_v1/app/modules/specialdayspage/views/specialdayspage_view.dart';
import 'package:smartmasjid_v1/app/modules/zakathpage/views/zakathpage_view.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../utils/ansomeNotification.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
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
                color: Color(0xffD8E4E8),
              ),
            ),
            leading: GestureDetector(
              onTap: () => controller.openDrawer(),
              onDoubleTap: () {
                Get.toNamed(Routes.SPLASH_SCREEN);
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset("assets/svg/slogo.svg",
                    height: 30.00, width: 40.00),
              ),
            ),
            title: Text(
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
                    Get.toNamed(Routes.PROFILE_PAGE);
                  },
                  child: Hero(
                    //  transitionOnUserGestures : true,
                    tag: 'avatarTag',
                    child: CircleAvatar(
                      radius: 21.5,
                      backgroundColor: themeData.primaryColor,
                      child: Obx(() {
                        var imageBytes = base64Decode(controller
                            .getUserData.value.getUserById!.profileImage
                            .toString());
                        return controller.getUserData.value.getUserById!
                            .profileImage == "null"
                            ? CircleAvatar(
                          foregroundImage:
                          AssetImage("assets/images/avathar.png"),
                          radius: 20,
                          backgroundColor: Colors.white,
                        )
                            : CircleAvatar(
                          // foregroundImage: AssetImage("assets/images/avathar.png"),
                          foregroundImage: MemoryImage(imageBytes),
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
                            child: SvgPicture.asset("assets/svg/slogo.svg",
                                height: 70.00, width: 80.00),
                          ),
                          Space(16),
                          SizedBox(
                              width: 0.45.sw,
                              child: Stxt(text: "Masjid-e-Nooraniah",
                                size: f5,
                                weight: FontWeight.w600,
                                color: Colors.white,))
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset("assets/svg/Masjiddr.svg"),
                      Space(16),
                      Stxt(text: "Masjid  Facilities",
                        size: f3,
                        weight: FontWeight.w500,)
                    ],
                  ),
                  // onTap: controller.closeDrawer,
                ), ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset("assets/svg/Historydr.svg"),
                      Space(16),
                      Stxt(text: "Masjid History",
                        size: f3,
                        weight: FontWeight.w500,)
                    ],
                  ),
                  // onTap: controller.closeDrawer,
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset("assets/svg/Admindr.svg"),
                      Space(16),
                      Stxt(text: "Masjid Admins",
                        size: f3,
                        weight: FontWeight.w500,)
                    ],
                  ),
                  // onTap: controller.closeDrawer,
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset("assets/svg/imamdr.svg"),
                      Space(16),
                      Stxt(text: "Masjid Imams",
                        size: f3,
                        weight: FontWeight.w500,)
                    ],
                  ),
                  // onTap: controller.closeDrawer,
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset("assets/svg/voldr.svg"),
                      Space(16),
                      Stxt(text: "Masjid well-wishers",
                        size: f3,
                        weight: FontWeight.w500,)
                    ],
                  ),
                  // onTap: controller.closeDrawer,
                ),
                Space(16),
                ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stxt(text: "Quick Menu", size: f4),
                        Space(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.PRAYERPAGE);
                              },
                              child: Container(
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
                                          color: Colors.grey.shade400
                                      )
                                    ],
                                    color: Color(0xffD8E4E8)
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/prayerdr.svg", width: 60,),
                                    Stxt(text: "Prayer Time",
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
                                Get.toNamed(Routes.MEMBERSHIP);
                              },
                              child: Container(
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
                                      text: "Membership", size: f1, color: Theme
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
                            Container(
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
                                  Stxt(text: "Services", size: f1, color: Theme
                                      .of(context)
                                      .primaryColor,)
                                ],
                              ),
                            ),
                            Space(30),
                            Container(
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
                                  Stxt(text: "Events", size: f1, color: Theme
                                      .of(context)
                                      .primaryColor,)
                                ],
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
                    Stxt(text: "Leave Masjid",
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
          body: FrostedBottomBar(
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
                                        Get.toNamed(
                                            Routes.NOTIFICATIONPAGE);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/svg/notifynew.svg",
                                          height: 60.h),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.WEATHERPAGE);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/svg/weathernew.svg",
                                          height: 60.h),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.MESSAGEPAGE);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/svg/messagenew.svg",
                                          height: 60.h),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.SETTINGSPAGE);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/svg/settingsnew.svg",
                                          height: 60.h),
                                    ),
                                    Space(2),
                                  ],
                                ),
                                Space(8),
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
                                SizedBox(
                                  height: 5.h,
                                ),
                                buildDivider(themeData),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.QURANPAGE);
                                  },
                                  child: LargerCard(
                                    quranImg: quranImg,
                                    buttonTxt: 'Continue',
                                    image: 'quran',
                                    title: 'Quran',
                                    subtitle: '114 suarhs, 30 Juz',
                                    lastseen: 'Last read 13 hrs ago',
                                    // onPressed: getQuranChaptersList,
                                  ),
                                ),
                                buildDivider(themeData),
                                Row(
                                  children: [
                                    SmallCard(
                                      image: 'hadith',
                                      title: 'Hadith',
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    HadithpageView()));
                                      },
                                    ),
                                    SmallCard(
                                      image: 'library',
                                      title: 'Library',
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AudioPlayerScreen()));
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
                                      title: 'Masjid Near me',
                                      image: 'masjidFinder',
                                      onTap: () {},
                                    ),
                                    Column(
                                      children: [
                                        SmallCard(
                                          color: themeData
                                              .colorScheme.secondary,
                                          image: 'qibla_finder',
                                          title: 'Qibla\nFinder',
                                          onTap: () {
                                            Get.to(QiblaFinder());
                                          },
                                        ),
                                        SmallCard(
                                          color: themeData
                                              .colorScheme.secondary,
                                          image: 'prayer_time',
                                          title: 'Prayer\nTime',
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
                                    buttonTxt: 'View all',
                                    image: 'dua',
                                    title: 'Dua',
                                    subtitle:
                                    'Dua for ease and success \n in life',
                                    lastseen: 'Opened 13 hrs ago',
                                  ),
                                ),
                                buildDivider(themeData),
                                Row(
                                  children: [
                                    MediumCard(
                                      color:
                                      themeData.colorScheme.secondary,
                                      title: 'Special Days',
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
                                          title: 'Hijri\nCalender',
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
                                          title: 'Events',
                                          onTap: () {
                                            AwesomeNotificationsHelper.showNotification(
                                                title: 'test number ${controller.notificationsCounter.value}',
                                                body: 'test notification number ${controller.notificationsCounter.value}',
                                                id: controller.notificationsCounter.value,
                                                // actionButtons: [
                                                //   NotificationActionButton(key: 'submit', label: 'Submit'),
                                                //   NotificationActionButton(key: 'cancel', label: 'Cancel'),
                                                // ]
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                buildDivider(themeData),
                                LargerCard(
                                  quranImg: quranImg,
                                  buttonTxt: 'View all',
                                  image: 'media',
                                  title: 'Media',
                                  subtitle:
                                  'Islamic Videos for ease and\nsuccess in life',
                                  lastseen: 'Opened 13 hrs ago',
                                ),
                                buildDivider(themeData),
                                Row(
                                  children: [
                                    MediumCard(
                                      title: 'Services',
                                      image: 'donation',
                                      onTap: () {},
                                    ),
                                    Column(
                                      children: [
                                        SmallCard(
                                          rightpad: 3,
                                          maxLines: 1,
                                          image: 'membership',
                                          title: 'Membership',
                                          onTap: () {
                                            Get.toNamed(Routes.MEMBERSHIP);
                                          },
                                        ),
                                        SmallCard(
                                          image: 'donation',
                                          title: 'Donation',
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
                                      title: 'Zakath\nCalculator',
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
                                          title: 'History',
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
                        SvgPicture.asset("assets/svg/masjidbot.svg"),
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
                        SvgPicture.asset("assets/svg/mediabot.svg"),
                        Space(8),
                        SvgPicture.asset("assets/svg/donatebot.svg"),
                      ]))));
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
          color: const Color(0xff4C7380),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                    hint: const Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.white,
                          size: 21,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Puducherry',
                          style: TextStyle(fontSize: 14, color: Colors.white
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
