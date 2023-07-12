import 'package:get/get.dart';

import '../modules/faceAuth/bindings/face_auth_binding.dart';
import '../modules/faceAuth/views/face_auth_view.dart';
import '../modules/hijripage/bindings/hijripage_binding.dart';
import '../modules/hijripage/views/hijripage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language_page/bindings/language_page_binding.dart';
import '../modules/language_page/views/language_page_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/masjidFinder/bindings/masjid_finder_binding.dart';
import '../modules/masjidFinder/views/masjid_finder_view.dart';
import '../modules/messagepage/bindings/messagepage_binding.dart';
import '../modules/messagepage/views/messagepage_view.dart';
import '../modules/notificationpage/bindings/notificationpage_binding.dart';
import '../modules/notificationpage/views/notificationpage_view.dart';
import '../modules/otp_page/bindings/otp_page_binding.dart';
import '../modules/otp_page/views/otp_page_view.dart';
import '../modules/prayerpage/bindings/prayerpage_binding.dart';
import '../modules/prayerpage/views/prayerpage_view.dart';
import '../modules/prayertimes/bindings/prayertimes_binding.dart';
import '../modules/prayertimes/views/prayertimes_view.dart';
import '../modules/qiblafinderpage/bindings/qiblafinderpage_binding.dart';
import '../modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import '../modules/quranpage/bindings/quranpage_binding.dart';
import '../modules/quranpage/views/quranpage_view.dart';
import '../modules/register_login/bindings/register_login_binding.dart';
import '../modules/register_login/views/register_login_view.dart';
import '../modules/settingspage/bindings/settingspage_binding.dart';
import '../modules/settingspage/views/settingspage_view.dart';
import '../modules/signup_page/bindings/signup_page_binding.dart';
import '../modules/signup_page/views/signup_page_view.dart';
import '../modules/specialdayspage/bindings/specialdayspage_binding.dart';
import '../modules/specialdayspage/views/specialdayspage_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/weatherpage/bindings/weatherpage_binding.dart';
import '../modules/weatherpage/views/weatherpage_view.dart';
import '../modules/zakathpage/bindings/zakathpage_binding.dart';
import '../modules/zakathpage/views/zakathpage_view.dart';

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
      name: _Paths.ZAKATHPAGE,
      page: () => const ZakathpageView(),
      binding: ZakathpageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONPAGE,
      page: () => const NotificationpageView(),
      binding: NotificationpageBinding(),
    ),
    GetPage(
      name: _Paths.WEATHERPAGE,
      page: () => const WeatherpageView(),
      binding: WeatherpageBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGEPAGE,
      page: () => const MessagepageView(),
      binding: MessagepageBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGSPAGE,
      page: () => const SettingspageView(),
      binding: SettingspageBinding(),
    ),
    GetPage(
      name: _Paths.PRAYERTIMES,
      page: () =>  PrayertimesView(),
      binding: PrayertimesBinding(),
    ),
    GetPage(
      name: _Paths.QURANPAGE,
      page: () => const QuranpageView(),
      binding: QuranpageBinding(),
    ),
    GetPage(
      name: _Paths.QIBLAFINDERPAGE,
      page: () => const QiblafinderpageView(),
      binding: QiblafinderpageBinding(),
    ),
    GetPage(
      name: _Paths.PRAYERPAGE,
      page: () =>  PrayerpageView(),
      binding: PrayerpageBinding(),
    ),
    GetPage(
      name: _Paths.SPECIALDAYSPAGE,
      page: () => const SpecialdayspageView(),
      binding: SpecialdayspageBinding(),
    ),
    GetPage(
      name: _Paths.HIJRIPAGE,
      page: () => const HijripageView(),
      binding: HijripageBinding(),
    ),
  ];
}
