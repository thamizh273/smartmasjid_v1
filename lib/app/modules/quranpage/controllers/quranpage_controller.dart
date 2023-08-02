import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/quran_detail_model.dart';
import '../model/quran_juz_detail_model.dart';
import '../model/quran_juz_model.dart';
import '../model/quran_model.dart';
import '../views/qurandetails.dart';

class QuranpageController extends GetxController {
  final box = GetStorage();
  //TODO: Implement QuranpageController
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllern = ScrollController();

  final ItemScrollController  itemScrollController = ItemScrollController();
  final ItemScrollController  itemScrollControllerjuz = ItemScrollController();


  final ScrollController scrollControllerbot = ScrollController();
  final ScrollController scrollControllerbot1 = ScrollController();
  final ScrollController scrollControllerbot2 = ScrollController();
  final ScrollController scrollControllerjuz = ScrollController();

  final _restCallController = Get.put(restCallController());
  RxInt currentSelected = 1.obs;
  RxBool isLoadings = false.obs;
  RxBool isLoadings1 = false.obs;
  RxBool isLoadingsJuz = false.obs;
  var isLoading = false.obs;
  var isSearchEnabled = false.obs;
  var getqurandata = QuranModel().obs;
  var getqurandetail = QuranDetailModel().obs;
  var getquranjuz = QuranJuzModel().obs;
  var getquranjuzdetail = QuranJuzDetailModel().obs;
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
  int lastReadIndex = -1;
  var filteredList = <dynamic>[].obs;
  var item = <String>[].obs;
  var currentIndex = 0.obs;
  var pageIndex = [].obs;


  Future<void> fetchMoreData() async {
    if (isLoading.value) return; // Avoid multiple requests

    isLoading.value = true;

    // Simulate a delay
    await Future.delayed(Duration(seconds: 0));

    // Load the same data again
    final newData = List<QuranFilter>.from(getqurandata.value.quranFilter!);
    getqurandata.update((val) {
      val!.quranFilter!.addAll(newData);
    });

    isLoading.value = false;
  }







void setLastReadIndex(int index) {
    lastReadIndex = index;
  }


 var passint=0.obs;
  var buttonsSelected = [].obs;
  var result="".obs;
  var result1="".obs;



  void onItemClick(int index) {
    print("mmmmmmmm $index");
    c.quranDetailList(index + 1);
    // Add the clicked item index to the clickedItems list
    clickedItems.add(index);
  }
  void onItemClick1(int index) {
    print("mmmmmmmm $index");
    c.quranjuzdetailList(index + 1);
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
    // quranjuzdetailList();
    // quranjuzdetailList();
    // debounce(searchQuery, (_) => filterList(), time: Duration(milliseconds: 500));
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
    sura_chapter_no
    ayah_list {
      arabic_text
      ayah_no
      verses_key
      arabic_audio
      eng_translation
      tamil_translation
      hindi_translation
    }
    sura_name_en
    makki_madina
    title_arb
    title_en
    total_verses
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
    log("data juz ${json.encode(res)}");
    isLoadings.value = false;
    getquranjuz.value = quranjuzModelFromJson(json.encode(res));

    update();
  }

  quranjuzdetailList(index) async {
    isLoadingsJuz.value = true;
    var header = """
query Get_Quran_Juz_Chapter(\$juzChapterNo: String) {
  Get_Quran_Juz_Verses_List(juz_chapter_no: \$juzChapterNo) {
    juz_chapter_no
    juz_name_arb
    juz_name_en
    surah_verses_start
    surah_verses_end
    total_verses
    ayah_list {
      sura_chapter_no
      verses_key
      arabic_text
      arabic_audio
      eng_translation
      tamil_translation
      hindi_translation
      ayah_no
    }
  }
}
    """;

    var body = {
      "juzChapterNo": "${index}"

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data data ${json.encode(res)}");
    isLoadingsJuz.value = false;
    getquranjuzdetail.value = quranjuzdetailModelFromJson(json.encode(res));

    update();
  }
}