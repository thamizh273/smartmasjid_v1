import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/controllers/quranpage_controller.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';

import '../../../routes/export.dart';

class Bookmark extends StatelessWidget {
  Bookmark({super.key});

  final controller = Get.put(QuranpageController());

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
          title:Text( "Bookmarks"),
        bottom: TabBar(
          tabs: [
          Tab(
          text: 'Surah',
        ),
        Tab(
          text: 'Ayah',
        ),
            Tab(
          text: 'Juz',
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
                    Stxt(text: "No Bookmarks yet", size: f5, weight: FontWeight.w600,),
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
                        child: Text("Read Holy Quran", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
                    Space(16),
                    Stxt(text: "Read and add your favourite to\n"
                        "Bookmarks, that will appear here", size: f2, color: Colors.black.withOpacity(0.4),)
                  ],
                ),
              )
            ),
            Obx(() {
            return controller.buttonsSelected.isEmpty? NoBookmark() : ListView.builder(
              itemCount: controller.buttonsSelected.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Stxt(
                          text: "${controller.buttonsSelected[index]}",
                          size: f2,
                          weight: FontWeight.bold,
                        ), onTap: () {
                        var symbolIndex = controller.buttonsSelected[index].indexOf(
                            symbol);
                        if (symbolIndex != -1 && symbolIndex <
                            controller.buttonsSelected[index].length - 1) {
                          c.result.value = controller.buttonsSelected[index]
                              .substring(symbolIndex + 1)
                              .trim();
                          print(c.result.value.toString()); // Output: "12"
                        }
                        var spaceIndex = controller.buttonsSelected[index].indexOf(
                            space);
                        var symbol1Index = controller.buttonsSelected[index].indexOf(
                            symbol);

                        if (spaceIndex != -1 && symbol1Index != -1 &&
                            spaceIndex < symbol1Index) {
                          c.result1.value = controller.buttonsSelected[index]
                              .substring(spaceIndex + 1, symbol1Index)
                              .trim();
                          print(c.result1.value); // Output: "17"
                        }
                        //  Get.to(QuranDetails());
                        controller.quranDetailList(c.result1.value);
                      }, trailing: IconButton(onPressed: () {
                        controller.buttonsSelected.removeAt(index);
                        controller.deleteIndex(index);
                        controller.update();
                      }, icon: Icon(Icons.delete)),
                      )),
                );
              },
            );
          }),
            Obx(() {
              return controller.buttonsSelected.isEmpty? NoBookmark() : ListView.builder(
                itemCount: controller.buttonsSelected.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                    child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Stxt(
                            text: "${controller.buttonsSelected[index]}",
                            size: f2,
                            weight: FontWeight.bold,
                          ), onTap: () {
                          var symbolIndex = controller.buttonsSelected[index].indexOf(
                              symbol);
                          if (symbolIndex != -1 && symbolIndex <
                              controller.buttonsSelected[index].length - 1) {
                            c.result.value = controller.buttonsSelected[index]
                                .substring(symbolIndex + 1)
                                .trim();
                            print(c.result.value.toString()); // Output: "12"
                          }
                          var spaceIndex = controller.buttonsSelected[index].indexOf(
                              space);
                          var symbol1Index = controller.buttonsSelected[index].indexOf(
                              symbol);

                          if (spaceIndex != -1 && symbol1Index != -1 &&
                              spaceIndex < symbol1Index) {
                            c.result1.value = controller.buttonsSelected[index]
                                .substring(spaceIndex + 1, symbol1Index)
                                .trim();
                            print(c.result1.value); // Output: "17"
                          }
                          //  Get.to(QuranDetails());
                          controller.quranDetailList(c.result1.value);
                        }, trailing: IconButton(onPressed: () {
                          controller.buttonsSelected.removeAt(index);
                          controller.deleteIndex(index);
                          controller.update();
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
            Stxt(text: "No Bookmarks yet", size: f5, weight: FontWeight.w600,),
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
                child: Text("Read Holy Quran", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
            Space(16),
            Stxt(text: "Read and add your favourite to\n"
              "Bookmarks, that will appear here", size: f2, color: Colors.black.withOpacity(0.4),)
          ],
        ),
      ),
    );
  }
}
