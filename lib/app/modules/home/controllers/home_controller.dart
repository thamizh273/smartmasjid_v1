import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmasjid_v1/app/modules/home/Model/prayerTimesModel.dart';
import 'package:smartmasjid_v1/app/modules/loginPage/controllers/login_page_controller.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/Model/PrayerPageModel.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../Model/getUserModel.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement HomeController
  final _restCallController = Get.put(restCallController());


  late TabController tabController;

  RxBool alarm = false.obs;
  RxBool isloading = false.obs;
  RxBool isloading1 = false.obs;
  var getUserData=GetUserModel().obs;
  var prayerTimeData=PrayerTimeModel().obs;

  var prayerTime =['fajr', 'dhuhr', 'asr', 'magrib', 'isha'];
     // var imageBytes=images.obs;
  var currentIndex  = 0.obs;
  void updateIndex(int index) {
    currentIndex.value = index;
  }
  RxString nearestDuration = ''.obs;
  RxString nearestDuration1 = ''.obs;   var rrr="".obs;
 //var uid= Get.arguments[0];
var uid= "";
  @override
  void onInit() {

   // getUserDetails(Get.arguments[0]);
   getUserDetails("5b52cef8-1c88-48ac-bd76-a092cd5ad200");
    getPrayerTime();
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
    print(sss);
    print("ggg");
    // Output the result
    print("Remaining time: $remainingHours hours and $remainingMinutes minutes");

    // var ss= DateTime.now().millisecondsSinceEpoch.obs - DateTime.parse("${prayerpageData.value.getMasjidPrayerTimeFilter![0].startTime}").toLocal().microsecondsSinceEpoch;
    // var kk= DateFormat('hh:mm a').format(DateTime.parse("${ss}"));
    //  print(kk);
    return sss ;
  }

  getUserDetails(k) async {

    isloading.value=true;
    var header="""
query Get_User_By_Id(\$id: String) {
  Get_User_By_Id(id_: \$id) {
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
    }
    member_status
    phone_number
    post
    user_type
  }
}
    """;
    var body ={
      "id": "${k}"
     // "id": "$k"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;
   // print("getUser");
   getUserData.value=getUserModelFromJson(json.encode(res));
    // log(json.encode(res));
    // print("getUser");

  }
  getPrayerTime() async {

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
      "masjidId": "a4fee385-0641-4dce-bd42-f35ee278ce35"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading1.value=false;

    prayerTimeData.value=prayerTimeModelFromJson(json.encode(res));
    print("getUser");
    log(json.encode(res));
    print("getUser");

  }


  // void increment() => count.value++;
}
