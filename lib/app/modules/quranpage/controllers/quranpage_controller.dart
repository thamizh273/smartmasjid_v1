import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/quran_model.dart';

class QuranpageController extends GetxController {
  //TODO: Implement QuranpageController
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final count = 0.obs;
  ScrollController scrollController = ScrollController();
  final _restCallController = Get.put(restCallController());
  RxInt currentSelected = 1.obs;
  RxBool isLoadings = false.obs;
  var isSearchEnabled = false.obs;
  var getqurandata = QuranModel().obs;
  var searchQuery = ''.obs;



  void toggleSearch() {
    isSearchEnabled.value = !isSearchEnabled.value;
    if (!isSearchEnabled.value) {
      // Clear the search query when disabling search
      searchQuery.value = '';
    }
  }

  @override
  void onInit() {
    quranChapterList();
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
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void increment() => count.value++;


  quranChapterList() async {
    isLoadings.value=true;
    var header = """
query Query(\$getChapterByMsId: String) {
  Quran_Filter(get_chapter_by_ms_id: \$getChapterByMsId) {
    id
    masjid_id
    sura_chapter_no
    sura_name_arb
    sura_name_en
    sura_name_hindi
    sura_name_tamil
    title_en
    title_hindi
    title_tamil
    total_verses
  }
}
    """;

    var body = {
      "getChapterByMsId": "5be1d5b1-85ed-485a-b8a9-0e96e5277718",

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data sign ${json.encode(res)}");
    isLoadings.value=false;
    getqurandata.value=quranModelFromJson(json.encode(res));

    update();


  }
}
