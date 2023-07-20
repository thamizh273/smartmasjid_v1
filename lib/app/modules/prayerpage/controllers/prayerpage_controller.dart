import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/prayerpage/Model/PrayerPageModel.dart';

import '../../../rest_call_controller/rest_call_controller.dart';

class PrayerpageController extends GetxController {
  //TODO: Implement PrayerpageController
     RxBool isLoading=false.obs;
     final _restCallController = Get.put(restCallController());
     var prayerpageData = PrayerPageModel().obs;
     late Rx<Timer> timer;
      var rrr="".obs;
     RxString nearestDuration = ''.obs;
     RxString nearestDuration1 = ''.obs;


  @override
  void onInit() {
    get_prayerTime();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();


    
  }

  @override
  void onClose() {
    super.onClose();
  }

     //
     // void startTimer() {
     //   // Start a timer that updates the remaining time every second
     //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
     //     remainTime();
     //   });
     // }
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
  get_prayerTime() async {
    //masjidListdata.value.getMasjidFilter=null;
    isLoading.value = true;
    var header = """
query Query(\$masjidId: String) {
  Get_Masjid_Prayer_Time_Filter(masjid_id_: \$masjidId) {
    id
    start_time
    end_time
    prayer_name
    notification
    prayer_status
  }
}
    """;
    var body = {
      "masjidId": "a4fee385-0641-4dce-bd42-f35ee278ce35"
    };
    var res = await _restCallController.gql_query(header, body);
    print("ssss");
    log(json.encode(res));
    print("ssss");
    isLoading.value = false;

    prayerpageData.value = prayerPageModelFromJson(json.encode(res));
    update();
  }

}
