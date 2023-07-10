import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../routes/export.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {

    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 300).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offNamedUntil(Routes.LANGUAGE_PAGE, (_) => false);
      }
    });

    animationController.forward();
  }


  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {

    animationController.dispose();

    super.onClose();
  }


}
