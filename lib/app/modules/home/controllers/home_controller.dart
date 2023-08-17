import 'dart:convert';
import 'dart:developer';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';


import 'package:smartmasjid_v1/app/authRepository.dart';
import 'package:smartmasjid_v1/app/modules/home/Model/prayerTimesModel.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/controllers/login_page_controller.dart';

import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../Events/Model/eventsModel.dart';
import '../../imanTracker/model/ImanTrakerEntryModel.dart';
import '../../imanTracker/model/imanTrakerStatusModel.dart';
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
  var getUserData=GetUserModel().obs;
  var prayerTimeData=PrayerTimeModel().obs;
  var eventsData= EventsModel().obs;

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


  @override
  void onInit() {


   if(hh==null&&box1.read('fruits')==null){
    return;
   }
   if(hh !=null){
     box1.write("fruits",hh[0]);
     box1.write("masjidId",hh[1]);
     getUserDetails(hh[0],);
     getPrayerTime(hh[1]);
     getUpcomingEvents(hh[1]);

   }
   if(  box1.read('fruits')!=null){
     getUserDetails( box1.read('fruits'));
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
        final value =  tabController.animation!.value.round();
        // if (value != currentPage && mounted) {
        //   changePage(value);
        // }
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
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
    print("getevent");
    log(json.encode(res));
    print("getevent");

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
    print("getstatus");
    log(json.encode(res));
    print("getstaus");

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
    DateTime now = DateTime.now();



    // Target date and time
    var targetDateTime = DateTime.parse("${rrr.value}").toLocal();

    // Calculate the remaining duration
    Duration remainingDuration = targetDateTime.difference(now);


    if (remainingDuration.isNegative) {
      // Target time is in the past
      nearestDuration.value = 'Target time already passed';
    } else {
      nearestDuration.value = now.millisecondsSinceEpoch.toString();
      nearestDuration1.value = targetDateTime.millisecondsSinceEpoch.toString();



      print("ggggg");

    }

    print(remainingDuration);
    // Extract the remaining hours and minutes
    var remainingHours = remainingDuration.inHours;
    int remainingMinutes = remainingDuration.inMinutes.remainder(60);
    var sss= "${remainingHours} Hrs :${remainingMinutes} min";
    // print(sss);
    // print("ggg");
    // // Output the result
    // print("Remaining time: $remainingHours hours and $remainingMinutes minutes");

    // var ss= DateTime.now().millisecondsSinceEpoch.obs - DateTime.parse("${prayerpageData.value.getMasjidPrayerTimeFilter![0].startTime}").toLocal().microsecondsSinceEpoch;
    // var kk= DateFormat('hh:mm a').format(DateTime.parse("${ss}"));
    //  print(kk);
    return sss ;
  }

  getUserDetails(passwordlogin) async {

    //final user =FirebaseAuth.instance.currentUser==null ?"":FirebaseAuth.instance.currentUser!.uid;

    // var jjj = box1.read('fruits');
   // print('Stored list: $jjj');

    isloading.value=true;


    print("hhhhh $passwordlogin");
    var header="""
query Query(\$id: String, \$authId: String) {
  Get_User_By_Id(id_: \$id, auth_id_: \$authId) {
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
   // print("getUser");
   // log(json.encode(res));
   // print("getUser");

  }
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }


  // void increment() => count.value++;
}
