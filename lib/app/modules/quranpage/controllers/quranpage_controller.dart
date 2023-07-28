import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/quran_detail_model.dart';
import '../model/quran_model.dart';
import '../views/qurandetails.dart';

class QuranpageController extends GetxController {
  //TODO: Implement QuranpageController
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final count = 0.obs;
  ScrollController scrollController = ScrollController();
  final _restCallController = Get.put(restCallController());
  RxInt currentSelected = 1.obs;
  RxBool isLoadings = false.obs;
  RxBool isLoadings1 = false.obs;
  var isSearchEnabled = false.obs;
  var getqurandata = QuranModel().obs;
  var getqurandetail = QuranDetailModel().obs;
  var searchQuery = ''.obs;
  var isChecked = false.obs;
  var fontAmiri = "".obs;
  var fontKalam = "".obs;
  var fontFont3 = "".obs;
  var fontFont4 = "".obs;
  RxDouble sliderValue = 0.0.obs;
  RxDouble sliderValue1 = 0.0.obs;
  final isCheckedArabic = true.obs;
  final isCheckedEnglish = true.obs;
  final isCheckedTamil = false.obs;
  double screenWidth = Get.width;
  var fontFamily = "indopak".obs;
  var view = "sura".obs;
  final media = Get.mediaQuery;
  final padExtend = 16.0;
  var bookmarks = [].obs;
  var isBookmarked = false.obs;

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }


void changeFontFamily(String family) {
    fontFamily.value = family;
  }

  void setSliderValue(double value) {
    sliderValue.value = value; // Update the sliderValue using the value passed
  }
  void setSliderValue1(double value) {
    sliderValue1.value = value; // Update the sliderValue using the value passed
  }

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
  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void increment() => count.value++;


  quranChapterList() async {
    isLoadings.value = true;
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
    title_arabic
    quran_type
  }
}
    """;

    var body = {
      "getChapterByMsId": ""

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data sign ${json.encode(res)}");
    isLoadings.value = false;
    getqurandata.value = quranModelFromJson(json.encode(res));

    update();
  }

  quranDetailList(index) async {
    isLoadings.value = true;
    var header = """
query Query(\$chapterNo: String!) {
  Get_Quran_Ayah_Verse(chapter_no: \$chapterNo) {
    makki_madina
    sura_chapter_no
    sura_name_en
    title_en
    total_verses
    ayah_list {
      arabic_audio
      arabic_text
      ayah_no
      eng_translation
      hindi_translation
      tamil_translation
      verses_key
    }
  }
}
    """;

    var body = {
      "chapterNo": "${index}",

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data new ${json.encode(res)}");
    isLoadings.value = false;
    getqurandetail.value = qurandetailModelFromJson(json.encode(res));
    Get.to(QuranDetails());
    update();
  }
}