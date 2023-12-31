import 'dart:async';
import 'dart:convert';
import 'dart:developer';



import 'package:android_intent/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_actions_android/quick_actions_android.dart';


import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/home/Model/prayerTimesModel.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/views/iman_tracker_view.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/controllers/login_page_controller.dart';
import 'package:smartmasjid_v1/app/modules/masjidnearme/views/masjidnearme_view.dart';
import 'package:smartmasjid_v1/app/modules/qiblafinderpage/views/qiblafinderpage_view.dart';

import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/data/local/my_shared_pref.dart';

import '../../../../utils/ansomeNotification.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/app_pages.dart';
import '../../Events/Model/eventsModel.dart';
import '../../imanTracker/model/ImanTrakerEntryModel.dart';
import '../../imanTracker/model/imanTrakerStatusModel.dart';
import '../../masjidnearme/helper/custom_marker_info_window.dart';
import '../Model/getUserModel.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement HomeController
  final _restCallController = Get.put(restCallController());
  final _authCtrl = Get.put(AuthenticationRespository());
  final _la = Get.put(LoginPageController());

  var imanStatusData= ImanTrakerStatusModel().obs;

  late TabController tabController;



  RxBool alarm = false.obs;
  RxBool isloading = false.obs;
  RxBool isloading1 = false.obs;
  RxBool isloadingEvent = false.obs;
  RxBool isloadingiman = false.obs;
  RxBool isdummy = false.obs;
  var getUserData=GetUserModel().obs;
  var prayerTimeData=PrayerTimeModel().obs;
  var eventsData= EventsModel().obs;
  final shortcut = 'no action set'.obs;

  var prayerTime =['fajr', 'dhuhr', 'asr', 'magrib', 'isha'];
     // var imageBytes=images.obs;
  var currentIndex  = 0.obs;
  void updateIndex(int index) {
    currentIndex.value = index;
  }
  RxString nearestDuration = ''.obs;
  RxString nearestDuration1 = ''.obs;   var rrr="".obs;
 //var uid= Get.arguments[0];
  var uid=FirebaseAuth.instance.currentUser;
   var hh=Get.arguments;

  final box1 = GetStorage();
  final RxBool isExpanded = false.obs;
  final RxBool status = false.obs;
  late PageController pageController;
  RxInt activePageIndex = 0.obs;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  void toggleFunction() {
    isExpanded.value = !isExpanded.value; // Toggle the state
  }


  List timeList=["0","0","0","0","0"].obs ;

  Timer? timer;

  final cityName = "Finding city...".obs;

  // Function to fetch the city name using geolocation
  Future<void> fetchCityName() async {
    try {
      // Get the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Use reverse geocoding to get the city name from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print("cdcdcd${position.latitude}");
      // Update the cityName state variable with the city name
      cityName.value = placemarks.first.locality ?? "Finding city...";
    } catch (e) {
      print("Error: $e");
    }
  }
  @override
  void onInit() {



   if(hh==null&&box1.read('fruits')==null){
    return;
   }



   if(hh !=null){
     box1.write("fruits",hh[0]);
     box1.write("masjidId",hh[1]);
     box1.write("token",hh[2]);
     // box1.write("logoutlogin",false);
     getUserDetails(hh[0],hh[2]);
     getPrayerTime(hh[1]);
     getUpcomingEvents(hh[1]);

   }
   if(  box1.read('fruits')!=null){
     getUserDetails( box1.read('fruits'),box1.read('token'));
     getPrayerTime( box1.read('masjidId'));
     getUpcomingEvents(box1.read('masjidId'));

   }

   // if(FirebaseAuth.instance.currentUser!=null){
   //
   //   getUserDetails("",FirebaseAuth.instance.currentUser!.uid);
   // }
  // var ggg=box1.read('fruits')==null?hh[0]: box1.read('fruits');

 //  getUserDetails(Get.arguments[0]);
  // getUserDetails("5b52cef8-1c88-48ac-bd76-a092cd5ad200");
   // getPrayerTime();

    tabController = TabController(length: 1, vsync: this);
    tabController.animation!.addListener(
          () {
        // if (value != currentPage && mounted) {
        //   changePage(value);
        // }
      },
    );
    super.onInit();
   pageController = PageController();
   fetchCityName();
   final QuickActionsAndroid quickActions = QuickActionsAndroid();
   quickActions.initialize((String shortcutType) {
     shortcut.value = '$shortcutType has launched';
   });
   quickActions.setShortcutItems(<ShortcutItem>[
     const ShortcutItem(
       type: 'qibla_finder',
       localizedTitle: 'Qibla Finder',
       icon: 'qibla',
     ),
     const ShortcutItem(
       type: 'masjid_near_me',
       localizedTitle: 'Masjid Near Me',
       icon: 'masjid',
     ),
     const ShortcutItem(
       type: 'iman_tracker',
       localizedTitle: 'Iman Tracker',
       icon: 'iman',
     ),
   ]);
   quickActions.initialize((type) {
     if (type == "qibla_finder"){
       Get.to(QiblaFinder());
     }
     else if (type == "masjid_near_me"){
       Get.to(CustomMarketInfoWindow());
     }
     else if (type == "iman_tracker"){
       Get.toNamed(Routes.IMAN_TRACKER);
     }
   });
  }


  Future<void> refreshData() async {
    // Simulating an API request or data refresh
    await  Future.delayed(const Duration(seconds: 2));
    if(hh==null&&box1.read('fruits')==null){
      return;
    }

      getUserDetails( box1.read('fruits'),box1.read('token'));
      getPrayerTime( box1.read('masjidId'));
      getUpcomingEvents(box1.read('masjidId'));

  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();

      timer!.cancel();

    super.onClose();
  }

  @override
  void dispose() {
    pageController.dispose();
    tabController.dispose();

    timer!.cancel();


    super.dispose();
  }

  void onInfo() {
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void onFalicilities() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  void onGallery() {
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  void onRenovation() {
    pageController.animateToPage(3,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  void onProperties() {
    pageController.animateToPage(4,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  void onBoardMembers() {
    pageController.animateToPage(5,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
  void onMaqbara() {
    pageController.animateToPage(6,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }


  Rx<int> notificationsCounter = 0.obs;
  // when user click on action button
  Rx<String> notificationAction = ''.obs;
  ScrollController scrollController = ScrollController();

  incrementCounter() {
    notificationsCounter.value += 1;
  }

  decrementCounter() {
    notificationsCounter.value -= 1;
  }

  onNotificationActionClicked(String actionKey){
    notificationAction.value = actionKey;
  }
  getUpcomingEvents(id) async {

    isloadingEvent.value=true;
    var header="""
query Query(\$masjidId: ID!) {
  Get_Masjid_Events_(masjid_id: \$masjidId) {
    image
    id
    area
    start_time
    end_time
    masjid_id {
      masjid_name
    }
    title
    description
  }
}
    """;
    var body ={
      "masjidId": "$id"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloadingEvent.value=false;

    eventsData.value=eventsModelFromJson(json.encode(res));
    // print("getevent");
    // log(json.encode(res));
    // print("getevent");

  }
  getImanTrakerStatus(id) async {
print("dfdf $id");
    isloadingiman.value=true;
    var header="""
query Query(\$userId: ID!, \$trackerType: String, \$status: String) {
  Get_Iman_Tracker_Status(user_id_: \$userId, tracker_type: \$trackerType, status_: \$status) {
    status {
      injamaah
      late
      notprayed
      ontime
      total_percent
    }
    tracker_name
  }
}
    """;
    var body ={
      "userId": "$id",
      "trackerType": "prayertracker",
      "status": "week"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloadingiman.value=false;

    imanStatusData.value=imanTrakerStatusModelFromJson(json.encode(res));
    // print("getstatus");
    // log(json.encode(res));
    // print("getstaus");

  }
  prayerDetailRT(index){

      DateTime now = DateTime.now();

      // Target date and time
      var targetDateTime = DateTime.parse("${prayerTimeData.value
          .getTodayMasjidPrayerTime!
          .todayPrayerList![index]
          .startTime}").toLocal();

      // Calculate the remaining duration
      Duration remainingDuration = targetDateTime.difference(now);
      var remainingHours = remainingDuration.inHours;
      int remainingMinutes = remainingDuration.inMinutes.remainder(60);
      var timer="${remainingDuration.inHours}hrs ${remainingDuration.inMinutes.remainder(60)}min";
      return timer;
  }


  remainTime(){



    // Target date and time
    DateTime now = DateTime.now();

    var targetDateTime=DateTime.parse("${prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![0].startTime}").toLocal();


    // Calculate the remaining duration
    Duration remainingDuration = targetDateTime.difference(now);



    if (remainingDuration.isNegative) {
      // Target time is in the past
      nearestDuration.value = 'Target time already passed';
    } else {
      nearestDuration.value = now.millisecondsSinceEpoch.toString();
      nearestDuration1.value = targetDateTime.millisecondsSinceEpoch.toString();
     // print("ggggg");
    }
    timer= Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      final outputFormat = DateFormat("HH:mm:ss");
      var targetDateTime=DateTime.parse("${prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![0].startTime}").toLocal();
      var targetDateTime1=DateTime.parse("${prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![1].startTime}").toLocal();
      var targetDateTime2=DateTime.parse("${prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![2].startTime}").toLocal();
      var targetDateTime3=DateTime.parse("${prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![3].startTime}").toLocal();
      var targetDateTime4=DateTime.parse("${prayerTimeData.value.getTodayMasjidPrayerTime!.todayPrayerList![4].startTime}").toLocal();
      var remainingDuration = outputFormat.format(DateTime(0).add(targetDateTime.difference(now)));
      var remainingDuration1 = outputFormat.format(DateTime(0).add(targetDateTime1.difference(now)));
      var remainingDuration2 = outputFormat.format(DateTime(0).add(targetDateTime2.difference(now)));
      var remainingDuration3 = outputFormat.format(DateTime(0).add(targetDateTime3.difference(now)));
      var remainingDuration4 = outputFormat.format(DateTime(0).add(targetDateTime4.difference(now)));

      timeList[0]=remainingDuration;
      timeList[1]=remainingDuration1;
      timeList[2]=remainingDuration2;
      timeList[3]=remainingDuration3;
      timeList[4]=remainingDuration4;
      // log("w ${timeList[0]}");
      // log("r ${timeList[1]}");
      // log("s ${timeList[2]}");



     //  var hrs1=remainingDuration.inHours;
     //  var  min1=remainingDuration.inMinutes.remainder(60) ;
     //  var  sec1=remainingDuration.inSeconds.remainder(60);
     // // log("ggggg ${timeList}");
     //  print("hrs ${hrs1}");
     //  print("min ${min1}");
     //  print("sec ${sec1}");
    });


    // Extract the remaining hours and minutes


    return  ;
  }



  getUserDetails(passwordlogin, tokenid) async {
    //final user =FirebaseAuth.instance.currentUser==null ?"":FirebaseAuth.instance.currentUser!.uid;
    // var jjj = box1.read('fruits');
   // print('Stored list: $jjj');
    isloading.value=true;


    print("hhhhh $passwordlogin");
    print("hhhhh ${MySharedPref.getFcmToken()}");
    print("hhhhh $tokenid");
    var header="""
query Query(\$id: String, \$authId: String,\$deviceId: String,\$token: String!) {
  Get_User_By_Id(id_: \$id, auth_id_: \$authId,device_id: \$deviceId,token: \$token) {
        id
    profile_image
    auth_uid
    dob
    email_id
    first_name
    language
    last_name
    live_status
    masjid_id {
      id
      masjid_name
      state
      area
      about
      district
      address
    }
    member_status
    phone_number
    post
    user_type
    address {
      address_type
      area
      country
      district
      door_no
      masjid_id
      pincode
      state
      street_name
      user_id
      user_type
      id
    }
    user_unique_id
  }
}
    """;
    var body ={
      "id": "${passwordlogin}",
      "deviceId": "${MySharedPref.getFcmToken()}",
      "token": "${tokenid}",
     // "authId": "$glogin"
     // "id": "$k"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;
    print("getUser");
    log(json.encode(res));
    print("getUser");

   getUserData.value=getUserModelFromJson(json.encode(res));
    getImanTrakerStatus(passwordlogin);

  }
  getPrayerTime(d) async {

    isloading1.value=true;
    var header="""
query Query(\$masjidId: String) {
  Get_Today_Masjid_Prayer_Time(masjid_id_: \$masjidId) {
    today_prayer_list {
      end_time
      id
      image
      masjid_id
      notification
      prayer_name
      prayer_status
      start_time
    }
    today_hijri_date
  }
}
    """;
    var body ={
      //"masjidId": "a4fee385-0641-4dce-bd42-f35ee278ce35"
      "masjidId": "$d"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading1.value=false;

    prayerTimeData.value=prayerTimeModelFromJson(json.encode(res));
    remainTime();
   // log("times");
   // log(json.encode(res));
   //  log("times");
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }


}
