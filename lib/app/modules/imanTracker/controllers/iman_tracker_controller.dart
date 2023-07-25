import 'package:get/get.dart';

import '../../../routes/export.dart';

class ImanTrackerController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement ImanTrackerController

  late TabController tabctrl;

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

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Entry'),
    Tab(text: 'Stats'),
  ];
}
