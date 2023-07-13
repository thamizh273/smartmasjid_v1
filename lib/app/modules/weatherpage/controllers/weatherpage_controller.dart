import 'package:get/get.dart';

class WeatherpageController extends GetxController {
  //TODO: Implement WeatherpageController

  final count = 0.obs;
  RxInt _currentPage = 0.obs;
  int currentPage = 0;
  late String bgImg;
  _onPageChanged(int index){
    currentPage = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
