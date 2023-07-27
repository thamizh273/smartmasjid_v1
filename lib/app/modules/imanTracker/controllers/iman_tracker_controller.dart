import 'package:get/get.dart';

import '../../../routes/export.dart';

class ImanTrackerController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement ImanTrackerController

  late TabController tabctrl;
  var change=0.obs;
  RxBool aSunnah=false.obs;
  RxBool bSunnah=false.obs;

  @override
  void onInit() {
    super.onInit();
    tabctrl = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabctrl.dispose();
    super.onClose();
  }
  List<Map<String,dynamic>> cardColors = [
    {"color":Get.theme.colorScheme.secondary,"icon":Icons.add},
    {"color":Colors.green,"icon":Icons.groups_sharp},
    {"color":Colors.yellow.shade700,"icon":Icons.person},
    {"color":Colors.red.shade700,"icon":Icons.history},
    {"color":Colors.black87,"icon":Icons.not_interested},

  ];

  RxList<int> colorIndices = List.filled(5, 0).obs;

  void changeColor(int index) {
    colorIndices[index] = (colorIndices[index] + 1) % cardColors.length;
  }
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Entry'),
    Tab(text: 'Stats'),
  ];
}
