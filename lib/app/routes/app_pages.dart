import 'package:get/get.dart';

import '../modules/faceAuth/bindings/face_auth_binding.dart';
import '../modules/faceAuth/views/face_auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language_page/bindings/language_page_binding.dart';
import '../modules/language_page/views/language_page_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/masjidFinder/bindings/masjid_finder_binding.dart';
import '../modules/masjidFinder/views/masjid_finder_view.dart';
import '../modules/otp_page/bindings/otp_page_binding.dart';
import '../modules/otp_page/views/otp_page_view.dart';
import '../modules/register_login/bindings/register_login_binding.dart';
import '../modules/register_login/views/register_login_view.dart';
import '../modules/requestMasjid/bindings/request_masjid_binding.dart';
import '../modules/requestMasjid/views/request_masjid_view.dart';
import '../modules/signup_page/bindings/signup_page_binding.dart';
import '../modules/signup_page/views/signup_page_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.cupertino,
        transitionDuration: Duration(seconds: 2)),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE_PAGE,
      page: () => const LanguagePageView(),
      binding: LanguagePageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_LOGIN,
      page: () => const RegisterLoginView(),
      binding: RegisterLoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_PAGE,
      page: () => SignupPageView(),
      binding: SignupPageBinding(),

      //arguments: []
    ),
    GetPage(
      name: _Paths.FACE_AUTH,
      page: () => const FaceAuthView(),
      binding: FaceAuthBinding(),
    ),
    GetPage(
      name: _Paths.OTP_PAGE,
      page: () =>  OtpPageView(),
      binding: OtpPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.MASJID_FINDER,
      page: () => MasjidFinderView(),
      binding: MasjidFinderBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_MASJID,
      page: () => const RequestMasjidView(),
      binding: RequestMasjidBinding(),
    ),
  ];
}
