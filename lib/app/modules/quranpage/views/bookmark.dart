import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/controllers/quranpage_controller.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';

import '../../../routes/export.dart';

class Bookmark extends StatelessWidget {
  Bookmark({super.key});

  final qcontroller = Get.put(QuranpageController());

  @override
  Widget build(BuildContext context) {
    String symbol = ':';
    String space = ' ';

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
            Scaffold(
              body:  Center(
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
              )
            ),
            Obx(() {
            return qcontroller.buttonsSelected.isEmpty? NoBookmark() : ListView.builder(
              itemCount: qcontroller.buttonsSelected.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Stxt(
                          text: "${qcontroller.buttonsSelected[index]}",
                          size: f2,
                          weight: FontWeight.bold,
                        ), onTap: () {
                        var symbolIndex = qcontroller.buttonsSelected[index].indexOf(
                            symbol);
                        if (symbolIndex != -1 && symbolIndex <
                            qcontroller.buttonsSelected[index].length - 1) {
                          qcontroller.result.value = qcontroller.buttonsSelected[index]
                              .substring(symbolIndex + 1)
                              .trim();
                          print(qcontroller.result.value.toString()); // Output: "12"
                        }
                        var spaceIndex = qcontroller.buttonsSelected[index].indexOf(
                            space);
                        var symbol1Index = qcontroller.buttonsSelected[index].indexOf(
                            symbol);

                        if (spaceIndex != -1 && symbol1Index != -1 &&
                            spaceIndex < symbol1Index) {
                          qcontroller.result1.value = qcontroller.buttonsSelected[index]
                              .substring(spaceIndex + 1, symbol1Index)
                              .trim();
                          print(qcontroller.result1.value); // Output: "17"
                        }
                        //  Get.to(QuranDetails());
                        qcontroller.quranDetailList(qcontroller.result1.value);
                      }, trailing: IconButton(onPressed: () {
                        qcontroller.buttonsSelected.removeAt(index);
                        qcontroller.deleteIndex(index);
                        qcontroller.update();
                      }, icon: Icon(Icons.delete)),
                      )),
                );
              },
            );
          }),
            Obx(() {
              return qcontroller.buttonsSelected.isEmpty? NoBookmark() : ListView.builder(
                itemCount: qcontroller.buttonsSelected.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                    child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Stxt(
                            text: "${qcontroller.buttonsSelected[index]}",
                            size: f2,
                            weight: FontWeight.bold,
                          ), onTap: () {
                          var symbolIndex = qcontroller.buttonsSelected[index].indexOf(
                              symbol);
                          if (symbolIndex != -1 && symbolIndex <
                              qcontroller.buttonsSelected[index].length - 1) {
                            qcontroller.result.value = qcontroller.buttonsSelected[index]
                                .substring(symbolIndex + 1)
                                .trim();
                            print(qcontroller.result.value.toString()); // Output: "12"
                          }
                          var spaceIndex = qcontroller.buttonsSelected[index].indexOf(
                              space);
                          var symbol1Index = qcontroller.buttonsSelected[index].indexOf(
                              symbol);

                          if (spaceIndex != -1 && symbol1Index != -1 &&
                              spaceIndex < symbol1Index) {
                            qcontroller.result1.value = qcontroller.buttonsSelected[index]
                                .substring(spaceIndex + 1, symbol1Index)
                                .trim();
                            print(qcontroller.result1.value); // Output: "17"
                          }
                          //  Get.to(QuranDetails());
                          qcontroller.quranDetailList(qcontroller.result1.value);
                        }, trailing: IconButton(onPressed: () {
                          qcontroller.buttonsSelected.removeAt(index);
                          qcontroller.deleteIndex(index);
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
