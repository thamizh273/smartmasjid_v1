import 'package:get/get.dart';

import '../controllers/register_login_controller.dart';

class RegisterLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterLoginController>(
      () => RegisterLoginController(),
    );
  }
}
