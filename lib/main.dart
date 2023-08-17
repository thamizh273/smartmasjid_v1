


import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smartmasjid_v1/utils/ansomeNotification.dart';

import 'package:smartmasjid_v1/utils/localization/localization.dart';

import 'app/authRepository.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/export.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRespository()));
  await initHiveForFlutter();
  await AwesomeNotificationsHelper.init();

  // HomeController().get_user("92owFV2zwZfyKnIJdcTEopBkLHE3");
  final WebSocketLink websocketLink = WebSocketLink(
    'wss://smasjidgraphqlserver-3gw3zjicpa-uc.a.run.app/smasjidql',
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
    ScreenUtilInit(
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
  );
}
