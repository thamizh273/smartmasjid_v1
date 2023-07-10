import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement HomeController
  late TabController tabController;
  RxInt currentPage=0.obs;
  RxBool alarm = false.obs;
  @override
  void onInit() {

    tabController = TabController(length: 1, vsync: this);
    tabController.animation!.addListener(
          () {
        final value =  tabController.animation!.value.round();
        // if (value != currentPage && mounted) {
        //   changePage(value);
        // }
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // void increment() => count.value++;
}
