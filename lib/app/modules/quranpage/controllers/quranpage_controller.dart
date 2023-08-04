import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
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
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();



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
  void copyToClipboard(var index) {
      Clipboard.setData(ClipboardData(text: "${copy}"));
    Get.snackbar('Copied', 'Text copied to clipboard!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1));
  }

copyText(var index){
  if (copy.contains(index)) {
    Clipboard.setData(ClipboardData(text: "$index"));
  }
  Get.snackbar('Copied', 'Text copied to clipboard!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 1));
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


  /// sura title arabic
  var images = [{"sura": "Al-Fatihah", "image":"assets/images/1. Al-Fatihah.png"},
    {"sura": "Al-Baqarah", "image":"assets/images/2. Al-Baqarah.png"},
    {"sura": "Ali 'Imran", "image":"assets/images/3. Ali-Imran.png"},
    {"sura": "An-Nisa", "image":"assets/images/4. An-Nisa.png"},
    {"sura": "Al-Ma'idah", "image":"assets/images/5. Al-Maidah.png"},
    {"sura": "Al-An'am", "image":"assets/images/6. Al-Anam.png"},
    {"sura": "Al-A'raf", "image":"assets/images/7. Al-Araf.png"},
    {"sura": "Al-Anfal", "image":"assets/images/8. AL-Anfal.png"},
    {"sura": "At-Tawbah", "image":"assets/images/9. At-Tawbah.png"},
    {"sura": "Yunus", "image":"assets/images/10. Yunus.png"},
    {"sura": "Hud", "image":"assets/images/11. Hud.png"},
    {"sura": "Yusuf", "image":"assets/images/12. Yusuf.png"},
    {"sura": "Ar-Ra'd", "image":"assets/images/13. Ar-Rad.png"},
    {"sura": "Ibrahim", "image":"assets/images/14. Ibrahim.png"},
    {"sura": "Al-Hijr", "image":"assets/images/15. Al-Hijr.png"},
    {"sura": "An-Nahl", "image":"assets/images/16. An-Nahl.png"},
    {"sura": "Al-Isra", "image":"assets/images/17. Al-Isra.png"},
    {"sura": "Al-Kahf", "image":"assets/images/18. Al-Kahf.png"},
    {"sura": "Maryam", "image":"assets/images/19. Maryam.png"},
    {"sura": "Taha", "image":"assets/images/20. Taha.png"},
    {"sura": "Al-Anbya", "image":"assets/images/21. Al-Anbya.png"},
    {"sura": "Al-Hajj", "image":"assets/images/22. Al-Hajj.png"},
    {"sura": "Al-Mu'minun", "image":"assets/images/23. Al-Muminum.png"},
    {"sura": "An-Nur", "image":"assets/images/24. An-Nur.png"},
    {"sura": "Al-Furqan", "image":"assets/images/25. Al-Furqan.png"},
    {"sura": "Ash-Shu'ara", "image":"assets/images/26. Ash-Shuara.png"},
    {"sura": "An-Naml", "image":"assets/images/27. An-Naml.png"},
    {"sura": "Al-Qasas", "image":"assets/images/28. Al-Qasas.png"},
    {"sura": "Al-'Ankabut", "image":"assets/images/29. Al-Ankabut.png"},
    {"sura": "Ar-Rum", "image":"assets/images/30. Ar-Rum.png"},
    {"sura": "Luqman", "image":"assets/images/31. Luqman.png"},
    {"sura": "As-Sajdah", "image":"assets/images/32. As-Sajdah.png"},
    {"sura": "Al-Ahzab", "image":"assets/images/33. Al-Ahzab.png"},
    {"sura": "Saba", "image":"assets/images/34. Saba.png"},
    {"sura": "Fatir", "image":"assets/images/35. Fatir.png"},
    {"sura": "Ya-Sin", "image":"assets/images/36. Ya-Sin.png"},
    {"sura": "AsSaffat", "image":"assets/images/37. As-Saffat.png"},
    {"sura": "Sad", "image":"assets/images/38. Sad.png"},
    {"sura": "Az-Zumar", "image":"assets/images/39. Az-Zumar.png"},
    {"sura": "Ghafir", "image":"assets/images/40. Ghahir.png"},
    {"sura": "Fussilat", "image":"assets/images/41. Fussilat.png"},
    {"sura": "Ash-Shuraa", "image":"assets/images/42. Ash-Shuraa.png"},
    {"sura": "Az-Zukhruf", "image":"assets/images/43. Az-Zukhruf.png"},
    {"sura": "Ad-Dukhan", "image":"assets/images/44. Ad-Dukhan.png"},
    {"sura": "Al-Jathiyah", "image":"assets/images/45. Al-Jathiyah.png"},
    {"sura": "Al-Ahqaf", "image":"assets/images/46. Al-Ahqaf.png"},
    {"sura": "Muhammad", "image":"assets/images/47. Muhammad.png"},
    {"sura": "Al-Fath", "image":"assets/images/48. Al-Fath.png"},
    {"sura": "Al-Hujurat", "image":"assets/images/49. Al-Hujurat.png"},
    {"sura": "Qaf", "image":"assets/images/50. Qaf.png"},
    {"sura": "Adh-Dhariyat", "image":"assets/images/51. Adh-Dhariyat.png"},
    {"sura": "At-Tur", "image":"assets/images/52. At-Tur.png"},
    {"sura": "An-Najm", "image":"assets/images/53. An-Najm.png"},
    {"sura": "Al-Qamar", "image":"assets/images/54. Al-Qamar.png"},
    {"sura": "Ar-Rahman", "image":"assets/images/55. Ar-Rahman.png"},
    {"sura": "Al-Waqi'ah", "image":"assets/images/56. Al-Waqiah.png"},
    {"sura": "Al-Hadid", "image":"assets/images/57. Al-Hadid.png"},
    {"sura": "Al-Mujadila", "image":"assets/images/58. Al-Mujadila.png"},
    {"sura": "Al-Hashr", "image":"assets/images/59. Al-Hashr.png"},
    {"sura": "Al-Mumtahanah", "image":"assets/images/60. Al-Mumtahanah.png"},
    {"sura": "As-Saf", "image":"assets/images/61. As-Saf.png"},
    {"sura": "Al-Jumu'ah", "image":"assets/images/62. Al-Jumuah.png"},
    {"sura": "Al-Munafiqun", "image":"assets/images/63. Al-Munafiqun.png"},
    {"sura": "At-Taghabun", "image":"assets/images/64. At-Taghabun.png"},
    {"sura": "At-Talaq", "image":"assets/images/65. At-Talaq.png"},
    {"sura": "At-Tahrim", "image":"assets/images/66. At-Tahrim.png"},
    {"sura": "Al-Mulk", "image":"assets/images/67. Al-Mulk.png"},
    {"sura": "Al-Qalam", "image":"assets/images/68. Al-Qalam.png"},
    {"sura": "Al-Haqqah", "image":"assets/images/69. Al-Haqqah.png"},
    {"sura": "Al-Ma'arij", "image":"assets/images/70. Al-Maarij.png"},
    {"sura": "Nuh", "image":"assets/images/71. Nuh.png"},
    {"sura": "Al-Jinn", "image":"assets/images/72. Al-Jinn.png"},
    {"sura": "Al-Muzzammil", "image":"assets/images/73. Al-Muzzammil.png"},
    {"sura": "Al-Muddaththir", "image":"assets/images/74. Al-Muddaththir.png"},
    {"sura": "Al-Qiyamah", "image":"assets/images/75. Al-Qiyamah.png"},
    {"sura": "Al-Insan", "image":"assets/images/76. Al-Insan.png"},
    {"sura": "Al-Mursalat", "image":"assets/images/77. Al-Mursalat.png"},
    {"sura": "An-Naba", "image":"assets/images/78. An-Naba.png"},
    {"sura": "An-Nazi'at", "image":"assets/images/79. An-Naziat.png"},
    {"sura": "'Abasa", "image":"assets/images/80. Abasa.png"},
    {"sura": "At-Takwir", "image":"assets/images/81. At-Takwir.png"},
    {"sura": "Al-Infitar", "image":"assets/images/82. Al-Infitar.png"},
    {"sura": "Al-Mutaffifin", "image":"assets/images/83. Al-Mutaffifin.png"},
    {"sura": "Al-Inshiqaq", "image":"assets/images/84. Al-Inshiqaq.png"},
    {"sura": "Al-Buruj", "image":"assets/images/85. Al-Buruj.png"},
    {"sura": "At-Tariq", "image":"assets/images/86. At-Tariq.png"},
    {"sura": "Al-A'la", "image":"assets/images/87. Al-ala.png"},
    {"sura": "Al-Ghashiyah", "image":"assets/images/88. Al-Ghashiyah.png"},
    {"sura": "Al-Fajr", "image":"assets/images/89. Al-Fajr.png"},
    {"sura": "Al-Balad", "image":"assets/images/90. Al-Balad.png"},
    {"sura": "Ash-Shams", "image":"assets/images/91. Ash-Shams.png"},
    {"sura": "Al-Layl", "image":"assets/images/92. Al-Layl.png"},
    {"sura": "Ad-Duhaa", "image":"assets/images/93. Ad-Duhaa.png"},
    {"sura": "Ash-Sharh", "image":"assets/images/94. Ash-Sharh.png"},
    {"sura": "At-Tin", "image":"assets/images/95. At-Tin.png"},
    {"sura": "Al-'Alaq", "image":"assets/images/96. Al-Alaq.png"},
    {"sura": "Al-Qadr", "image":"assets/images/97. Al-Qadr.png"},
    {"sura": "Al-Bayyinah", "image":"assets/images/98. Al-Bayyinah.png"},
    {"sura": "Az-Zalzalah", "image":"assets/images/99. Az-Zalzalah.png"},
    {"sura": "Al-'Adiyat", "image":"assets/images/100. Al-Adiyat.png"},
    {"sura": "Al-Qari'ah", "image":"assets/images/101. Al-Qariah.png"},
    {"sura": "At-Takathur", "image":"assets/images/102. At-Takathur.png"},
    {"sura": "Al-'Asr", "image":"assets/images/103. Al-Asr.png"},
    {"sura": "Al-Humazah", "image":"assets/images/104. Al-Humazah.png"},
    {"sura": "Al-Fil", "image":"assets/images/105. Al-Fil.png"},
    {"sura": "Quraysh", "image":"assets/images/106. Quraysh.png"},
    {"sura": "Al-Ma'un", "image":"assets/images/107. Al-Maun.png"},
    {"sura": "Al-Kawthar", "image":"assets/images/108. Al-Kawthar.png"},
    {"sura": "Al-Kafirun", "image":"assets/images/109. Al-Kafirun.png"},
    {"sura": "An-Nasr", "image":"assets/images/110. An-Nasr.png"},
    {"sura": "Al-Masad", "image":"assets/images/111. Al-Masad.png"},
    {"sura": "Al-Ikhlas", "image":"assets/images/112. Al-Ikhlas.png"},
    {"sura": "Al-Falaq", "image":"assets/images/113. Al-Falaq.png"},
    {"sura": "AnNas", "image":"assets/images/114. An-last.png"},
   ];

  /// Pages of Quran Surah

  var  pages=[ {"verse":'1:1',"no":"1"},{"verse":'2:1',"no":"2"}, {"verse":'2:6',"no":"3"}, {"verse":'2:17',"no":"4"}, {"verse":'2:25',"no":"5"}, {"verse":'2:30',"no":"6"}, {"verse":'2:38',"no":"7"}, {"verse":'2:49',"no":"8"}, {"verse":'2:58',"no":"9"}, {"verse":'2:62',"no":"10"}, {"verse":'2:70',"no":"11"}, {"verse":'2:77',"no":"12"}, {"verse":'2:84',"no":"13"}, {"verse":'2:89',"no":"14"}, {"verse":'2:94',"no":"15"}, {"verse":'2:102',"no":"16"}, {"verse":'2:106',"no":"17"}, {"verse":'2:113',"no":"18"}, {"verse":'2:120',"no":"19"}, {"verse":'2:127',"no":"20"}, {"verse":'2:135',"no":"21"}, {"verse":'2:142',"no":"22"}, {"verse":'2:146',"no":"23"}, {"verse":'2:154',"no":"24"}, {"verse":'2:164',"no":"25"}, {"verse":'2:170',"no":"26"}, {"verse":'2:177',"no":"27"}, {"verse":'2:182',"no":"28"}, {"verse":'2:187',"no":"29"}, {"verse":'2:191',"no":"30"}, {"verse":'2:197',"no":"31"}, {"verse":'2:203',"no":"32"}, {"verse":'2:211',"no":"33"}, {"verse":'2:216',"no":"34"}, {"verse":'2:220',"no":"35"}, {"verse":'2:225',"no":"36"}, {"verse":'2:231',"no":"37"}, {"verse":'2:234',"no":"38"}, {"verse":'2:238',"no":"39"}, {"verse":'2:246',"no":"40"}, {"verse":'2:249',"no":"41"}, {"verse":'2:253',"no":"42"}, {"verse":'2:257',"no":"43"}, {"verse":'2:260',"no":"44"}, {"verse":'2:265',"no":"45"}, {"verse":'2:270',"no":"46"}, {"verse":'2:275',"no":"47"}, {"verse":'2:282',"no":"48"}, {"verse":'2:283',"no":"49"},{"verse":'3:1',"no":"50"},
    {"verse":'3:10',"no":"51"},
    {"verse":'3:16',"no":"52"},
    {"verse":'3:23',"no":"53"},
    {"verse":'3:30',"no":"54"},
    {"verse":'3:38',"no":"55"},
    {"verse":'3:46',"no":"56"},
    {"verse":'3:53',"no":"57"},
    {"verse":'3:62',"no":"58"},
    {"verse":'3:71',"no":"59"},
    {"verse":'3:78',"no":"60"},
    {"verse":'3:84',"no":"61"},
    {"verse":'3:92',"no":"62"},
    {"verse":'3:101',"no":"63"},
    {"verse":'3:109',"no":"64"},
    {"verse":'3:116',"no":"65"},
    {"verse":'3:122',"no":"66"},
    {"verse":'3:133',"no":"67"},
    {"verse":'3:141',"no":"68"},
    {"verse":'3:149',"no":"69"},
    {"verse":'3:154',"no":"70"},
    {"verse":'3:158',"no":"71"},
    {"verse":'3:166',"no":"72"},
    {"verse":'3:174',"no":"73"},
    {"verse":'3:181',"no":"74"},
    {"verse":'3:187',"no":"75"},
    {"verse":'3:195',"no":"76"},
    {"verse":'4:1',"no":"77"},
    {"verse":'4:7',"no":"78"},
    {"verse":'4:12',"no":"79"},
    {"verse":'4:15',"no":"80"},
    {"verse":'4:20',"no":"81"},
    {"verse":'4:24',"no":"82"},
    {"verse":'4:27',"no":"83"},
    {"verse":'4:34',"no":"84"},
    {"verse":'4:38',"no":"85"},
    {"verse":'4:45',"no":"86"},
    {"verse":'4:52',"no":"87"},
    {"verse":'4:60',"no":"88"},
    {"verse":'4:66',"no":"89"},
    {"verse":'4:75',"no":"90"},
    {"verse":'4:80',"no":"91"},
    {"verse":'4:87',"no":"92"},
    {"verse":'4:92',"no":"93"},
    {"verse":'4:95',"no":"94"},
    {"verse":'4:102',"no":"95"},
    {"verse":'4:106',"no":"96"},
    {"verse":'4:114',"no":"97"},
    {"verse":'4:122',"no":"98"},
    {"verse":'4:128',"no":"99"},
    {"verse":'4:135',"no":"100"},
    {"verse":'4:141',"no":"101"},
    {"verse":'4:148',"no":"102"},
    {"verse":'4:155',"no":"103"},
    {"verse":'4:163',"no":"104"},
    {"verse":'4:171',"no":"105"},
    {"verse":'4:176',"no":"106"},
    {"verse":'5:1',"no":"106"},
    {"verse":'5:3',"no":"107"},
    {"verse":'5:6',"no":"108"},
    {"verse":'5:10',"no":"109"},
    {"verse":'5:14',"no":"110"},
    {"verse":'5:18',"no":"111"},
    {"verse":'5:24',"no":"112"},
    {"verse":'5:32',"no":"113"},
    {"verse":'5:37',"no":"114"},
    {"verse":'5:42',"no":"115"},
    {"verse":'5:46',"no":"116"},
    {"verse":'5:51',"no":"117"},
    {"verse":'5:58',"no":"118"},
    {"verse":'5:65',"no":"119"},
    {"verse":'5:71',"no":"120"},
    {"verse":'5:77',"no":"121"},
    {"verse":'5:83',"no":"122"},
    {"verse":'5:90',"no":"123"},
    {"verse":'5:96',"no":"124"},
    {"verse":'5:104',"no":"125"},
    {"verse":'5:109',"no":"126"},
    {"verse":'5:114',"no":"127"},
    {"verse":'6:28',"no":"131"},
    {"verse":'6:36',"no":"132"},
    {"verse":'6:45',"no":"133"},
    {"verse":'6:53',"no":"134"},
    {"verse":'6:60',"no":"135"},
    {"verse":'6:69',"no":"136"},
    {"verse":'6:74',"no":"137"},
    {"verse":'6:82',"no":"138"},
    {"verse":'6:91',"no":"139"},
    {"verse":'6:95',"no":"140"},
    {"verse":'6:102',"no":"141"},
    {"verse":'6:111',"no":"142"},
    {"verse":'6:119',"no":"143"},
    {"verse":'6:125',"no":"144"},
    {"verse":'6:132',"no":"145"},
    {"verse":'6:138',"no":"146"},
    {"verse":'6:143',"no":"147"},
    {"verse":'6:147',"no":"148"},
    {"verse":'6:152',"no":"149"},
    {"verse":'6:158',"no":"150"},
    {"verse":'7:1',"no":"151"},
    {"verse":'7:12',"no":"152"},
    {"verse":'7:23',"no":"153"},
    {"verse":'7:31',"no":"154"},
    {"verse":'7:38',"no":"155"},
    {"verse":'7:44',"no":"156"},
    {"verse":'7:52',"no":"157"},
    {"verse":'7:58',"no":"158"},
    {"verse":'7:68',"no":"159"},
    {"verse":'7:74',"no":"160"},
    {"verse":'7:82',"no":"161"},
    {"verse":'7:88',"no":"162"},
    {"verse":'7:96',"no":"163"},
    {"verse":'7:105',"no":"164"},
    {"verse":'7:121',"no":"165"},
    {"verse":'7:131',"no":"166"},
    {"verse":'7:138',"no":"167"},
    {"verse":'7:144',"no":"168"},
    {"verse":'7:150',"no":"169"},
    {"verse":'7:156',"no":"170"},
    {"verse":'7:160',"no":"171"},
    {"verse":'7:164',"no":"172"},
    {"verse":'7:171',"no":"173"},
    {"verse":'7:179',"no":"174"},
    {"verse":'7:188',"no":"175"},
    {"verse":'7:196',"no":"176"},
    {"verse":'8:1',"no":"177"},
    {"verse":'8:9',"no":"178"},
    {"verse":'8:17',"no":"179"},
    {"verse":'8:26',"no":"180"},
    {"verse":'8:34',"no":"181"},
    {"verse":'8:41',"no":"182"},
    {"verse":'8:46',"no":"183"},
    {"verse":'8:53',"no":"184"},
    {"verse":'8:62',"no":"185"},
    {"verse":'8:70',"no":"186"},
    {"verse":'9:1',"no":"187"},
    {"verse":'9:7',"no":"188"},
    {"verse":'9:14',"no":"189"},
    {"verse":'9:21',"no":"190"},
    {"verse":'9:27',"no":"191"},
    {"verse":'9:32',"no":"192"},
    {"verse":'9:37',"no":"193"},
    {"verse":'9:41',"no":"194"},
    {"verse":'9:48',"no":"195"},
    {"verse":'9:55',"no":"196"},
    {"verse":'9:62',"no":"197"},
    {"verse":'9:69',"no":"198"},
    {"verse":'9:73',"no":"199"},
    {"verse":'9:80',"no":"200"},
    {"verse":'9:87',"no":"201"},
    {"verse":'9:94',"no":"202"},
    {"verse":'9:100',"no":"203"},
    {"verse":'9:107',"no":"204"},
    {"verse":'9:112',"no":"205"},
    {"verse":'9:118',"no":"206"},
    {"verse":'9:123',"no":"207"},
    {"verse":'10:1',"no":"208"},
    {"verse":'10:7',"no":"209"},
    {"verse":'10:15',"no":"210"},
    {"verse":'10:21',"no":"211"},
    {"verse":'10:26',"no":"212"},
    {"verse":'10:34',"no":"213"},
    {"verse":'10:43',"no":"214"},
    {"verse":'10:54',"no":"215"},
    {"verse":'10:62',"no":"216"},
    {"verse":'10:71',"no":"217"},
    {"verse":'10:79',"no":"218"},
    {"verse":'10:89',"no":"219"},
    {"verse":'10:98',"no":"220"},
    {"verse":'10:107',"no":"221"},
    {"verse":'11:1',"no":"221"},
    {"verse":'11:6',"no":"222"},
    {"verse":'11:13',"no":"223"},
    {"verse":'11:20',"no":"224"},
    {"verse":'11:29',"no":"225"},
    {"verse":'11:38',"no":"226"},
    {"verse":'11:46',"no":"227"},
    {"verse":'11:54',"no":"228"},
    {"verse":'11:63',"no":"229"},
    {"verse":'11:72',"no":"230"},
    {"verse":'11:82',"no":"231"},
    {"verse":'11:89',"no":"232"},
    {"verse":'11:98',"no":"233"},
    {"verse":'11:109',"no":"234"},
    {"verse":'11:118',"no":"235"},
    {"verse":'12:1',"no":"235"},
    {"verse":'12:5',"no":"236"},
    {"verse":'12:15',"no":"237"},
    {"verse":'12:23',"no":"238"},
    {"verse":'12:31',"no":"239"},
    {"verse":'12:38',"no":"240"},
    {"verse":'12:44',"no":"241"},
    {"verse":'12:53',"no":"242"},
    {"verse":'12:64',"no":"243"},
    {"verse":'12:70',"no":"244"},
    {"verse":'12:79',"no":"245"},
    {"verse":'12:87',"no":"246"},
    {"verse":'12:96',"no":"247"},
    {"verse":'12:104',"no":"248"},
    {"verse":'13:1',"no":"249"},
    {"verse":'13:6',"no":"250"},
    {"verse":'13:14',"no":"251"},
    {"verse":'13:19',"no":"252"},
    {"verse":'13:29',"no":"253"},
    {"verse":'13:35',"no":"254"},
    {"verse":'13:43',"no":"255"},
    {"verse":'14:1',"no":"255"},
    {"verse":'14:6',"no":"256"},
    {"verse":'14:11',"no":"257"},
    {"verse":'14:19',"no":"258"},
    {"verse":'14:25',"no":"259"},
    {"verse":'14:34',"no":"260"},
    {"verse":'14:43',"no":"261"},
    {"verse":'15:1',"no":"262"},
    {"verse":'15:16',"no":"263"},
    {"verse":'15:32',"no":"264"},
    {"verse":'15:52',"no":"265"},
    {"verse":'15:71',"no":"266"},
    {"verse":'15:91',"no":"267"},
    {"verse":'16:1',"no":"267"},
    {"verse":'16:7',"no":"268"},
    {"verse":'16:15',"no":"269"},
    {"verse":'16:27',"no":"270"},
    {"verse":'16:35',"no":"271"},
    {"verse":'16:43',"no":"272"},
    {"verse":'16:55',"no":"273"},
    {"verse":'16:65',"no":"274"},
    {"verse":'16:73',"no":"275"},
    {"verse":'16:80',"no":"276"},
    {"verse":'16:88',"no":"277"},
    {"verse":'16:94',"no":"278"},
    {"verse":'16:103',"no":"279"},
    {"verse":'16:111',"no":"280"},
    {"verse":'16:119',"no":"281"},
    {"verse":'17:1',"no":"282"},
    {"verse":'17:8',"no":"283"},
    {"verse":'17:18',"no":"284"},
    {"verse":'17:28',"no":"285"},
    {"verse":'17:39',"no":"286"},
    {"verse":'17:50',"no":"287"},
    {"verse":'17:59',"no":"288"},
    {"verse":'17:67',"no":"289"},
    {"verse":'17:76',"no":"290"},
    {"verse":'17:87',"no":"291"},
    {"verse":'17:97',"no":"292"},
    {"verse":'17:105',"no":"293"},
    {"verse":'18:1',"no":"293"},
    {"verse":'18:5',"no":"294"},
    {"verse":'18:16',"no":"295"},
    {"verse":'18:21',"no":"296"},
    {"verse":'18:28',"no":"297"},
    {"verse":'18:35',"no":"298"},
    {"verse":'18:46',"no":"299"},
    {"verse":'18:54',"no":"300"},
    {"verse":'18:62',"no":"301"},
    {"verse":'18:75',"no":"302"},
    {"verse":'18:84',"no":"303"},
    {"verse":'18:98',"no":"304"},
    {"verse":'19:1',"no":"305"},
    {"verse":'19:12',"no":"306"},
    {"verse":'19:26',"no":"307"},
    {"verse":'19:39',"no":"308"},
    {"verse":'19:52',"no":"309"},
    {"verse":'19:65',"no":"310"},
    {"verse":'19:77',"no":"311"},
    {"verse":'19:96',"no":"312"},
    {"verse":'20:1',"no":"312"},
    {"verse":'20:13',"no":"313"},
    {"verse":'20:38',"no":"314"},
    {"verse":'20:52',"no":"315"},
    {"verse":'20:65',"no":"316"},
    {"verse":'20:77',"no":"317"},
    {"verse":'20:88',"no":"318"},
    {"verse":'20:99',"no":"319"},
    {"verse":'20:114',"no":"320"},
    {"verse":'20:126',"no":"321"},
    {"verse":'21:1',"no":"322"},
    {"verse":'21:11',"no":"323"},
    {"verse":'21:25',"no":"324"},
    {"verse":'21:36',"no":"325"},
    {"verse":'21:45',"no":"326"},
    {"verse":'21:58',"no":"327"},
    {"verse":'21:73',"no":"328"},
    {"verse":'21:82',"no":"329"},
    {"verse":'21:91',"no":"330"},
    {"verse":'21:102',"no":"331"},
    {"verse":'22:1',"no":"332"},
    {"verse":'22:6',"no":"333"},
    {"verse":'22:16',"no":"334"},
    {"verse":'22:24',"no":"335"},
    {"verse":'22:31',"no":"336"},
    {"verse":'22:39',"no":"337"},
    {"verse":'22:47',"no":"338"},
    {"verse":'22:56',"no":"339"},
    {"verse":'22:65',"no":"340"},
    {"verse":'22:73',"no":"341"},
    {"verse":'23:1',"no":"342"},
    {"verse":'23:18',"no":"343"},
    {"verse":'23:28',"no":"344"},
    {"verse":'23:43',"no":"345"},
    {"verse":'23:60',"no":"346"},
    {"verse":'23:75',"no":"347"},
    {"verse":'23:90',"no":"348"},
    {"verse":'23:105',"no":"349"},
    {"verse":'24:1',"no":"350"},
    {"verse":'24:11',"no":"351"},
    {"verse":'24:21',"no":"352"},
    {"verse":'24:28',"no":"353"},
    {"verse":'24:32',"no":"354"},
    {"verse":'24:37',"no":"355"},
    {"verse":'24:44',"no":"356"},
    {"verse":'24:54',"no":"357"},
    {"verse":'24:59',"no":"358"},
    {"verse":'24:62',"no":"359"},
    {"verse":'25:1',"no":"359"},
    {"verse":'25:3',"no":"360"},
    {"verse":'25:12',"no":"361"},
    {"verse":'25:21',"no":"362"},
    {"verse":'25:33',"no":"363"},
    {"verse":'25:44',"no":"364"},
    {"verse":'25:56',"no":"365"},
    {"verse":'25:68',"no":"366"},
    {"verse":'26:1',"no":"367"},
    {"verse":'26:1',"no":"368"},
    {"verse":'26:1',"no":"369"},
    {"verse":'26:1',"no":"370"},
    {"verse":'26:1',"no":"371"},
    {"verse":'26:1',"no":"372"},
    {"verse":'26:1',"no":"373"},
    {"verse":'26:1',"no":"374"},
    {"verse":'26:1',"no":"375"},
    {"verse":'26:1',"no":"376"},
    {"verse":'27:1',"no":"377"},
    {"verse":'27:14',"no":"378"},
    {"verse":'27:23',"no":"379"},
    {"verse":'27:36',"no":"380"},
    {"verse":'27:45',"no":"381"},
    {"verse":'27:56',"no":"382"},
    {"verse":'27:64',"no":"383"},
    {"verse":'27:77',"no":"384"},
    {"verse":'27:89',"no":"385"},
    {"verse":'28:1',"no":"385"},
    {"verse":'28:6',"no":"386"},
    {"verse":'28:14',"no":"387"},
    {"verse":'28:22',"no":"388"},
    {"verse":'28:29',"no":"389"},
    {"verse":'28:36',"no":"390"},
    {"verse":'28:44',"no":"391"},
    {"verse":'28:51',"no":"392"},
    {"verse":'28:60',"no":"393"},
    {"verse":'28:71',"no":"394"},
    {"verse":'28:78',"no":"395"},
    {"verse":'28:85',"no":"396"},
    {"verse":'29:1',"no":"396"},
    {"verse":'29:7',"no":"397"},
    {"verse":'29:15',"no":"398"},
    {"verse":'29:24',"no":"399"},
    {"verse":'29:31',"no":"400"},
    {"verse":'29:39',"no":"401"},
    {"verse":'29:46',"no":"402"},
    {"verse":'29:53',"no":"403"},
    {"verse":'29:64',"no":"404"},
    {"verse":'30:1',"no":"404"},
    {"verse":'30:6',"no":"405"},
    {"verse":'30:16',"no":"406"},
    {"verse":'30:25',"no":"407"},
    {"verse":'30:33',"no":"408"},
    {"verse":'30:42',"no":"409"},
    {"verse":'30:51',"no":"410"},
    {"verse":'31:1',"no":"411"},
    {"verse":'31:12',"no":"412"},
    {"verse":'31:20',"no":"413"},
    {"verse":'31:29',"no":"414"},
    {"verse":'32:1',"no":"415"},
    {"verse":'32:12',"no":"416"},
    {"verse":'32:21',"no":"417"},
    {"verse":'33:1',"no":"418"},
    {"verse":'33:7',"no":"419"},
    {"verse":'33:16',"no":"420"},
    {"verse":'33:23',"no":"421"},
    {"verse":'33:31',"no":"422"},
    {"verse":'33:36',"no":"423"},
    {"verse":'33:44',"no":"424"},
    {"verse":'33:51',"no":"425"},
    {"verse":'33:55',"no":"426"},
    {"verse":'33:63',"no":"427"},
    {"verse":'34:1',"no":"428"},
    {"verse":'34:8',"no":"429"},
    {"verse":'34:15',"no":"430"},
    {"verse":'34:23',"no":"431"},
    {"verse":'34:32',"no":"432"},
    {"verse":'34:40',"no":"433"},
    {"verse":'34:49',"no":"434"},
    {"verse":'35:1',"no":"434"},
    {"verse":'35:4',"no":"435"},
    {"verse":'35:12',"no":"436"},
    {"verse":'35:19',"no":"437"},
    {"verse":'35:31',"no":"438"},
    {"verse":'35:39',"no":"439"},
    {"verse":'35:45',"no":"440"},
    {"verse":'36:1',"no":"440"},
    {"verse":'36:13',"no":"441"},
    {"verse":'36:28',"no":"442"},
    {"verse":'36:41',"no":"443"},
    {"verse":'36:55',"no":"444"},
    {"verse":'36:71',"no":"445"},
    {"verse":'37:1',"no":"446"},
    {"verse":'37:25',"no":"447"},
    {"verse":'37:52',"no":"448"},
    {"verse":'37:77',"no":"449"},
    {"verse":'37:103',"no":"450"},
    {"verse":'37:127',"no":"451"},
    {"verse":'37:154',"no":"452"},
    {"verse":'38:1',"no":"453"},
    {"verse":'38:17',"no":"454"},
    {"verse":'38:42',"no":"455"},
    {"verse":'38:61',"no":"456"},
    {"verse":'38:83',"no":"457"},
    {"verse":'39:1',"no":"458"},
    {"verse":'39:6',"no":"459"},
    {"verse":'39:11',"no":"460"},
    {"verse":'39:22',"no":"461"},
    {"verse":'39:32',"no":"462"},
    {"verse":'39:41',"no":"463"},
    {"verse":'39:48',"no":"464"},
    {"verse":'39:57',"no":"465"},
    {"verse":'39:68',"no":"466"},
    {"verse":'39:75',"no":"467"},
    {"verse":'40:1',"no":"467"},
    {"verse":'40:8',"no":"468"},
    {"verse":'40:17',"no":"469"},
    {"verse":'40:26',"no":"470"},
    {"verse":'40:34',"no":"471"},
    {"verse":'40:41',"no":"472"},
    {"verse":'40:50',"no":"473"},
    {"verse":'40:59',"no":"474"},
    {"verse":'40:67',"no":"475"},
    {"verse":'40:78',"no":"476"},

  ];
}