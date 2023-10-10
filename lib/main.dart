import  'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:quick_actions_android/quick_actions_android.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/views/iman_tracker_view.dart';
import 'package:smartmasjid_v1/app/modules/masjidnearme/views/masjidnearme_view.dart';
import 'package:smartmasjid_v1/utils/ansomeNotification.dart';
import 'package:smartmasjid_v1/utils/fcm_notification/fcm_helper.dart';
import 'package:smartmasjid_v1/utils/fcm_notification/local_notification_helper.dart';

import 'package:smartmasjid_v1/utils/localization/localization.dart';

import 'app/authRepository.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/export.dart';
import 'data/local/my_shared_pref.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Hive.initFlutter();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then((value) => Get.put(AuthenticationRespository()));
  await initHiveForFlutter();
  await AwesomeNotificationsHelper.init();
  await MySharedPref.init();
  await FcmHelper.initFcm();
  LocalNotificationHelper.initializeNotifications();

  // HomeController().get_user("92owFV2zwZfyKnIJdcTEopBkLHE3");
  final WebSocketLink websocketLink = WebSocketLink(
    'wss://smasjidgraphqlserver-3gw3zjicpa-uc.a.run.app/smasjid',
   // 'wss://192.168.29.234:4000/ecomql',

    config: const SocketClientConfig(
        autoReconnect: true, inactivityTimeout: Duration(minutes: 10)),
  );
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: websocketLink,
      cache: GraphQLCache(),
    ),
  );
  final Localization localization = Localization();

  Locale initialLocale = localization.getPreferredLocale() ?? Locale('en', 'US');
  Get.put<Localization>(Localization());

  runApp(
    OverlaySupport(
      child: ScreenUtilInit(
          builder: (BuildContext context, Widget? child) {
          return GraphQLProvider(
            client: client,
            child: GetMaterialApp(

            //  navigatorObservers: [FlutterSmartDialog.observer],
           //   builder: FlutterSmartDialog.init(),
            //  initialBinding: HomeBinding(),
              debugShowCheckedModeBanner: false,
              initialBinding: HomeBinding(),
              translations: localization,
              fallbackLocale: const Locale('en', 'US'),
              locale: initialLocale,
              title: "Application",
              theme: ThemeService().lightTheme,
               defaultTransition:Transition.cupertinoDialog,
              darkTheme: ThemeService().darkTheme,
              themeMode: ThemeService().getThemeMode(),
              initialRoute:AppPages.INITIAL,
              getPages: AppPages.routes,
                builder:(context,child){
                  return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!);
                }

            ),
          );
        }
      ),
    ),
  );
}

class ShotcutApp extends StatefulWidget {
  const ShotcutApp({super.key});

  @override
  State<ShotcutApp> createState() => _MyShotcutAppState();
}

class _MyShotcutAppState extends State<ShotcutApp> {
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();

    final QuickActionsAndroid quickActions = QuickActionsAndroid();
    quickActions.initialize((String shortcutType) {
      setState(() {
        shortcut = '$shortcutType has launched';
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'qibla_finder',
        localizedTitle: 'Qibla Finder',
        //icon: 'AppIcon',
      ),
      const ShortcutItem(
        type: 'masjid_near_me',
        localizedTitle: 'Masjid Near Me',
        //icon: 'ic_launcher'
      ),
      const ShortcutItem(
        type: 'iman_tracker',
        localizedTitle: 'Iman Tracker',
        //icon: 'ic_launcher'
      ),
    ]);

    quickActions.initialize((type) {
      if(type == "qibla_finder") {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => QiblaFinder()));
      }
      else if(type == "masjid_near_me") {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MasjidnearmeView()));
      }
      else if(type == "iman_tracker") {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ImanTrackerView()));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shortcut),
      ),
      body: const Center(
        child: Text('On home screen, long press the app icon to '
            'get Action one or Action two options. Tapping on that action should  '
            'set the toolbar title.'),
      ),
    );
  }
}

