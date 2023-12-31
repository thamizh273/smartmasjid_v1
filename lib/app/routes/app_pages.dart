import 'package:get/get.dart';

import '../modules/Events/bindings/events_binding.dart';
import '../modules/Events/views/events_view.dart';
import '../modules/activitiespage/bindings/activitiespage_binding.dart';
import '../modules/activitiespage/views/activitiespage_view.dart';
import '../modules/addweather/bindings/addweather_binding.dart';
import '../modules/addweather/views/addweather_view.dart';
import '../modules/archivepage/bindings/archivepage_binding.dart';
import '../modules/archivepage/views/archivepage_view.dart';
import '../modules/audioplayer/bindings/audioplayer_binding.dart';
import '../modules/audioplayer/views/audioplayer_view.dart';
import '../modules/bookmarkpage/bindings/bookmarkpage_binding.dart';
import '../modules/bookmarkpage/views/bookmarkpage_view.dart';
import '../modules/donationpage/bindings/donationpage_binding.dart';
import '../modules/donationpage/views/donationpage_view.dart';
import '../modules/duapage/bindings/duapage_binding.dart';
import '../modules/duapage/views/duapage_view.dart';
import '../modules/faceAuth/bindings/face_auth_binding.dart';
import '../modules/faceAuth/views/face_auth_view.dart';
import '../modules/familytree/bindings/familytree_binding.dart';
import '../modules/familytree/views/familytree_view.dart';
import '../modules/guestmode/bindings/guestmode_binding.dart';
import '../modules/guestmode/views/guestmode_view.dart';
import '../modules/hadithchapterdetail/bindings/hadithchapterdetail_binding.dart';
import '../modules/hadithchapterdetail/views/hadithchapterdetail_view.dart';
import '../modules/hijripage/bindings/hijripage_binding.dart';
import '../modules/hijripage/views/hijripage_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/imanTracker/bindings/iman_tracker_binding.dart';
import '../modules/imanTracker/views/iman_tracker_view.dart';
import '../modules/inheritance/bindings/inheritance_binding.dart';
import '../modules/inheritance/views/inheritance_view.dart';
import '../modules/inheritanceResult/bindings/inheritance_result_binding.dart';
import '../modules/inheritanceResult/views/inheritance_result_view.dart';
import '../modules/language_page/bindings/language_page_binding.dart';
import '../modules/language_page/views/language_page_view.dart';
import '../modules/librarypage/bindings/librarypage_binding.dart';
import '../modules/librarypage/views/librarypage_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/masjidFinder/bindings/masjid_finder_binding.dart';
import '../modules/masjidFinder/views/masjid_finder_view.dart';
import '../modules/masjidRequest/bindings/masjid_request_binding.dart';
import '../modules/masjidRequest/views/masjid_request_view.dart';
import '../modules/masjidhistory/bindings/masjidhistory_binding.dart';
import '../modules/masjidhistory/views/masjidhistory_view.dart';
import '../modules/masjidnearme/bindings/masjidnearme_binding.dart';
import '../modules/masjidnearme/views/masjidnearme_view.dart';
import '../modules/mediapage/bindings/mediapage_binding.dart';
import '../modules/mediapage/views/mediapage_view.dart';
import '../modules/membership/bindings/membership_binding.dart';
import '../modules/membership/views/membership_view.dart';
import '../modules/messagepage/bindings/messagepage_binding.dart';
import '../modules/messagepage/views/messagepage_view.dart';
import '../modules/mymasjidpage/bindings/mymasjidpage_binding.dart';
import '../modules/mymasjidpage/views/mymasjidpage_view.dart';
import '../modules/notificationpage/bindings/notificationpage_binding.dart';
import '../modules/notificationpage/views/notificationpage_view.dart';
import '../modules/otp_page/bindings/otp_page_binding.dart';
import '../modules/otp_page/views/otp_page_view.dart';
import '../modules/prayerdetailspage/bindings/prayerdetailspage_binding.dart';
import '../modules/prayerdetailspage/views/prayerdetailspage_view.dart';
import '../modules/prayerpage/bindings/prayerpage_binding.dart';
import '../modules/prayerpage/views/prayerpage_view.dart';
import '../modules/profilePage/bindings/profile_page_binding.dart';
import '../modules/profilePage/views/edit_profile_view.dart';
import '../modules/profilePage/views/profile_page_view.dart';
import '../modules/qiblafinderpage/bindings/qiblafinderpage_binding.dart';
import '../modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import '../modules/quranpage/bindings/quranpage_binding.dart';
import '../modules/quranpage/views/quranpage_view.dart';
import '../modules/register_login/bindings/register_login_binding.dart';
import '../modules/register_login/views/register_login_view.dart';
import '../modules/servicepage/bindings/servicepage_binding.dart';
import '../modules/servicepage/views/servicepage_view.dart';
import '../modules/settingspage/bindings/settingspage_binding.dart';
import '../modules/settingspage/views/settingspage_view.dart';
import '../modules/signup_page/bindings/signup_page_binding.dart';
import '../modules/signup_page/views/signup_page_view.dart';
import '../modules/sliderdot/bindings/sliderdot_binding.dart';
import '../modules/sliderdot/views/sliderdot_view.dart';
import '../modules/specialdayspage/bindings/specialdayspage_binding.dart';
import '../modules/specialdayspage/views/specialdayspage_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';
import '../modules/weatherpage/bindings/weatherpage_binding.dart';
import '../modules/weatherpage/views/weatherdetail_view.dart';
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
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE_PAGE,
      page: () => LanguagePageView(),
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
      page: () => OtpPageView(),
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
      page: () => ZakathpageView(),
      binding: ZakathpageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONPAGE,
      page: () => NotificationpageView(),
      binding: NotificationpageBinding(),
    ),
    GetPage(
      name: _Paths.WEATHERPAGE,
      page: () => WeatherpageView(),
      binding: WeatherpageBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGEPAGE,
      page: () => MessagepageView(),
      binding: MessagepageBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGSPAGE,
      page: () => SettingspageView(),
      binding: SettingspageBinding(),
    ),
    GetPage(
      name: _Paths.QURANPAGE,
      page: () => QuranpageView(),
      binding: QuranpageBinding(),
    ),
    GetPage(
      name: _Paths.QIBLAFINDERPAGE,
      page: () => const QiblaFinder(),
      binding: QiblafinderpageBinding(),
    ),
    GetPage(
      name: _Paths.PRAYERPAGE,
      page: () => PrayerpageView(),
      binding: PrayerpageBinding(),
    ),
    GetPage(
      name: _Paths.SPECIALDAYSPAGE,
      page: () => SpecialdayspageView(),
      binding: SpecialdayspageBinding(),
    ),
    GetPage(
      name: _Paths.HIJRIPAGE,
      page: () => const HijripageView(),
      binding: HijripageBinding(),
    ),
    GetPage(
      name: _Paths.ARCHIVEPAGE,
      page: () => const ArchivepageView(),
      binding: ArchivepageBinding(),
    ),
    // GetPage(
    //   name: _Paths.WEATHERLOCATION,
    //   page: () =>  WeatherlocationView(),
    //   binding: WeatherlocationBinding(),
    // ),
    GetPage(
      name: _Paths.ADDWEATHER,
      page: () => AddweatherView(),
      binding: AddweatherBinding(),
    ),
    GetPage(
      name: _Paths.SLIDERDOT,
      page: () => SliderdotView(true),
      binding: SliderdotBinding(),
    ),
    GetPage(
      name: _Paths.PRAYERDETAILSPAGE,
      page: () => PrayerdetailspageView(),
      binding: PrayerdetailspageBinding(),
    ),
    GetPage(
      name: _Paths.MASJID_REQUEST,
      page: () => MasjidRequestView(),
      binding: MasjidRequestBinding(),
    ),
    GetPage(
      name: _Paths.MASJIDHISTORY,
      page: () => MasjidhistoryView(),
      binding: MasjidhistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.AUDIOPLAYER,
      page: () => AudioPlayerScreen(),
      binding: AudioplayerBinding(),
    ),
    GetPage(
      name: _Paths.IMAN_TRACKER,
      page: () => ImanTrackerView(),
      binding: ImanTrackerBinding(),
    ),
    GetPage(
      name: _Paths.DUAPAGE,
      page: () => DuapageView(),
      binding: DuapageBinding(),
    ),
    GetPage(
      name: _Paths.HADITHCHAPTERDETAIL,
      page: () => HadithchapterdetailView(),
      binding: HadithchapterdetailBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => EditProfileView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.MEMBERSHIP,
      page: () => MembershipView(),
      binding: MembershipBinding(),
    ),
    GetPage(
      name: _Paths.EVENTS,
      page: () => EventsView(),
      binding: EventsBinding(),
    ),
    GetPage(
      name: _Paths.DONATIONPAGE,
      page: () => DonationpageView(),
      binding: DonationpageBinding(),
    ),
    GetPage(
      name: _Paths.MYMASJIDPAGE,
      page: () => const MymasjidpageView(),
      binding: MymasjidpageBinding(),
    ),
    GetPage(
      name: _Paths.SERVICEPAGE,
      page: () => const ServicepageView(),
      binding: ServicepageBinding(),
    ),
    GetPage(
      name: _Paths.LIBRARYPAGE,
      page: () => const LibrarypageView(),
      binding: LibrarypageBinding(),
    ),
    GetPage(
      name: _Paths.MASJIDNEARME,
      page: () => const MasjidnearmeView(),
      binding: MasjidnearmeBinding(),
    ),
    GetPage(
      name: _Paths.MEDIAPAGE,
      page: () => const MediapageView(),
      binding: MediapageBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARKPAGE,
      page: () => const BookmarkpageView(),
      binding: BookmarkpageBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITIESPAGE,
      page: () => ActivitiespageView(),
      binding: ActivitiespageBinding(),
    ),
    GetPage(
      name: _Paths.FAMILYTREE,
      page: () => const FamilytreeView(),
      binding: FamilytreeBinding(),
    ),
    GetPage(
      name: _Paths.GUESTMODE,
      page: () => GuestmodeView(),
      binding: GuestmodeBinding(),
    ),
    GetPage(
      name: _Paths.INHERITANCE,
      page: () => InheritanceView(),
      binding: InheritanceBinding(),
    ),
    GetPage(
      name: _Paths.INHERITANCE_RESULT,
      page: () => const InheritanceResultView(),
      binding: InheritanceResultBinding(),
    ),
  ];
}
