import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/controllers/iman_tracker_controller.dart';

import '../../../routes/export.dart';
import '../controllers/iman_tracker_controller.dart';

class ImanTrackerView extends GetView<ImanTrackerController> {
  ImanTrackerView({Key? key}) : super(key: key);
  List prayerList = [
    {"icon": "fajr_icon", "name": "Fajr"},
    {"icon": "dhuhr_icon", "name": "Dhuhr"},
    {"icon": "asr", "name": "Asr"},
    {"icon": "magrib", "name": "Magrib"},
    {"icon": "isha", "name": "Isha"}
  ];
  List quranList = [
    {"icon": "read_quran", "name": "Read Quran"},
    {"icon": "memorize_quran", "name": "Memorize Quran"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: "Iman Tracker",
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(2),
              controller: controller.tabctrl,
              tabs: controller.myTabs,
            ),
          ),
          height: 80.h,
        ),
        body: TabBarView(
          controller: controller.tabctrl,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  10.verticalSpace,
                  Stxt(
                    text: "Prayers",
                    size: f3,
                    weight: FontWeight.bold,
                  ),
                  for (var k in prayerList)
                    imanCard(
                      image: '${k["icon"]}',
                      title: '${k["name"]}',
                    ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: .2.w,
                        ),
                        Stxt(
                          text: "Quran",
                          size: f3,
                          weight: FontWeight.bold,
                        ),
                        Stxt(
                          text: "Change Goals",
                          size: f0,
                          weight: FontWeight.bold,
                          color: Get.theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  for (var k in quranList)
                    imanCard(
                      image: '${k["icon"]}',
                      title: '${k["name"]}',
                    ),
                ],
              ),
            ),
            ListView(
              children: [
                Card(
                  color: Colors.blueGrey,
                  child: Column(children: [
                    Stxt(text: 'Fajr', size: f3)
                  ],),
                )
              ],
            )
          ],
        ));
  }
}

class imanCard extends StatelessWidget {
  const imanCard({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        //  minVerticalPadding: 0,
        contentPadding: EdgeInsets.only(left: 20.sp),
        tileColor: Colors.white,
        leading: SvgPicture.asset(
          "assets/icons/$image.svg",
          height: 20,
          color: Get.theme.primaryColor,
        ),
        title: Stxt(
          text: '$title',
          size: f3,
          weight: FontWeight.w500,
        ),
        trailing: ClipPath(
          clipper: TriangleClipper(),
          child: Container(
              width: 80.w,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.add)),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width * 1, 0);
    path.lineTo(size.width, size.height * 1);

    path.lineTo(size.width * 0.2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
