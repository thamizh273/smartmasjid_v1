import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smartmasjid_v1/app/modules/home/controllers/home_controller.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/quran_juz_details.dart';
import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../model/quran_detail_model.dart';
import '../model/quran_juz_detail_model.dart';
import '../model/quran_juz_model.dart';
import '../model/quran_juz_model.dart';
import '../model/quran_juz_model.dart';
import '../model/quran_model.dart';
import '../views/qurandetails.dart';

class QuranpageController extends GetxController {
  final homectrl = Get.find<HomeController>();

  //final storeBookmark = GetStorage();
  //TODO: Implement QuranpageController
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerq = ScrollController();
  ScrollController scrollControllern = ScrollController();
  ScrollController ayahController = ScrollController();
  ScrollController pageControllera = ScrollController();
  FixedExtentScrollController scrollControllerm = FixedExtentScrollController();
  late AutoScrollController controllerff;
  late AutoScrollController controllerffPage;
  RxInt pagesint = 0.obs;

  Future scrollToPage() async {
    await controllerffPage.scrollToIndex(pagesint.value,
        preferPosition: AutoScrollPosition.begin,
        duration: Duration(milliseconds: 10));
  }

  final ScrollController scrollControllerjuz = ScrollController();
  final ScrollController scrollControllera = ScrollController();

  final _restCallController = Get.put(restCallController());
  RxInt gotoSura = 7.obs;
  RxInt gotoPage = 0.obs;
  RxInt currentSelected = 0.obs;
  RxInt currentSelectedpassaya = 0.obs;
  RxBool isLoadings0 = false.obs;
  RxBool isLoadings = false.obs;
  RxBool isLoadings1 = false.obs;
  RxBool isLoadingsJuz = false.obs;
  var isLoading = false.obs;

  // var isSearchEnabled = false.obs;
  var getqurandata = QuranModel().obs;
  var getqurandetail = QuranDetailModel().obs;
  var getquranjuz = QuranJuzModel().obs;
  var getquranjuzdetail = QuranJuzDetailModel().obs;

  // var searchQuery = ''.obs;
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
  final isCheckedTelugu = false.obs;
  final isCheckedUrdu = false.obs;
  final isCheckedMalayalam = false.obs;
  final isCheckedHindi = false.obs;
  var isCheckedTamill = "tamil".obs;
  double screenWidth = Get.width;
  var fontFamily = "uthami".obs;
  var view = "sura".obs;
  final media = Get.mediaQuery;
  final padExtend = 16.0;
  RxList<int> clickedItems = <int>[].obs;
  RxBool switchValue = false.obs;
  int lastReadIndex = -1;
  var filteredList = <dynamic>[].obs;
  var item = <String>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isSelected = false.obs;
  int selectedAdjustedIndex = -1.obs;
  PageController pageController = PageController(initialPage: 0);
  PageController pageControllerjuz = PageController(initialPage: 0);
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchjuzController = TextEditingController();
  final Rx<QuranModel> items = QuranModel().obs;
  final RxList<GetQuranAyahVerse> share = <GetQuranAyahVerse>[].obs;
  final RxList<QuranFilter> filteredItems = <QuranFilter>[].obs;
  final RxList<GetQuranJuzChapter> filteredjuzItems =
      <GetQuranJuzChapter>[].obs;
  final RxString savedSearchQuery = ''.obs;
  final RxBool isSearchEnabled = false.obs;
  final RxString searchQuery = ''.obs;
  var currentVerseSelected = 1.obs;
  var currentSelectedPageIndex = 0.obs;
  var currentSelectedPages = <int>[].obs;
  RxInt qurandetsilIndex = 0.obs;
  RxInt qurandetsilIndex1 = 0.obs;
  final RxBool isDownloaded = false.obs;
  final RxBool isDownloading = false.obs;
  final RxBool isFetching = false.obs;
  final RxDouble downloadProgress = 0.0.obs;
  static const double itemHeight_ = 50;
  static int initialItemCount_ = 114; // Initial number of items
  RxInt itemCount_ = initialItemCount_.obs;
  final scrollController_ = FixedExtentScrollController(initialItem: 114).obs;
  late final String courseName;
  var isDownloadStarted = false.obs; // Use RxBool for reactive boolean
  var isDownloadFinish = false.obs;

  @override
  void onInit() async {
    await quranChapterList();
    await quranjuzList();

    pageController = PageController(initialPage: 0);
    pageControllerjuz = PageController(initialPage: 0);

    filteredItems.assignAll(getqurandata.value.quranFilter!);
    filteredjuzItems.assignAll(getquranjuz.value.getQuranJuzChapter!);
    searchController.addListener(filteredItems);
    searchjuzController.addListener(filteredjuzItems);
    super.onInit();
    scrollController_.value.addListener(_scrollListener);
    controllerff = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
        axis: Axis.vertical);
    controllerffPage = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
        axis: Axis.vertical);
  }

  @override
  void onReady() {
    final storedButtonsSelected =
        homectrl.box1.read<List<dynamic>>('buttonsSelected');
    if (storedButtonsSelected != null) {
      buttonsSelected.assignAll(storedButtonsSelected);
      update();
    }
    final storedButtonsSelectedSura =
        homectrl.box1.read<List<dynamic>>('buttonsSelectedSura');
    if (storedButtonsSelectedSura != null) {
      buttonsSelectedSura.assignAll(storedButtonsSelectedSura);
      update();
    }
    final storedButtonsSelectedJuz =
        homectrl.box1.read<List<dynamic>>('buttonsSelectedJuz');
    if (storedButtonsSelectedJuz != null) {
      buttonsSelectedJuz.assignAll(storedButtonsSelectedJuz);
      update();
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    scrollController_.value.removeListener(_scrollListener);
    scrollController_.value.dispose();
    scrollController.dispose();
    scrollControllerq.dispose();
    scrollControllern.dispose();
    super.dispose();
  }

  void downloadCourse() async {
    isDownloadStarted.value = true;
    isDownloadFinish.value = false;
    downloadProgress.value = 0;

    // Download logic
    while (downloadProgress.value < 100) {
      await Future.delayed(const Duration(milliseconds: 500));
      downloadProgress.value += 10;

      if (downloadProgress.value == 100) {
        isDownloadFinish.value = true;
        isDownloadStarted.value = false;
        break;
      }
    }
  }

  void onPressed() {
    // Your onPressed logic here
  }

  void shareMessage(index) {
    Share.share(
        "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].versesKey}"
        "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].arabicText}"
        "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].engTranslation}"
        "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].tamilTranslation}");
  }

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

  var copy = [].obs;

  void copyToClipboard(index) {
    Clipboard.setData(ClipboardData(
        text:
            "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].versesKey}"
            "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].arabicText}"
            "${getqurandetail.value.getQuranAyahVerse![0].ayahList![index].engTranslation}"));
    Get.snackbar('Copied', 'Text copied to clipboard!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1));
  }

  copyText(var index) {
    if (copy.contains(index)) {
      Clipboard.setData(ClipboardData(text: "$index"));
    }
    Get.snackbar('Copied', 'Text copied to clipboard!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1));
  }

  var passint = 0.obs;
  var buttonsSelected = [].obs;
  var buttonsSelectedSura = [].obs;
  var buttonsSelectedJuz = [].obs;

  var result = 0.obs;
  var result1 = 0.obs;

  Future scrollToIndex() async {
    await controllerff.scrollToIndex(result.value,
        preferPosition: AutoScrollPosition.begin);
  }

  toogle(Map<String, dynamic> data) {
    final index = data['name'];
    if (buttonsSelected.any((item) => item['name'] == index)) {
      buttonsSelected.removeWhere((item) => item['name'] == index);
    } else {
      buttonsSelected.add(data);
      update();
    }
    homectrl.box1.write('buttonsSelected', buttonsSelected);
    update();
  }

  toogleSura(Map<String, dynamic> data) {
    final indexsura = data['name'];
    if (buttonsSelectedSura.any((item) => item['name'] == indexsura)) {
      buttonsSelectedSura.removeWhere((item) => item['name'] == indexsura);
      update();
    } else {
      buttonsSelectedSura.add(data);
      update();
    }
    homectrl.box1.write('buttonsSelectedSura', buttonsSelectedSura);
    update();
  }

  toogleJuz(Map<String, dynamic> data) {
    final indexjuz = data['name'];
    if (buttonsSelectedJuz.any((item) => item['name'] == indexjuz)) {
      buttonsSelectedJuz.removeWhere((item) => item['name'] == indexjuz);
    } else {
      buttonsSelectedJuz.add(data);
      update();
    }
    homectrl.box1.write('buttonsSelectedJuz', buttonsSelectedJuz);
    update();
  }

  void deleteIndex(int index) {
    buttonsSelected.remove(index);
    // Convert to a regular List before updating GetStorage
    homectrl.box1.write('buttonsSelected', buttonsSelected.toList());
    update(); // Notify GetX that the state has changed
  }

  void deleteIndexSura(int index) {
    buttonsSelectedSura.remove(index);
    // Convert to a regular List before updating GetStorage
    homectrl.box1.write('buttonsSelectedSura', buttonsSelectedSura.toList());
    update(); // Notify GetX that the state has changed
  }

  void deleteIndexJuz(int index) {
    buttonsSelectedJuz.remove(index);
    // Convert to a regular List before updating GetStorage
    homectrl.box1.write('buttonsSelectedJuz', buttonsSelectedJuz.toList());
    update(); // Notify GetX that the state has changed
  }

  void setLastReadIndex(int index) {
    lastReadIndex = index;
  }

  void onItemClick(int index) {
    print("mmmmmmmm $index");
    quranDetailList(index + 1);
    // Add the clicked item index to the clickedItems list
    clickedItems.add(index);
  }

  void onItemClick1(int index) {
    print("mmmmmmmm $index");
    quranjuzdetailList(index + 1);
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
      clearSearch();
    } else {
      // Set back the previous search query
      searchQuery.value = savedSearchQuery.value;
    }
  }

  void clearSearch() {
    isSearchEnabled.value = false;
    searchQuery.value = '';
    filteredItems.assignAll(getqurandata.value.quranFilter!);
    // Clear the saved search query
    savedSearchQuery.value = '';
  }

  void filterItems() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredItems.assignAll(getqurandata.value.quranFilter!);
    } else {
      final List<QuranFilter> filteredList =
          getqurandata.value.quranFilter!.where((QuranFilter item) {
        return item.suraNameEn!
                .toLowerCase()
                .contains(query) || // Add more conditions if needed
            item.suraNameArb!.toLowerCase().contains(query);
      }).toList();
      filteredItems().assignAll(filteredList);
    }
  }

  void filterjuzItems() {
    final query = searchjuzController.text.toLowerCase();
    if (query.isEmpty) {
      filteredjuzItems.assignAll(getquranjuz.value.getQuranJuzChapter!);
      filteredjuzItems.assignAll(getquranjuz.value.getQuranJuzChapter!);
    } else {
      final List<GetQuranJuzChapter> filteredjuzList = getquranjuz
          .value.getQuranJuzChapter!
          .where((GetQuranJuzChapter item) {
        return item.juzNameEn!
                .toLowerCase()
                .contains(query) || // Add more conditions if needed
            item.juzNameArb!.toLowerCase().contains(query);
      }).toList();
      filteredjuzItems.assignAll(filteredjuzList);
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void openEndDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void _scrollListener() {
    if (scrollController_.value.position.extentAfter < itemHeight_ * 2) {
      // Load more items when reaching near the end

      itemCount_.value +=
          initialItemCount_; // You can adjust the number of items to add
    }
  }

  Future<bool> loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    quranChapterList();
    return true;
  }

  quranChapterList() async {
    isLoadings0.value = true;
    var header = """
query Quran_Filter(\$getChapterByMsId: String) {
  Quran_Filter(get_chapter_by_ms_id: \$getChapterByMsId) {
    masjid_id
    sura_chapter_no
    sura_name_en
    sura_name_arb
    sura_name_tamil
    sura_name_hindi
    sura_name_malayalam
    sura_name_telugu
    sura_name_urdu
    title_en
    title_tamil
    title_hindi
    title_arabic
    title_malayalam
    title_telugu
    title_urdu
    total_verses
    quran_type
  }
}
    """;

    var body = {"getChapterByMsId": ""};
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data sign ${json.encode(res)}");
    isLoadings0.value = false;
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
    title_arb
    total_verses
    arabic_starting_text
    ayah_list {
      verses_key
      ayah_no
      arabic_text
      arabic_audio
      eng_translation
      tamil_translation
      hindi_translation
      malayalam_translation
      telugu_translation
      urdu_translation
      page_
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
    getqurandetail.value = quranDetailModelFromJson(json.encode(res));
    Get.to(() => QuranDetails());
    await scrollToIndex();
    update();
  }

  quranjuzList() async {
    isLoadings.value = true;
    var header = """
query Get_Quran_Juz_Chapter(\$masjidId: ID) {
  Get_Quran_Juz_Chapter(masjid_id: \$masjidId) {
    juz_chapter_no
    juz_name_arb
    juz_name_en
    juz_name_tamil
    juz_name_hindi
    juz_name_malayalam
    juz_name_telugu
    juz_name_urdu
    surah_verses_start
    surah_verses_end
    total_verses
  }
}
    """;

    var body = {"masjidId": ""};
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data juz ${json.encode(res)}");
    isLoadings.value = false;
    getquranjuz.value = quranJuzModelFromJson(json.encode(res));

    update();
  }

  quranjuzdetailList(index) async {
    isLoadingsJuz.value = true;
    var header = """
query Get_Quran_Juz_Verses_List(\$juzChapterNo: String) {
  Get_Quran_Juz_Verses_List(juz_chapter_no: \$juzChapterNo) {
    juz_chapter_no
    juz_name_arb
    juz_name_en
    surah_verses_start
    surah_verses_end
    total_verses
    ayah_list {
      sura_chapter_no
      ayah_no
      arabic_text
      verses_key
      arabic_audio
      tamil_translation
      eng_translation
      hindi_translation
      malayalam_translation
      telugu_translation
      urdu_translation
    }
    juz_name_tamil
    juz_name_hindi
    juz_name_malayalam
    juz_name_telugu
    juz_name_urdu
  }
}
    """;

    var body = {"juzChapterNo": "${index}"};
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data data ${json.encode(res)}");
    isLoadingsJuz.value = false;
    getquranjuzdetail.value = quranJuzDetailModelFromJson(json.encode(res));
    Get.to(() => QuranJuzDetails());
    await scrollToIndex();
    update();
  }

  /// sura title arabic
  var images = [
    {"sura": "Al-Fatihah", "image": "assets/images/1. Al-Fatihah.png"},
    {"sura": "Al-Baqarah", "image": "assets/images/2. Al-Baqarah.png"},
    {"sura": "Ali 'Imran", "image": "assets/images/3. Ali-Imran.png"},
    {"sura": "An-Nisa", "image": "assets/images/4. An-Nisa.png"},
    {"sura": "Al-Ma'idah", "image": "assets/images/5. Al-Maidah.png"},
    {"sura": "Al-An'am", "image": "assets/images/6. Al-Anam.png"},
    {"sura": "Al-A'raf", "image": "assets/images/7. Al-Araf.png"},
    {"sura": "Al-Anfal", "image": "assets/images/8. AL-Anfal.png"},
    {"sura": "At-Tawbah", "image": "assets/images/9. At-Tawbah.png"},
    {"sura": "Yunus", "image": "assets/images/10. Yunus.png"},
    {"sura": "Hud", "image": "assets/images/11. Hud.png"},
    {"sura": "Yusuf", "image": "assets/images/12. Yusuf.png"},
    {"sura": "Ar-Ra'd", "image": "assets/images/13. Ar-Rad.png"},
    {"sura": "Ibrahim", "image": "assets/images/14. Ibrahim.png"},
    {"sura": "Al-Hijr", "image": "assets/images/15. Al-Hijr.png"},
    {"sura": "An-Nahl", "image": "assets/images/16. An-Nahl.png"},
    {"sura": "Al-Isra", "image": "assets/images/17. Al-Isra.png"},
    {"sura": "Al-Kahf", "image": "assets/images/18. Al-Kahf.png"},
    {"sura": "Maryam", "image": "assets/images/19. Maryam.png"},
    {"sura": "Taha", "image": "assets/images/20. Taha.png"},
    {"sura": "Al-Anbya", "image": "assets/images/21. Al-Anbya.png"},
    {"sura": "Al-Hajj", "image": "assets/images/22. Al-Hajj.png"},
    {"sura": "Al-Mu'minun", "image": "assets/images/23. Al-Muminum.png"},
    {"sura": "An-Nur", "image": "assets/images/24. An-Nur.png"},
    {"sura": "Al-Furqan", "image": "assets/images/25. Al-Furqan.png"},
    {"sura": "Ash-Shu'ara", "image": "assets/images/26. Ash-Shuara.png"},
    {"sura": "An-Naml", "image": "assets/images/27. An-Naml.png"},
    {"sura": "Al-Qasas", "image": "assets/images/28. Al-Qasas.png"},
    {"sura": "Al-'Ankabut", "image": "assets/images/29. Al-Ankabut.png"},
    {"sura": "Ar-Rum", "image": "assets/images/30. Ar-Rum.png"},
    {"sura": "Luqman", "image": "assets/images/31. Luqman.png"},
    {"sura": "As-Sajdah", "image": "assets/images/32. As-Sajdah.png"},
    {"sura": "Al-Ahzab", "image": "assets/images/33. Al-Ahzab.png"},
    {"sura": "Saba", "image": "assets/images/34. Saba.png"},
    {"sura": "Fatir", "image": "assets/images/35. Fatir.png"},
    {"sura": "Ya-Sin", "image": "assets/images/36. Ya-Sin.png"},
    {"sura": "AsSaffat", "image": "assets/images/37. As-Saffat.png"},
    {"sura": "Sad", "image": "assets/images/38. Sad.png"},
    {"sura": "Az-Zumar", "image": "assets/images/39. Az-Zumar.png"},
    {"sura": "Ghafir", "image": "assets/images/40. Ghahir.png"},
    {"sura": "Fussilat", "image": "assets/images/41. Fussilat.png"},
    {"sura": "Ash-Shuraa", "image": "assets/images/42. Ash-Shuraa.png"},
    {"sura": "Az-Zukhruf", "image": "assets/images/43. Az-Zukhruf.png"},
    {"sura": "Ad-Dukhan", "image": "assets/images/44. Ad-Dukhan.png"},
    {"sura": "Al-Jathiyah", "image": "assets/images/45. Al-Jathiyah.png"},
    {"sura": "Al-Ahqaf", "image": "assets/images/46. Al-Ahqaf.png"},
    {"sura": "Muhammad", "image": "assets/images/47. Muhammad.png"},
    {"sura": "Al-Fath", "image": "assets/images/48. Al-Fath.png"},
    {"sura": "Al-Hujurat", "image": "assets/images/49. Al-Hujurat.png"},
    {"sura": "Qaf", "image": "assets/images/50. Qaf.png"},
    {"sura": "Adh-Dhariyat", "image": "assets/images/51. Adh-Dhariyat.png"},
    {"sura": "At-Tur", "image": "assets/images/52. At-Tur.png"},
    {"sura": "An-Najm", "image": "assets/images/53. An-Najm.png"},
    {"sura": "Al-Qamar", "image": "assets/images/54. Al-Qamar.png"},
    {"sura": "Ar-Rahman", "image": "assets/images/55. Ar-Rahman.png"},
    {"sura": "Al-Waqi'ah", "image": "assets/images/56. Al-Waqiah.png"},
    {"sura": "Al-Hadid", "image": "assets/images/57. Al-Hadid.png"},
    {"sura": "Al-Mujadila", "image": "assets/images/58. Al-Mujadila.png"},
    {"sura": "Al-Hashr", "image": "assets/images/59. Al-Hashr.png"},
    {"sura": "Al-Mumtahanah", "image": "assets/images/60. Al-Mumtahanah.png"},
    {"sura": "As-Saf", "image": "assets/images/61. As-Saf.png"},
    {"sura": "Al-Jumu'ah", "image": "assets/images/62. Al-Jumuah.png"},
    {"sura": "Al-Munafiqun", "image": "assets/images/63. Al-Munafiqun.png"},
    {"sura": "At-Taghabun", "image": "assets/images/64. At-Taghabun.png"},
    {"sura": "At-Talaq", "image": "assets/images/65. At-Talaq.png"},
    {"sura": "At-Tahrim", "image": "assets/images/66. At-Tahrim.png"},
    {"sura": "Al-Mulk", "image": "assets/images/67. Al-Mulk.png"},
    {"sura": "Al-Qalam", "image": "assets/images/68. Al-Qalam.png"},
    {"sura": "Al-Haqqah", "image": "assets/images/69. Al-Haqqah.png"},
    {"sura": "Al-Ma'arij", "image": "assets/images/70. Al-Maarij.png"},
    {"sura": "Nuh", "image": "assets/images/71. Nuh.png"},
    {"sura": "Al-Jinn", "image": "assets/images/72. Al-Jinn.png"},
    {"sura": "Al-Muzzammil", "image": "assets/images/73. Al-Muzzammil.png"},
    {"sura": "Al-Muddaththir", "image": "assets/images/74. Al-Muddaththir.png"},
    {"sura": "Al-Qiyamah", "image": "assets/images/75. Al-Qiyamah.png"},
    {"sura": "Al-Insan", "image": "assets/images/76. Al-Insan.png"},
    {"sura": "Al-Mursalat", "image": "assets/images/77. Al-Mursalat.png"},
    {"sura": "An-Naba", "image": "assets/images/78. An-Naba.png"},
    {"sura": "An-Nazi'at", "image": "assets/images/79. An-Naziat.png"},
    {"sura": "'Abasa", "image": "assets/images/80. Abasa.png"},
    {"sura": "At-Takwir", "image": "assets/images/81. At-Takwir.png"},
    {"sura": "Al-Infitar", "image": "assets/images/82. Al-Infitar.png"},
    {"sura": "Al-Mutaffifin", "image": "assets/images/83. Al-Mutaffifin.png"},
    {"sura": "Al-Inshiqaq", "image": "assets/images/84. Al-Inshiqaq.png"},
    {"sura": "Al-Buruj", "image": "assets/images/85. Al-Buruj.png"},
    {"sura": "At-Tariq", "image": "assets/images/86. At-Tariq.png"},
    {"sura": "Al-A'la", "image": "assets/images/87. Al-ala.png"},
    {"sura": "Al-Ghashiyah", "image": "assets/images/88. Al-Ghashiyah.png"},
    {"sura": "Al-Fajr", "image": "assets/images/89. Al-Fajr.png"},
    {"sura": "Al-Balad", "image": "assets/images/90. Al-Balad.png"},
    {"sura": "Ash-Shams", "image": "assets/images/91. Ash-Shams.png"},
    {"sura": "Al-Layl", "image": "assets/images/92. Al-Layl.png"},
    {"sura": "Ad-Duhaa", "image": "assets/images/93. Ad-Duhaa.png"},
    {"sura": "Ash-Sharh", "image": "assets/images/94. Ash-Sharh.png"},
    {"sura": "At-Tin", "image": "assets/images/95. At-Tin.png"},
    {"sura": "Al-'Alaq", "image": "assets/images/96. Al-Alaq.png"},
    {"sura": "Al-Qadr", "image": "assets/images/97. Al-Qadr.png"},
    {"sura": "Al-Bayyinah", "image": "assets/images/98. Al-Bayyinah.png"},
    {"sura": "Az-Zalzalah", "image": "assets/images/99. Az-Zalzalah.png"},
    {"sura": "Al-'Adiyat", "image": "assets/images/100. Al-Adiyat.png"},
    {"sura": "Al-Qari'ah", "image": "assets/images/101. Al-Qariah.png"},
    {"sura": "At-Takathur", "image": "assets/images/102. At-Takathur.png"},
    {"sura": "Al-'Asr", "image": "assets/images/103. Al-Asr.png"},
    {"sura": "Al-Humazah", "image": "assets/images/104. Al-Humazah.png"},
    {"sura": "Al-Fil", "image": "assets/images/105. Al-Fil.png"},
    {"sura": "Quraysh", "image": "assets/images/106. Quraysh.png"},
    {"sura": "Al-Ma'un", "image": "assets/images/107. Al-Maun.png"},
    {"sura": "Al-Kawthar", "image": "assets/images/108. Al-Kawthar.png"},
    {"sura": "Al-Kafirun", "image": "assets/images/109. Al-Kafirun.png"},
    {"sura": "An-Nasr", "image": "assets/images/110. An-Nasr.png"},
    {"sura": "Al-Masad", "image": "assets/images/111. Al-Masad.png"},
    {"sura": "Al-Ikhlas", "image": "assets/images/112. Al-Ikhlas.png"},
    {"sura": "Al-Falaq", "image": "assets/images/113. Al-Falaq.png"},
    {"sura": "AnNas", "image": "assets/images/114. An-last.png"},
  ];

  var juz = [
    {"juz": "Alif Laam Meem", "image": "assets/images/Juz 1.png"},
    {"juz": "Sayaqūl", "image": "assets/images/Juz 2.png"},
    {"juz": "Tilka -r-rusul", "image": "assets/images/Juz 3.png"},
    {"juz": "Lan Tana Lu", "image": "assets/images/Juz 4.png"},
    {"juz": "W-al-muḥṣanāt", "image": "assets/images/Juz 5.png"},
    {"juz": "Lā yuẖibbu-llāh", "image": "assets/images/Juz 6.png"},
    {"juz": "Wa ʾidha samiʿū", "image": "assets/images/Juz 7.png"},
    {"juz": "Wa law ʾannanā", "image": "assets/images/Juz 8.png"},
    {"juz": "Qāl al-malāʾ", "image": "assets/images/Juz 9.png"},
    {"juz": "W-aʿlamū", "image": "assets/images/Juz 10.png"},
    {"juz": "Yaʾtadhirūna", "image": "assets/images/Juz 11.png"},
    {"juz": "Wa mā min dābbah", "image": "assets/images/juz 12.png"},
    {"juz": "Wa mā ʾubarriʾu", "image": "assets/images/Juz 13.png"},
    {"juz": "Ruba Maʾ", "image": "assets/images/Juz 14.png"},
    {"juz": "Subḥāna -lladhi", "image": "assets/images/Juz 15.png"},
    {"juz": "Qāla ʾa-lam", "image": "assets/images/Juz 16.png"},
    {"juz": "Iqtaraba li-n-nās", "image": "assets/images/Juz 17.png"},
    {"juz": "Qad ʾaflaḥa", "image": "assets/images/Juz 18.png"},
    {"juz": "Wa-qāla -lladhīna", "image": "assets/images/Juz 19.png"},
    {"juz": "Amman khalaqa", "image": "assets/images/Juz 20.png"},
    {"juz": "Otlu maa oohiya", "image": "assets/images/Juz 21.png"},
    {"juz": "Wa-man yaqnut", "image": "assets/images/Juz 22.png"},
    {"juz": "Wama liya", "image": "assets/images/Juz 23.png"},
    {"juz": "Fa-man ʾaẓlamu", "image": "assets/images/Juz 24.png"},
    {"juz": "ʾIlaihi yuraddu", "image": "assets/images/Juz 25.png"},
    {"juz": "Ḥāʾ Mīm", "image": "assets/images/Juz 26.png"},
    {"juz": "Qāla fa-mā khatbukum", "image": "assets/images/Juz 27.png"},
    {"juz": "Qad samiʿa -llāhu", "image": "assets/images/Juz 28.png"},
    {"juz": "Tabāraka -lladhi", "image": "assets/images/Juz 29.png"},
    {"juz": "ʿAmma", "image": "assets/images/Juz 30.png"},
  ];

  /// Pages of Quran Surah

  var pagesSura = [
    1,
    2,
    50,
    77,
    106,
    131,
    151,
    177,
    187,
    208,
    221,
    235,
    249,
    255,
    262,
    267,
    282,
    293,
    305,
    312,
    322,
    332,
    342,
    350,
    359,
    368,
    377,
    385,
    396,
    404,
    411,
    415,
    418,
    428,
    431,
    440,
    446,
    453,
    458,
    467,
    477,
    483,
    489,
    496,
    499,
    502,
    507,
    511,
    515,
    518,
    520,
    523,
    526,
    528,
    531,
    534,
    537,
    542,
    545,
    549,
    551,
    553,
    554,
    555,
    556,
    558,
    560,
    562,
    564,
    566,
    568,
    570,
    572,
    574,
    575,
    577,
    578,
    580,
    582,
    583,
    585,
    586,
    587,
    587,
    589,
    589,
    590,
    591,
    592,
    592,
    594,
    595,
    596,
    596,
    597,
    597,
    598,
    598,
    599,
    599,
    600,
    600,
    601,
    601,
    601,
    602,
    602,
    602,
    602,
    603,
    603,
    603,
    604,
    604,
    604
  ];

  var pages = [
    {"verse": '10', "no": "1"},
    {"verse": '11', "no": "1"},
    {"verse": '12', "no": "1"},
    {"verse": '13', "no": "1"},
    {"verse": '14', "no": "2"},
    {"verse": '15', "no": "3"},
    {"verse": '16', "no": "3"},
    {"verse": '17', "no": "4"},
    {"verse": '20', "no": "2"},
    {"verse": '21', "no": "2"},
    {"verse": '22', "no": "2"},
    {"verse": '23', "no": "2"},
    {"verse": '24', "no": "2"},
    {"verse": '25', "no": "3"},
    {"verse": '26', "no": "4"},
    {"verse": '2:25', "no": "5"},
    {"verse": '2:30', "no": "6"},
    {"verse": '2:38', "no": "7"},
    {"verse": '2:49', "no": "8"},
    {"verse": '2:58', "no": "9"},
    {"verse": '2:62', "no": "10"},
    {"verse": '2:70', "no": "11"},
    {"verse": '2:77', "no": "12"},
    {"verse": '2:84', "no": "13"},
    {"verse": '2:89', "no": "14"},
    {"verse": '2:94', "no": "15"},
    {"verse": '2:102', "no": "16"},
    {"verse": '2:106', "no": "17"},
    {"verse": '2:113', "no": "18"},
    {"verse": '2:120', "no": "19"},
    {"verse": '2:127', "no": "20"},
    {"verse": '2:135', "no": "21"},
    {"verse": '2:142', "no": "22"},
    {"verse": '2:146', "no": "23"},
    {"verse": '2:154', "no": "24"},
    {"verse": '2:164', "no": "25"},
    {"verse": '2:170', "no": "26"},
    {"verse": '2:177', "no": "27"},
    {"verse": '2:182', "no": "28"},
    {"verse": '2:187', "no": "29"},
    {"verse": '2:191', "no": "30"},
    {"verse": '2:197', "no": "31"},
    {"verse": '2:203', "no": "32"},
    {"verse": '2:211', "no": "33"},
    {"verse": '2:216', "no": "34"},
    {"verse": '2:220', "no": "35"},
    {"verse": '2:225', "no": "36"},
    {"verse": '2:231', "no": "37"},
    {"verse": '2:234', "no": "38"},
    {"verse": '2:238', "no": "39"},
    {"verse": '2:246', "no": "40"},
    {"verse": '2:249', "no": "41"},
    {"verse": '2:253', "no": "42"},
    {"verse": '2:257', "no": "43"},
    {"verse": '2:260', "no": "44"},
    {"verse": '2:265', "no": "45"},
    {"verse": '2:270', "no": "46"},
    {"verse": '2:275', "no": "47"},
    {"verse": '2:282', "no": "48"},
    {"verse": '2:283', "no": "49"},
    {"verse": '3:1', "no": "50"},
    {"verse": '3:10', "no": "51"},
    {"verse": '3:16', "no": "52"},
    {"verse": '3:23', "no": "53"},
    {"verse": '3:30', "no": "54"},
    {"verse": '3:38', "no": "55"},
    {"verse": '3:46', "no": "56"},
    {"verse": '3:53', "no": "57"},
    {"verse": '3:62', "no": "58"},
    {"verse": '3:71', "no": "59"},
    {"verse": '3:78', "no": "60"},
    {"verse": '3:84', "no": "61"},
    {"verse": '3:92', "no": "62"},
    {"verse": '3:101', "no": "63"},
    {"verse": '3:109', "no": "64"},
    {"verse": '3:116', "no": "65"},
    {"verse": '3:122', "no": "66"},
    {"verse": '3:133', "no": "67"},
    {"verse": '3:141', "no": "68"},
    {"verse": '3:149', "no": "69"},
    {"verse": '3:154', "no": "70"},
    {"verse": '3:158', "no": "71"},
    {"verse": '3:166', "no": "72"},
    {"verse": '3:174', "no": "73"},
    {"verse": '3:181', "no": "74"},
    {"verse": '3:187', "no": "75"},
    {"verse": '3:195', "no": "76"},
    {"verse": '4:1', "no": "77"},
    {"verse": '4:7', "no": "78"},
    {"verse": '4:12', "no": "79"},
    {"verse": '4:15', "no": "80"},
    {"verse": '4:20', "no": "81"},
    {"verse": '4:24', "no": "82"},
    {"verse": '4:27', "no": "83"},
    {"verse": '4:34', "no": "84"},
    {"verse": '4:38', "no": "85"},
    {"verse": '4:45', "no": "86"},
    {"verse": '4:52', "no": "87"},
    {"verse": '4:60', "no": "88"},
    {"verse": '4:66', "no": "89"},
    {"verse": '4:75', "no": "90"},
    {"verse": '4:80', "no": "91"},
    {"verse": '4:87', "no": "92"},
    {"verse": '4:92', "no": "93"},
    {"verse": '4:95', "no": "94"},
    {"verse": '4:102', "no": "95"},
    {"verse": '4:106', "no": "96"},
    {"verse": '4:114', "no": "97"},
    {"verse": '4:122', "no": "98"},
    {"verse": '4:128', "no": "99"},
    {"verse": '4:135', "no": "100"},
    {"verse": '4:141', "no": "101"},
    {"verse": '4:148', "no": "102"},
    {"verse": '4:155', "no": "103"},
    {"verse": '4:163', "no": "104"},
    {"verse": '4:171', "no": "105"},
    {"verse": '4:176', "no": "106"},
    {"verse": '5:1', "no": "106"},
    {"verse": '5:3', "no": "107"},
    {"verse": '5:6', "no": "108"},
    {"verse": '5:10', "no": "109"},
    {"verse": '5:14', "no": "110"},
    {"verse": '5:18', "no": "111"},
    {"verse": '5:24', "no": "112"},
    {"verse": '5:32', "no": "113"},
    {"verse": '5:37', "no": "114"},
    {"verse": '5:42', "no": "115"},
    {"verse": '5:46', "no": "116"},
    {"verse": '5:51', "no": "117"},
    {"verse": '5:58', "no": "118"},
    {"verse": '5:65', "no": "119"},
    {"verse": '5:71', "no": "120"},
    {"verse": '5:77', "no": "121"},
    {"verse": '5:83', "no": "122"},
    {"verse": '5:90', "no": "123"},
    {"verse": '5:96', "no": "124"},
    {"verse": '5:104', "no": "125"},
    {"verse": '5:109', "no": "126"},
    {"verse": '5:114', "no": "127"},
    {"verse": '6:28', "no": "131"},
    {"verse": '6:36', "no": "132"},
    {"verse": '6:45', "no": "133"},
    {"verse": '6:53', "no": "134"},
    {"verse": '6:60', "no": "135"},
    {"verse": '6:69', "no": "136"},
    {"verse": '6:74', "no": "137"},
    {"verse": '6:82', "no": "138"},
    {"verse": '6:91', "no": "139"},
    {"verse": '6:95', "no": "140"},
    {"verse": '6:102', "no": "141"},
    {"verse": '6:111', "no": "142"},
    {"verse": '6:119', "no": "143"},
    {"verse": '6:125', "no": "144"},
    {"verse": '6:132', "no": "145"},
    {"verse": '6:138', "no": "146"},
    {"verse": '6:143', "no": "147"},
    {"verse": '6:147', "no": "148"},
    {"verse": '6:152', "no": "149"},
    {"verse": '6:158', "no": "150"},
    {"verse": '7:1', "no": "151"},
    {"verse": '7:12', "no": "152"},
    {"verse": '7:23', "no": "153"},
    {"verse": '7:31', "no": "154"},
    {"verse": '7:38', "no": "155"},
    {"verse": '7:44', "no": "156"},
    {"verse": '7:52', "no": "157"},
    {"verse": '7:58', "no": "158"},
    {"verse": '7:68', "no": "159"},
    {"verse": '7:74', "no": "160"},
    {"verse": '7:82', "no": "161"},
    {"verse": '7:88', "no": "162"},
    {"verse": '7:96', "no": "163"},
    {"verse": '7:105', "no": "164"},
    {"verse": '7:121', "no": "165"},
    {"verse": '7:131', "no": "166"},
    {"verse": '7:138', "no": "167"},
    {"verse": '7:144', "no": "168"},
    {"verse": '7:150', "no": "169"},
    {"verse": '7:156', "no": "170"},
    {"verse": '7:160', "no": "171"},
    {"verse": '7:164', "no": "172"},
    {"verse": '7:171', "no": "173"},
    {"verse": '7:179', "no": "174"},
    {"verse": '7:188', "no": "175"},
    {"verse": '7:196', "no": "176"},
    {"verse": '8:1', "no": "177"},
    {"verse": '8:9', "no": "178"},
    {"verse": '8:17', "no": "179"},
    {"verse": '8:26', "no": "180"},
    {"verse": '8:34', "no": "181"},
    {"verse": '8:41', "no": "182"},
    {"verse": '8:46', "no": "183"},
    {"verse": '8:53', "no": "184"},
    {"verse": '8:62', "no": "185"},
    {"verse": '8:70', "no": "186"},
    {"verse": '9:1', "no": "187"},
    {"verse": '9:7', "no": "188"},
    {"verse": '9:14', "no": "189"},
    {"verse": '9:21', "no": "190"},
    {"verse": '9:27', "no": "191"},
    {"verse": '9:32', "no": "192"},
    {"verse": '9:37', "no": "193"},
    {"verse": '9:41', "no": "194"},
    {"verse": '9:48', "no": "195"},
    {"verse": '9:55', "no": "196"},
    {"verse": '9:62', "no": "197"},
    {"verse": '9:69', "no": "198"},
    {"verse": '9:73', "no": "199"},
    {"verse": '9:80', "no": "200"},
    {"verse": '9:87', "no": "201"},
    {"verse": '9:94', "no": "202"},
    {"verse": '9:100', "no": "203"},
    {"verse": '9:107', "no": "204"},
    {"verse": '9:112', "no": "205"},
    {"verse": '9:118', "no": "206"},
    {"verse": '9:123', "no": "207"},
    {"verse": '10:1', "no": "208"},
    {"verse": '10:7', "no": "209"},
    {"verse": '10:15', "no": "210"},
    {"verse": '10:21', "no": "211"},
    {"verse": '10:26', "no": "212"},
    {"verse": '10:34', "no": "213"},
    {"verse": '10:43', "no": "214"},
    {"verse": '10:54', "no": "215"},
    {"verse": '10:62', "no": "216"},
    {"verse": '10:71', "no": "217"},
    {"verse": '10:79', "no": "218"},
    {"verse": '10:89', "no": "219"},
    {"verse": '10:98', "no": "220"},
    {"verse": '10:107', "no": "221"},
    {"verse": '11:1', "no": "221"},
    {"verse": '11:6', "no": "222"},
    {"verse": '11:13', "no": "223"},
    {"verse": '11:20', "no": "224"},
    {"verse": '11:29', "no": "225"},
    {"verse": '11:38', "no": "226"},
    {"verse": '11:46', "no": "227"},
    {"verse": '11:54', "no": "228"},
    {"verse": '11:63', "no": "229"},
    {"verse": '11:72', "no": "230"},
    {"verse": '11:82', "no": "231"},
    {"verse": '11:89', "no": "232"},
    {"verse": '11:98', "no": "233"},
    {"verse": '11:109', "no": "234"},
    {"verse": '11:118', "no": "235"},
    {"verse": '12:1', "no": "235"},
    {"verse": '12:5', "no": "236"},
    {"verse": '12:15', "no": "237"},
    {"verse": '12:23', "no": "238"},
    {"verse": '12:31', "no": "239"},
    {"verse": '12:38', "no": "240"},
    {"verse": '12:44', "no": "241"},
    {"verse": '12:53', "no": "242"},
    {"verse": '12:64', "no": "243"},
    {"verse": '12:70', "no": "244"},
    {"verse": '12:79', "no": "245"},
    {"verse": '12:87', "no": "246"},
    {"verse": '12:96', "no": "247"},
    {"verse": '12:104', "no": "248"},
    {"verse": '13:1', "no": "249"},
    {"verse": '13:6', "no": "250"},
    {"verse": '13:14', "no": "251"},
    {"verse": '13:19', "no": "252"},
    {"verse": '13:29', "no": "253"},
    {"verse": '13:35', "no": "254"},
    {"verse": '13:43', "no": "255"},
    {"verse": '14:1', "no": "255"},
    {"verse": '14:6', "no": "256"},
    {"verse": '14:11', "no": "257"},
    {"verse": '14:19', "no": "258"},
    {"verse": '14:25', "no": "259"},
    {"verse": '14:34', "no": "260"},
    {"verse": '14:43', "no": "261"},
    {"verse": '15:1', "no": "262"},
    {"verse": '15:16', "no": "263"},
    {"verse": '15:32', "no": "264"},
    {"verse": '15:52', "no": "265"},
    {"verse": '15:71', "no": "266"},
    {"verse": '15:91', "no": "267"},
    {"verse": '16:1', "no": "267"},
    {"verse": '16:7', "no": "268"},
    {"verse": '16:15', "no": "269"},
    {"verse": '16:27', "no": "270"},
    {"verse": '16:35', "no": "271"},
    {"verse": '16:43', "no": "272"},
    {"verse": '16:55', "no": "273"},
    {"verse": '16:65', "no": "274"},
    {"verse": '16:73', "no": "275"},
    {"verse": '16:80', "no": "276"},
    {"verse": '16:88', "no": "277"},
    {"verse": '16:94', "no": "278"},
    {"verse": '16:103', "no": "279"},
    {"verse": '16:111', "no": "280"},
    {"verse": '16:119', "no": "281"},
    {"verse": '17:1', "no": "282"},
    {"verse": '17:8', "no": "283"},
    {"verse": '17:18', "no": "284"},
    {"verse": '17:28', "no": "285"},
    {"verse": '17:39', "no": "286"},
    {"verse": '17:50', "no": "287"},
    {"verse": '17:59', "no": "288"},
    {"verse": '17:67', "no": "289"},
    {"verse": '17:76', "no": "290"},
    {"verse": '17:87', "no": "291"},
    {"verse": '17:97', "no": "292"},
    {"verse": '17:105', "no": "293"},
    {"verse": '18:1', "no": "293"},
    {"verse": '18:5', "no": "294"},
    {"verse": '18:16', "no": "295"},
    {"verse": '18:21', "no": "296"},
    {"verse": '18:28', "no": "297"},
    {"verse": '18:35', "no": "298"},
    {"verse": '18:46', "no": "299"},
    {"verse": '18:54', "no": "300"},
    {"verse": '18:62', "no": "301"},
    {"verse": '18:75', "no": "302"},
    {"verse": '18:84', "no": "303"},
    {"verse": '18:98', "no": "304"},
    {"verse": '19:1', "no": "305"},
    {"verse": '19:12', "no": "306"},
    {"verse": '19:26', "no": "307"},
    {"verse": '19:39', "no": "308"},
    {"verse": '19:52', "no": "309"},
    {"verse": '19:65', "no": "310"},
    {"verse": '19:77', "no": "311"},
    {"verse": '19:96', "no": "312"},
    {"verse": '20:1', "no": "312"},
    {"verse": '20:13', "no": "313"},
    {"verse": '20:38', "no": "314"},
    {"verse": '20:52', "no": "315"},
    {"verse": '20:65', "no": "316"},
    {"verse": '20:77', "no": "317"},
    {"verse": '20:88', "no": "318"},
    {"verse": '20:99', "no": "319"},
    {"verse": '20:114', "no": "320"},
    {"verse": '20:126', "no": "321"},
    {"verse": '21:1', "no": "322"},
    {"verse": '21:11', "no": "323"},
    {"verse": '21:25', "no": "324"},
    {"verse": '21:36', "no": "325"},
    {"verse": '21:45', "no": "326"},
    {"verse": '21:58', "no": "327"},
    {"verse": '21:73', "no": "328"},
    {"verse": '21:82', "no": "329"},
    {"verse": '21:91', "no": "330"},
    {"verse": '21:102', "no": "331"},
    {"verse": '22:1', "no": "332"},
    {"verse": '22:6', "no": "333"},
    {"verse": '22:16', "no": "334"},
    {"verse": '22:24', "no": "335"},
    {"verse": '22:31', "no": "336"},
    {"verse": '22:39', "no": "337"},
    {"verse": '22:47', "no": "338"},
    {"verse": '22:56', "no": "339"},
    {"verse": '22:65', "no": "340"},
    {"verse": '22:73', "no": "341"},
    {"verse": '23:1', "no": "342"},
    {"verse": '23:18', "no": "343"},
    {"verse": '23:28', "no": "344"},
    {"verse": '23:43', "no": "345"},
    {"verse": '23:60', "no": "346"},
    {"verse": '23:75', "no": "347"},
    {"verse": '23:90', "no": "348"},
    {"verse": '23:105', "no": "349"},
    {"verse": '24:1', "no": "350"},
    {"verse": '24:11', "no": "351"},
    {"verse": '24:21', "no": "352"},
    {"verse": '24:28', "no": "353"},
    {"verse": '24:32', "no": "354"},
    {"verse": '24:37', "no": "355"},
    {"verse": '24:44', "no": "356"},
    {"verse": '24:54', "no": "357"},
    {"verse": '24:59', "no": "358"},
    {"verse": '24:62', "no": "359"},
    {"verse": '25:1', "no": "359"},
    {"verse": '25:3', "no": "360"},
    {"verse": '25:12', "no": "361"},
    {"verse": '25:21', "no": "362"},
    {"verse": '25:33', "no": "363"},
    {"verse": '25:44', "no": "364"},
    {"verse": '25:56', "no": "365"},
    {"verse": '25:68', "no": "366"},
    {"verse": '26:1', "no": "367"},
    {"verse": '26:25', "no": "368"},
    {"verse": '26:50', "no": "369"},
    {"verse": '26:75', "no": "370"},
    {"verse": '26:100', "no": "371"},
    {"verse": '26:125', "no": "372"},
    {"verse": '26:150', "no": "373"},
    {"verse": '26:175', "no": "374"},
    {"verse": '26:200', "no": "375"},
    {"verse": '26:210', "no": "376"},
    {"verse": '27:220', "no": "377"},
    {"verse": '27:14', "no": "378"},
    {"verse": '27:23', "no": "379"},
    {"verse": '27:36', "no": "380"},
    {"verse": '27:45', "no": "381"},
    {"verse": '27:56', "no": "382"},
    {"verse": '27:64', "no": "383"},
    {"verse": '27:77', "no": "384"},
    {"verse": '27:89', "no": "385"},
    {"verse": '28:1', "no": "385"},
    {"verse": '28:6', "no": "386"},
    {"verse": '28:14', "no": "387"},
    {"verse": '28:22', "no": "388"},
    {"verse": '28:29', "no": "389"},
    {"verse": '28:36', "no": "390"},
    {"verse": '28:44', "no": "391"},
    {"verse": '28:51', "no": "392"},
    {"verse": '28:60', "no": "393"},
    {"verse": '28:71', "no": "394"},
    {"verse": '28:78', "no": "395"},
    {"verse": '28:85', "no": "396"},
    {"verse": '29:1', "no": "396"},
    {"verse": '29:7', "no": "397"},
    {"verse": '29:15', "no": "398"},
    {"verse": '29:24', "no": "399"},
    {"verse": '29:31', "no": "400"},
    {"verse": '29:39', "no": "401"},
    {"verse": '29:46', "no": "402"},
    {"verse": '29:53', "no": "403"},
    {"verse": '29:64', "no": "404"},
    {"verse": '30:1', "no": "404"},
    {"verse": '30:6', "no": "405"},
    {"verse": '30:16', "no": "406"},
    {"verse": '30:25', "no": "407"},
    {"verse": '30:33', "no": "408"},
    {"verse": '30:42', "no": "409"},
    {"verse": '30:51', "no": "410"},
    {"verse": '31:1', "no": "411"},
    {"verse": '31:12', "no": "412"},
    {"verse": '31:20', "no": "413"},
    {"verse": '31:29', "no": "414"},
    {"verse": '32:1', "no": "415"},
    {"verse": '32:12', "no": "416"},
    {"verse": '32:21', "no": "417"},
    {"verse": '33:1', "no": "418"},
    {"verse": '33:7', "no": "419"},
    {"verse": '33:16', "no": "420"},
    {"verse": '33:23', "no": "421"},
    {"verse": '33:31', "no": "422"},
    {"verse": '33:36', "no": "423"},
    {"verse": '33:44', "no": "424"},
    {"verse": '33:51', "no": "425"},
    {"verse": '33:55', "no": "426"},
    {"verse": '33:63', "no": "427"},
    {"verse": '34:1', "no": "428"},
    {"verse": '34:8', "no": "429"},
    {"verse": '34:15', "no": "430"},
    {"verse": '34:23', "no": "431"},
    {"verse": '34:32', "no": "432"},
    {"verse": '34:40', "no": "433"},
    {"verse": '34:49', "no": "434"},
    {"verse": '35:1', "no": "434"},
    {"verse": '35:4', "no": "435"},
    {"verse": '35:12', "no": "436"},
    {"verse": '35:19', "no": "437"},
    {"verse": '35:31', "no": "438"},
    {"verse": '35:39', "no": "439"},
    {"verse": '35:45', "no": "440"},
    {"verse": '36:1', "no": "440"},
    {"verse": '36:13', "no": "441"},
    {"verse": '36:28', "no": "442"},
    {"verse": '36:41', "no": "443"},
    {"verse": '36:55', "no": "444"},
    {"verse": '36:71', "no": "445"},
    {"verse": '37:1', "no": "446"},
    {"verse": '37:25', "no": "447"},
    {"verse": '37:52', "no": "448"},
    {"verse": '37:77', "no": "449"},
    {"verse": '37:103', "no": "450"},
    {"verse": '37:127', "no": "451"},
    {"verse": '37:154', "no": "452"},
    {"verse": '38:1', "no": "453"},
    {"verse": '38:17', "no": "454"},
    {"verse": '38:42', "no": "455"},
    {"verse": '38:61', "no": "456"},
    {"verse": '38:83', "no": "457"},
    {"verse": '39:1', "no": "458"},
    {"verse": '39:6', "no": "459"},
    {"verse": '39:11', "no": "460"},
    {"verse": '39:22', "no": "461"},
    {"verse": '39:32', "no": "462"},
    {"verse": '39:41', "no": "463"},
    {"verse": '39:48', "no": "464"},
    {"verse": '39:57', "no": "465"},
    {"verse": '39:68', "no": "466"},
    {"verse": '39:75', "no": "467"},
    {"verse": '40:1', "no": "467"},
    {"verse": '40:8', "no": "468"},
    {"verse": '40:17', "no": "469"},
    {"verse": '40:26', "no": "470"},
    {"verse": '40:34', "no": "471"},
    {"verse": '40:41', "no": "472"},
    {"verse": '40:50', "no": "473"},
    {"verse": '40:59', "no": "474"},
    {"verse": '40:67', "no": "475"},
    {"verse": '40:78', "no": "476"},
    {"verse": '41:1', "no": "477"},
    {"verse": '41:12', "no": "478"},
    {"verse": '41:21', "no": "479"},
    {"verse": '41:30', "no": "480"},
    {"verse": '41:39', "no": "481"},
    {"verse": '41:47', "no": "482"},
    {"verse": '42:1', "no": "483"},
    {"verse": '42:11', "no": "484"},
    {"verse": '42:16', "no": "485"},
    {"verse": '42:23', "no": "486"},
    {"verse": '42:32', "no": "487"},
    {"verse": '42:45', "no": "488"},
    {"verse": '42:52', "no": "489"},
    {"verse": '43:1', "no": "489"},
    {"verse": '43:11', "no": "490"},
    {"verse": '43:23', "no": "491"},
    {"verse": '43:34', "no": "492"},
    {"verse": '43:48', "no": "493"},
    {"verse": '43:61', "no": "494"},
    {"verse": '43:74', "no": "495"},
    {"verse": '44:1', "no": "496"},
    {"verse": '44:19', "no": "497"},
    {"verse": '44:40', "no": "498"},
    {"verse": '45:1', "no": "499"},
    {"verse": '45:14', "no": "500"},
    {"verse": '45:23', "no": "501"},
    {"verse": '45:33', "no": "502"},
    {"verse": '46:1', "no": "502"},
    {"verse": '46:6', "no": "503"},
    {"verse": '46:15', "no": "504"},
    {"verse": '46:21', "no": "505"},
    {"verse": '46:29', "no": "506"},
    {"verse": '47:1', "no": "507"},
    {"verse": '47:12', "no": "508"},
    {"verse": '47:20', "no": "509"},
    {"verse": '47:30', "no": "510"},
    {"verse": '48:1', "no": "511"},
    {"verse": '48:1', "no": "512"},
    {"verse": '48:1', "no": "513"},
    {"verse": '48:1', "no": "514"},
    {"verse": '48:1', "no": "515"},
    {"verse": '49:1', "no": "515"},
    {"verse": '49:5', "no": "516"},
    {"verse": '49:12', "no": "517"},
    {"verse": '50:1', "no": "518"},
    {"verse": '50:16', "no": "519"},
    {"verse": '50:36', "no": "520"},
    {"verse": '51:1', "no": "520"},
    {"verse": '51:7', "no": "521"},
    {"verse": '51:31', "no": "522"},
    {"verse": '51:52', "no": "523"},
    {"verse": '52:1', "no": "523"},
    {"verse": '52:15', "no": "524"},
    {"verse": '52:32', "no": "525"},
    {"verse": '53:1', "no": "526"},
    {"verse": '53:27', "no": "527"},
    {"verse": '53:45', "no": "528"},
    {"verse": '54:1', "no": "528"},
    {"verse": '54:7', "no": "529"},
    {"verse": '54:28', "no": "530"},
    {"verse": '54:50', "no": "531"},
    {"verse": '55:1', "no": "531"},
    {"verse": '55:17', "no": "532"},
    {"verse": '55:41', "no": "533"},
    {"verse": '55:68', "no": "534"},
    {"verse": '56:1', "no": "534"},
    {"verse": '56:17', "no": "535"},
    {"verse": '56:51', "no": "536"},
    {"verse": '56:77', "no": "537"},
    {"verse": '57:1', "no": "537"},
    {"verse": '57:4', "no": "538"},
    {"verse": '57:12', "no": "539"},
    {"verse": '57:19', "no": "540"},
    {"verse": '57:25', "no": "541"},
    {"verse": '58:1', "no": "542"},
    {"verse": '58:7', "no": "543"},
    {"verse": '58:12', "no": "544"},
    {"verse": '58:22', "no": "545"},
    {"verse": '59:1', "no": "545"},
    {"verse": '59:4', "no": "546"},
    {"verse": '59:10', "no": "547"},
    {"verse": '59:17', "no": "548"},
    {"verse": '60:1', "no": "549"},
    {"verse": '60:6', "no": "550"},
    {"verse": '60:12', "no": "551"},
    {"verse": '61:1', "no": "551"},
    {"verse": '61:6', "no": "552"},
    {"verse": '62:1', "no": "553"},
    {"verse": '62:9', "no": "554"},
    {"verse": '63:1', "no": "554"},
    {"verse": '63:5', "no": "555"},
    {"verse": '64:1', "no": "556"},
    {"verse": '64:10', "no": "557"},
    {"verse": '65:1', "no": "558"},
    {"verse": '65:6', "no": "559"},
    {"verse": '66:1', "no": "560"},
    {"verse": '66:8', "no": "561"},
    {"verse": '67:1', "no": "562"},
    {"verse": '67:13', "no": "563"},
    {"verse": '67:27', "no": "564"},
    {"verse": '68:1', "no": "564"},
    {"verse": '68:16', "no": "565"},
    {"verse": '68:43', "no": "566"},
    {"verse": '69:1', "no": "566"},
    {"verse": '69:9', "no": "567"},
    {"verse": '69:35', "no": "568"},
    {"verse": '70:1', "no": "568"},
    {"verse": '70:11', "no": "569"},
    {"verse": '70:40', "no": "570"},
    {"verse": '71:1', "no": "570"},
    {"verse": '71:11', "no": "571"},
    {"verse": '72:1', "no": "572"},
    {"verse": '72:14', "no": "573"},
    {"verse": '73:1', "no": "574"},
    {"verse": "73:20", "no": '575'},
    {"verse": '74:1', "no": "575"},
    {"verse": '74:18', "no": "576"},
    {"verse": '74:47', "no": "577"},
    {"verse": '75:1', "no": "577"},
    {"verse": '75:20', "no": "578"},
    {"verse": '76:1', "no": "578"},
    {"verse": '76:6', "no": "579"},
    {"verse": '76:26', "no": "580"},
    {"verse": '77:1', "no": "580"},
    {"verse": '77:20', "no": "581"},
    {"verse": '78:1', "no": "582"},
    {"verse": '78:31', "no": "583"},
    {"verse": '79:1', "no": "583"},
    {"verse": '79:16', "no": "584"},
    {"verse": '80:1', "no": "585"},
    {"verse": '81:1', "no": "586"},
    {"verse": '82:1', "no": "587"},
    {"verse": '83:1', "no": "587"},
    {"verse": '83:7', "no": "588"},
    {"verse": '83:35', "no": "589"},
    {"verse": '84:1', "no": "589"},
    {"verse": '85:1', "no": "590"},
    {"verse": '86:1', "no": "591"},
    {"verse": '87:1', "no": "591"},
    {"verse": '87:16', "no": "592"},
    {"verse": '88:1', "no": "592"},
    {"verse": '89:1', "no": "593"},
    {"verse": '89:23', "no": "594"},
    {"verse": '90:1', "no": "594"},
    {"verse": '91:1', "no": "595"},
    {"verse": '92:1', "no": "595"},
    {"verse": '92:15', "no": "596"},
    {"verse": '93:1', "no": "596"},
    {"verse": '94:1', "no": "596"},
    {"verse": '95:1', "no": "597"},
    {"verse": '96:1', "no": "597"},
    {"verse": '97:1', "no": "598"},
    {"verse": '98:1', "no": "598"},
    {"verse": '98:8', "no": "599"},
    {"verse": '99:1', "no": "599"},
    {"verse": '100:1', "no": "599"},
    {"verse": '100:10', "no": "600"},
    {"verse": '101:1', "no": "600"},
    {"verse": '102:1', "no": "600"},
    {"verse": '103:1', "no": "601"},
    {"verse": '104:1', "no": "601"},
    {"verse": '105:1', "no": "601"},
    {"verse": '106:1', "no": "602"},
    {"verse": '107:1', "no": "602"},
    {"verse": '108:1', "no": "602"},
    {"verse": '109:1', "no": "603"},
    {"verse": '110:1', "no": "603"},
    {"verse": '111:1', "no": "603"},
    {"verse": '112:1', "no": "604"},
    {"verse": '113:1', "no": "604"},
    {"verse": '114:1', "no": "604"},
  ];
}
