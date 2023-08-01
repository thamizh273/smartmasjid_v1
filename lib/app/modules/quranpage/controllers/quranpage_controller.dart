import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/quran_detail_model.dart';
import '../model/quran_juz_model.dart';
import '../model/quran_model.dart';
import '../views/qurandetails.dart';

class QuranpageController extends GetxController {
  final box = GetStorage();
  //TODO: Implement QuranpageController
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  final ItemScrollController  itemScrollController = ItemScrollController ();
  final _restCallController = Get.put(restCallController());
  RxInt currentSelected = 1.obs;
  RxBool isLoadings = false.obs;
  RxBool isLoadings1 = false.obs;
  var isSearchEnabled = false.obs;
  var getqurandata = QuranModel().obs;
  var getqurandetail = QuranDetailModel().obs;
  var getquranjuz = QuranJuzModel().obs;
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
  RxList<int> clickedItems = <int>[].obs;
  RxBool switchValue = false.obs;

 var passint=0.obs;
  var buttonsSelected = [].obs;
  var result="".obs;
  var result1="".obs;





  // void scrollToIndex(int index) {
  //   // Calculate the offset to the selected item.
  //   final double itemExtent = 50.0; // Assuming each item has a height of 50.0 pixels.
  //   final double offset = index * itemExtent;
  //
  //   // Scroll the list to the selected item position.
  //   scrollController.animateTo(
  //     offset,
  //     duration: Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }



  void onItemClick(int index) {
    print("mmmmmmmm $index");
    c.quranDetailList(index + 1);
    // Add the clicked item index to the clickedItems list
    clickedItems.add(index);
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
    final storedButtonsSelected = box.read<List<dynamic>>('buttonsSelected');
    if (storedButtonsSelected != null) {
      buttonsSelected.assignAll(storedButtonsSelected);
    }
    quranChapterList();
    quranjuzList();
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
  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  toogle(var index) {
    if (buttonsSelected.contains(index)) {
      buttonsSelected.remove(index);
    } else {
      buttonsSelected.add(index);
    }
    box.write('buttonsSelected',  buttonsSelected.toList());
    update();
  }

  void deleteIndex(int index) {
    buttonsSelected.remove(index);
    // Convert to a regular List before updating GetStorage
    box.write('buttonsSelected', buttonsSelected.toList());
    update(); // Notify GetX that the state has changed
  }

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
    isLoadings1.value = true;
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
    isLoadings1.value = false;
    getqurandetail.value = qurandetailModelFromJson(json.encode(res));
    Get.to(QuranDetails());
    update();
  }

  quranjuzList() async {
    isLoadings.value = true;
    var header = """
query Query(\$masjidId: ID) {
  Get_Quran_Juz_Chapter(masjid_id: \$masjidId) {
    id
    masjid_id
    juz_chapter_no
    juz_name_arb
    juz_name_en
    surah_verses_start
    surah_verses_end
    total_verses
  }
}
    """;

    var body = {
      "masjidId": ""

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data data ${json.encode(res)}");
    isLoadings.value = false;
    getquranjuz.value = quranjuzModelFromJson(json.encode(res));

    update();
  }
}