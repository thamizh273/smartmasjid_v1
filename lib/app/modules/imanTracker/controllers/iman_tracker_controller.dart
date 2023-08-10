import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/imanTracker/model/imanTrakerStatusModel.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/ImanTrakerEntryModel.dart';

class ImanTrackerController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement ImanTrackerController
  final _restCallController = Get.put(restCallController());
  var imanData= GetImanTrakerEntryModel().obs;
  var imanStatusData= ImanTrakerStatusModel().obs;
  late TabController tabctrl;
  var change=0.obs;
  RxBool aSunnah=false.obs;
  RxBool bSunnah=false.obs;
  RxBool isloading=false.obs;
  RxBool isloading1=false.obs;
  var selectedDate=DateTime.now().toUtc().obs;
  @override
  void onInit() {
    getImanTrakerStatus("week");
    getImanTrakerEntry();
    super.onInit();
    tabctrl = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabctrl.dispose();
    super.onClose();
  }
  // List<Map<String,dynamic>> cardColors = [
  //   {"late":Get.theme.colorScheme.secondary,"icon":Icons.add},
  //   {"notprayed":Colors.green,"icon":Icons.groups_sharp},
  //   {"injamaah":Colors.yellow.shade700,"icon":Icons.person},
  //   {"No Update":Colors.red.shade700,"icon":Icons.history},
  //   {"ontime":Colors.black87,"icon":Icons.not_interested},
  //
  // ];

  // RxList<int> colorIndices = List.filled(5, 0).obs;

  // void changeColor(int index) {
  //   colorIndices[index] = (colorIndices[index] + 1) % cardColors.length;
  // }
  yy(int index){
    if(imanData
        .value
        .getPrayerListTracker![index]
        .status=="late"){
      Colors.red;
    }else if(imanData
        .value
        .getPrayerListTracker![index]
        .status=="ontime"){
      Colors.yellow;
    } else{
      Colors.black87;
    }
  }
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Entry'),
    Tab(text: 'Stats'),
  ];
  getImanTrakerEntry() async {
    log("dddd ${selectedDate.value}");
    isloading.value=true;
    var header="""
query Get_Prayer_list_Tracker(\$userId: ID!, \$date: String) {
  Get_Prayer_list_Tracker(user_id_: \$userId, date_: \$date) {
    prayer_id
    prayer_name
    status
  }
}
    """;
    var body ={
      "userId": "5b52cef8-1c88-48ac-bd76-a092cd5ad200",
      "date": "${selectedDate.value}"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading.value=false;

    imanData.value=getImanTrakerEntryModelFromJson(json.encode(res));
    // print("getiman");
    // log(json.encode(res));
    // print("getiman");

  }
  getImanTrakerStatus(status) async {
    log("dddd ${selectedDate.value}");
    isloading1.value=true;
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
      "userId": "5b52cef8-1c88-48ac-bd76-a092cd5ad200",
      "trackerType": "prayertracker",
      "status": "${status}"
    };
    var res = await  _restCallController.gql_query(header, body);
    isloading1.value=false;

    imanStatusData.value=imanTrakerStatusModelFromJson(json.encode(res));
    print("getstatus");
    log(json.encode(res));
    print("getstaus");

  }
}
