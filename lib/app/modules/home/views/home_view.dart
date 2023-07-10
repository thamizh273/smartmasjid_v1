
import 'package:flutter/gestures.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/events.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';
import '../controllers/home_controller.dart';
import '../widgets/imanTracker.dart';
import '../widgets/mediumCard.dart';
import '../widgets/prayerTimes.dart';

class HomeView extends GetView<HomeController> {
   HomeView({Key? key}) : super(key: key);
   CarouselController _carouselController = CarouselController();
   final List<String> items = ["Pondicherry", "villupuram"];
   // final List<String> imgList = ['fajr', 'dhuhar'];

   List quranImg = ['quran_list_img1', 'quran_list_img2', 'quran_list_img3'];
   List duaImg = ['dua_img1', 'dua_img2', 'dua_img3'];
  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 10,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xffD8E4E8),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset("assets/svg/slogo.svg",
              height: 30.00, width: 40.00),
        ),
        title: const Text("Masjid-e-nooraniah"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SPLASH_SCREEN);
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     transitionDuration: Duration(milliseconds: 600),
                //     // Custom animation duration
                //     pageBuilder: (context, animation, secondaryAnimation) {
                //       return ProfilePage();
                //     },
                //     transitionsBuilder:
                //         (context, animation, secondaryAnimation, child) {
                //       return FadeTransition(
                //         opacity: animation,
                //         child: child,
                //       );
                //     },
                //   ),
                // );
              },
              child: Hero(
                //  transitionOnUserGestures : true,
                tag: 'avatarTag',
                child: CircleAvatar(
                  radius: 21.5,
                  backgroundColor: themeData.primaryColor,
                  child: const CircleAvatar(
                    foregroundImage: AssetImage('assets/images/avathar.png'),
                    radius: 20,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
        bottom: buildPreferredSize(context),
      ),
      body: FrostedBottomBar(
        width: 330.w,
        opacity: .8,
        sigmaX: 10,
        sigmaY: 10,
        bottomBarColor: themeData.primaryColor,
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controllers) => TabBarView(
            controller: controller.tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: [
              SingleChildScrollView(
                // controller: tabController,
                  padding: EdgeInsets.only(left: 10),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => NotificationPage(),
                              //   ));
                            },
                            child: SvgPicture.asset("assets/svg/notification.svg",
                                height: 60.h),
                          ),
                          GestureDetector(
                            onTap: (){
                              // Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeatherApp()));
                            },
                            child: SvgPicture.asset("assets/svg/weather.svg",
                                height: 60.h),
                          ),
                          SvgPicture.asset("assets/svg/message.svg",
                              height: 60.h),
                          SvgPicture.asset("assets/svg/settings.svg",
                              height: 60.h),
                        ],
                      ),
                      PrayerTimes(),
                      Events(carouselController: _carouselController),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildDivider(themeData),
                      Row(
                        children: [
                          SmallCard(
                            image: 'library',
                            title: 'Library', onTap:(){},
                          ),
                          SmallCard(
                            image: 'hadith',
                            title: 'Hadith', onTap: (){},
                          )
                        ],
                      ),
                      buildDivider(themeData),
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => QuranPage()),
                          // );
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
                          MediumCard(
                            color: themeData.colorScheme.secondary,
                            title: 'Masjid Near me',
                            image: 'masjidFinder',
                          ),
                          Column(
                            children: [
                              SmallCard(
                                color: themeData.colorScheme.secondary,
                                image: 'qibla_finder',
                                title: 'Qibla\nFinder', onTap: () {
                                //  Navigator.of(context).push(MaterialPageRoute(builder: (_) => QiblaFinder()));
                              },
                              ),
                              SmallCard(

                                color: themeData.colorScheme.secondary,
                                image: 'prayer_time',
                                title: 'Prayer\nTime', onTap: () {

                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTime(),));
                              },
                              )
                            ],
                          ),
                        ],
                      ),
                      buildDivider(themeData),
                      LargerCard(
                        quranImg: duaImg,
                        buttonTxt: 'View all',
                        image: 'dua',
                        title: 'Dua',
                        subtitle: 'Dua for ease and success \n in life',
                        lastseen: 'Opened 13 hrs ago',
                      ),
                      buildDivider(themeData),
                      Row(
                        children: [
                          MediumCard(
                            color: themeData.colorScheme.secondary,
                            title: 'Special Days',
                            image: 'special_days',
                          ),
                          Column(
                            children: [
                              SmallCard(
                                color: themeData.colorScheme.secondary,
                                image: 'hijri_calender',
                                title: 'Hijri\nCalender', onTap: () {  },
                              ),
                              SmallCard(
                                color: themeData.colorScheme.secondary,
                                image: 'events',
                                title: 'Events', onTap: () {  },
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

                          ),
                          Column(
                            children: [
                              SmallCard(
                                image: 'membership',
                                title: 'Library', onTap: () {  },
                              ),
                              SmallCard(
                                image: 'donation',
                                title: 'Donation', onTap: () {  },
                              )
                            ],
                          ),
                        ],
                      ),
                      buildDivider(themeData),
                      ImanTracker_widget(themeData: themeData),
                      buildDivider(themeData),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MediumCard(
                            title: 'Zakath\nCalculator',
                            image: 'zakath',

                          ),
                          Column(
                            children: [
                              SmallCard(
                                image: 'history',
                                title: 'History', onTap: () {  },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30  .h,
                      )
                    ],
                  ))
            ]), child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset("assets/svg/masjidbot.svg"),
            Space(8),
            SvgPicture.asset("assets/svg/quranbot.svg"),
            Space(8),
            SvgPicture.asset("assets/svg/homebot.svg"),
            Space(8),
            SvgPicture.asset("assets/svg/mediabot.svg"),
            Space(8),
            SvgPicture.asset("assets/svg/donatebot.svg"),
          ],
        ),
      ),
        // child: TabBar(
        //   indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        //   controller: tabController,
        //   indicator: const UnderlineTabIndicator(
        //     borderSide: BorderSide(color: Colors.orange, width: 4),
        //     insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
        //   ),
        //   tabs: [
        //     TabsIcon(
        //         icons: Icons.home,
        //         color: currentPage == 0 ? colors[0] : Colors.white),
        //     TabsIcon(
        //         icons: Icons.search,
        //         color: currentPage == 1 ? colors[1] : Colors.white),
        //     TabsIcon(
        //         icons: Icons.queue_play_next,
        //         color: currentPage == 2 ? colors[2] : Colors.white),
        //     TabsIcon(
        //         icons: Icons.file_download,
        //         color: currentPage == 3 ? colors[3] : Colors.white),
        //     TabsIcon(
        //         icons: Icons.menu,
        //         color: currentPage == 4 ? colors[4] : Colors.white),
        //   ],
        // ),
      ),
    );
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
                        .map((e) => DropdownMenuItem(
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
    required this.themeData, required this.text,
  });

  final ThemeData themeData;
  final String text;

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
          SizedBox(
            width: 80.w,
            child: StepProgressIndicator(
              totalSteps: 10,
              currentStep: 4,
              size: 5,
              padding: 0,
              selectedColor: Color(0xff4EAF2C),
              unselectedColor: Color(0xffAFAFAF),
              roundedEdges: Radius.circular(10),
            ),
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

  const TabsIcon(
      {Key? key,
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