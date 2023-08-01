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

    return Scaffold(
      appBar: CustomAppbar(tittle: "Bookmarks"),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.buttonsSelected.length,
          itemBuilder: (context, index) {
            return Card(
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
                ));
          },
        );
      }),
    );
  }
}
