import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/controllers/quranpage_controller.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';

import '../../../routes/export.dart';

class Bookmark extends StatelessWidget {
  Bookmark({super.key});

  final qcontroller = Get.put(QuranpageController());

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){Get.back();},
              child: SvgPicture.asset("assets/svg/backnew.svg", fit: BoxFit.scaleDown,)),
          backgroundColor: Theme.of(context).primaryColor,
          title:Text( "bookmarks".tr),
        bottom: TabBar(
          tabs: [
          Tab(
          text: 'surah'.tr,
        ),
        Tab(
          text: 'ayah'.tr,
        ),
            Tab(
          text: 'juz'.tr,
        ),
        ],
      ),
        ),
        body: TabBarView(
          children: [
            Obx(() {
              return qcontroller.buttonsSelectedSura.isEmpty? NoBookmark() : ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: qcontroller.buttonsSelectedSura.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only( right: 8, left: 8),
                    child: Card(
                      margin: EdgeInsets.all(1),
                        elevation: 10,
                        child: ListTile(
                          title:  Stxt(
                            text: "${qcontroller.buttonsSelectedSura[index]["index"]}. ${qcontroller.buttonsSelectedSura[index]["name"]}",
                            size: f3,
                            weight: FontWeight.w500,
                          ), onTap: () {
                       print('quran pass index${qcontroller.buttonsSelectedSura[index]["index"]}');
                       qcontroller.result.value =0;
                          // final quranindex = ;// Output: "17"
                          qcontroller.quranDetailList(qcontroller.buttonsSelectedSura[index]["index"]);
                        }, trailing: IconButton(onPressed: () {
                          qcontroller.buttonsSelectedSura.removeAt(index);
                          qcontroller.deleteIndexSura(index);

                          qcontroller.update();
                        }, icon: Icon(Icons.delete,color: Get.theme.primaryColor,)),
                        )),
                  );
                },
              );
            }),
            Obx(() {
            return qcontroller.buttonsSelected.isEmpty? NoBookmark() : ListView.builder(
              padding: EdgeInsets.only(top: 8),
              itemCount: qcontroller.buttonsSelected.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only( right: 8, left: 8),
                  child: Card(
                      margin: EdgeInsets.all(1),
                      elevation: 5,
                      child: ListTile(
                        title:  Stxt(
                          text: "${qcontroller.buttonsSelected[index]["name"]}",
                          size: f2,
                          weight: FontWeight.bold,
                        ), onTap: () {


                          qcontroller.result.value =  qcontroller.buttonsSelected[index]["index"];// Output: "17"
                          qcontroller.result1.value =  qcontroller.buttonsSelected[index]["no"];// Output: "17"


                        qcontroller.update();

                        qcontroller.buttonsSelected[index]["type"]=="sura"?qcontroller.quranDetailList(qcontroller.result1.value):qcontroller.quranjuzdetailList(qcontroller.result1.value);
                      }, trailing: IconButton(onPressed: () {
                        qcontroller.buttonsSelected.removeAt(index);
                        qcontroller.deleteIndex(index);

                        qcontroller.update();
                      }, icon: const Icon(Icons.delete)),
                      )),
                );
              },
            );
          }),
            Obx(() {
              return qcontroller.buttonsSelectedJuz.isEmpty? NoBookmark() : ListView.builder(
                padding: EdgeInsets.only(top: 8),
                itemCount: qcontroller.buttonsSelectedJuz.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only( right: 8, left: 8),
                    child: Card(
                        margin: EdgeInsets.all(1),
                        elevation: 5,
                        child: ListTile(
                          title:  Stxt(
                            text: "${qcontroller.buttonsSelectedJuz[index]["index"]}.${qcontroller.buttonsSelectedJuz[index]["name"]}",
                            size: f2,
                            weight: FontWeight.bold,
                          ), onTap: () {
                          print('quran pass index${qcontroller.buttonsSelectedJuz[index]["index"]}');
                          qcontroller.result.value =0;
                          // final quranindex = ;// Output: "17"
                          qcontroller.quranjuzdetailList(qcontroller.buttonsSelectedJuz[index]["index"]);
                        }, trailing: IconButton(onPressed: () {
                          qcontroller.buttonsSelectedJuz.removeAt(index);
                          qcontroller.deleteIndexJuz(index);

                          qcontroller.update();
                        }, icon: Icon(Icons.delete)),
                        )),
                  );
                },
              );
            }),

          ]
        ),
      ),
    );
  }
}

class NoBookmark extends StatelessWidget {
  const NoBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Space(100),
           Image.asset("assets/images/bookui.png", width: 250,),
            Space(16),
            Stxt(text: "no_bookmarks_yet".tr, size: f5, weight: FontWeight.w600,),
            Space(16),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuranDetails()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 40),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Color(0xff11323B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4.0,
                ),
                child: Text("read_holy_quran".tr, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
            Space(16),
            Stxt(text: "read_and_add_your_favourite_to_bookmarks_that_will_appear_here".tr, size: f2, color: Colors.black.withOpacity(0.4),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
