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

      var rrr="".obs;
    remainTime(){
      DateTime now = DateTime.now();



      // Target date and time
      var targetDateTime = DateTime.parse("${rrr.value}").toLocal();

      // Calculate the remaining duration
      Duration remainingDuration = targetDateTime.difference(now);

      // Extract the remaining hours and minutes
      int remainingHours = remainingDuration.inHours;
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
      "masjidId": "4654b850-d6e8-4b09-ba07-4063f34bb586"
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
