import 'dart:async';
import 'dart:convert';
import 'dart:developer';



import 'package:android_intent/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/guestmode/Model/prayerTimesModel.dart';
import 'package:smartmasjid_v1/app/modules/home/Model/prayerTimesModel.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/controllers/login_page_controller.dart';

import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/data/local/my_shared_pref.dart';

import '../../../../utils/ansomeNotification.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../Events/Model/eventsModel.dart';
import '../../imanTracker/model/ImanTrakerEntryModel.dart';
import '../../imanTracker/model/imanTrakerStatusModel.dart';
import '../Model/getUserModel.dart';

class GuestmodeController extends GetxController with GetTickerProviderStateMixin{
  //TODO: Implement HomeController
  final _restCallController = Get.put(restCallController());

  var imanStatusData= ImanTrakerStatusModel().obs;

  late TabController tabController;


  RxBool alarm = false.obs;
  RxBool isloading = false.obs;
  RxBool isLoading=false.obs;
  RxBool isloading1 = false.obs;
  RxBool isloadingEvent = false.obs;
  RxBool isloadingiman = false.obs;
  RxBool isdummy = false.obs;
  RxInt index = 0.obs;
  var getUserData=GetUserModel().obs;
  var guestprayertime=GuestPrayerModel().obs;
  var eventsData= EventsModel().obs;

  var prayerTime =['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  var prayerName =['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
  CarouselController carouselController = CarouselController();

  // var imageBytes=images.obs;
  var currentIndex  = 0.obs;
  void updateIndex(int index) {
    currentIndex.value = index;
  }
  RxString nearestDuration = ''.obs;
  RxString nearestDuration1 = ''.obs;   var rrr="".obs;
  //var uid= Get.arguments[0];
  var uid=FirebaseAuth.instance.currentUser;
  late AnimationController animationController;
  late Animation<double> animation;
  RxBool showFirstImage = true.obs;
  RxBool showSecondImage = true.obs;
  RxBool showThirdImage = true.obs;

  final RxBool isExpanded = false.obs;
  final RxBool status = false.obs;


  void toggleFunction() {
    isExpanded.value = !isExpanded.value; // Toggle the state
  }
  // void openLocationSetting() async {
  //   const AndroidIntent intent = AndroidIntent(
  //     action: 'android.settings.LOCATION_SOURCE_SETTINGS',
  //   );
  //   await intent.launch();
  // }
  //
  // Future<bool> checkLocationEnabled() async {
  //   final AndroidIntent intent = AndroidIntent(
  //     action: 'android.settings.LOCATION_SOURCE_SETTINGS',
  //   );
  //
  //   try {
  //     await intent.launch();
  //     // Location settings were opened, assume location services will be enabled
  //     return true;
  //   } catch (e) {
  //     // Location settings could not be opened, assume location services are disabled
  //     return false;
  //   }
  // }

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
      print("lat ${position.latitude}");
      print("long ${position.longitude}");
      // Update the cityName state variable with the city name
      cityName.value = placemarks.first.locality ?? "Finding city...";
    } catch (e) {
      print("Error: $e");
    }
  }
  var arg=Get.arguments;

  final guesttoken = GetStorage();
  @override
  void onInit() {
    // Create an AnimationController with a duration of 1 second and repeat it in reverse.
    animationController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(seconds: 4),
      reverseDuration: const Duration(seconds: 1),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (showFirstImage.value) {
          showFirstImage.value = false;
          showSecondImage.value = true;
        } else if (showSecondImage.value) {
          showSecondImage.value = false;
          showThirdImage.value = true;
        } else {
          showThirdImage.value = false;
          showFirstImage.value = true;
        }
        animationController.reverse(); // Reverse the animation
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward(); // Start the animation again
      }
    });

// Create a CurvedAnimation that uses the animationController and applies an ease-in curve.
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );

// Start the animation when the controller is first initialized.
    animationController.forward();
    carouselController = CarouselController();
    getPrayerTime();
     if(arg==null&&guesttoken.read('guest')==null){
       return;
     }if(arg!=null){
       guesttoken.write("guest",arg[0]);
       tabController = TabController(length: 1, vsync: this);
       tabController.animation!.addListener(
             () {
           final value =  tabController.animation!.value.round();
           // if (value != currentPage && mounted) {
           //   changePage(value);
           // }
         },
       );
       fetchCityName();
       return;
     }if(guesttoken.read('guest')!=null){
       tabController = TabController(length: 1, vsync: this);
       tabController.animation!.addListener(
             () {
           final value =  tabController.animation!.value.round();
           // if (value != currentPage && mounted) {
           //   changePage(value);
           // }
         },
       );
       fetchCityName();
       return;
     }
    super.onInit();


  }

  @override
  void onReady() {

    super.onReady();
  }

  @override
  void onClose() {
    // Dispose of the animation controller when it's no longer needed to avoid memory leaks.
    animationController.dispose();
    timer!.cancel();

    super.onClose();
  }

  @override
  void dispose() {
    tabController.dispose();

    timer!.cancel();


    super.dispose();
  }


  Rx<int> notificationsCounter = 0.obs;
  // when user click on action button
  Rx<String> notificationAction = ''.obs;

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
    var targetDateTime = DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();

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

    var targetDateTime=DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();


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
      var targetDateTime=DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();
      var targetDateTime1=DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();
      var targetDateTime2=DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();
      var targetDateTime3=DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();
      var targetDateTime4=DateTime.parse("${guestprayertime.value.getPrayerTimeGuest!.prayer}").toLocal();
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

  getPrayerTime() async {

    isloading1.value=true;
    var header="""
query Get_Prayer_Time_guest(\$latitude: String, \$longitude: String) {
  Get_Prayer_Time_guest(latitude: \$latitude, longitude: \$longitude) {
    prayer
    city
    current_date
    today_hijri_date
  }
}
    """;
    var body ={
      //"masjidId": "a4fee385-0641-4dce-bd42-f35ee278ce35"
      "latitude": "11.9507308",
      "longitude": "79.8309292"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading1.value=false;

    guestprayertime.value=guestPrayerModelFromJson(json.encode(res));
    //remainTime();
    // log("times");
    log("ggggg${json.encode(res)}");
    update();
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
