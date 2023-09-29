import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../model/hadith_chapter_model.dart';
import '../model/hadith_detail_model.dart';
import '../model/hadith_model.dart';

class HadithpageController extends GetxController {
  //TODO: Implement HadithpageController

  final count = 0.obs;
  double screenWidth = Get.width;
  double screenHeight = Get.height;
  RxBool isLoadings = false.obs;
  RxBool isLoadings1 = false.obs;
  RxBool isLoadings2 = false.obs;
  RxBool isLoadings3 = false.obs;
  RxBool isLoadings4 = false.obs;
  RxBool isLoadings5 = false.obs;
  final _restCallController = Get.put(restCallController());
  var gethadithdata = HadithModel().obs;
  var gethadithchapter = HadithChapterModel().obs;
  var gethadithdetail = HadithDetailModel().obs;



  @override
  void onInit() {
    hadithCollection();
    hadithChapters();
    hadithDetail();

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

  hadithCollection() async {
    isLoadings.value = true;
    var header = """
query Get_Hadiths_Collection(\$masjidId: String) {
  Get_Hadiths_Collection(masjid_id: \$masjidId) {
    collection_name_en
    collection_name_arb
    collection_name_tamil
    collection_name_hindi
    collection_name_malayalam
    collection_name_telugu
    collection_name_urdu
    total_chapters
    total_hadiths_no
  }
}
    """;

    var body = {
      "masjidId": ""

    };
    var res = await _restCallController.gql_query(header, body);
    log("data hadith ${json.encode(res)}");
    isLoadings.value = false;
    gethadithdata.value = hadithModelFromJson(json.encode(res));

    update();
  }
  hadithChapters() async {
    isLoadings2.value = true;
    var header = """
query Get_Hadiths_Chapter_By_Collection(\$collectionName: String!) {
  Get_Hadiths_Chapter_By_Collection(collection_name: \$collectionName) {
    collection_name_en
    collection_name_arb
    collection_name_tamil
    collection_name_hindi
    collection_name_malayalam
    collection_name_telugu
    collection_name_urdu
    total_chapters
    chapter_list {
      hadiths_chapter_name_en
      hadiths_chapter_name_arb
      hadiths_chapter_name_tamil
      hadiths_chapter_name_hindi
      hadiths_chapter_name_malayalam
      hadiths_chapter_name_telugu
      hadiths_chapter_name_urdu
      chapter_no
      hadiths_no_start
      hadiths_no_end
      hadiths_total
    }
  }
}
    """;

    var body = {
      "collectionName": "Sahih Bukhari"

    };
    var res = await _restCallController.gql_query(header, body);
    log("data hadchapter ${json.encode(res)}");
    isLoadings2.value = false;
    gethadithchapter.value = hadithChapterModelFromJson(json.encode(res));

    update();
  }
  hadithDetail() async {
    isLoadings4.value = true;
    var header = """
query Get_Hadiths_Verse_By_Collection(\$collection: String!, \$chapterNumber: String) {
  Get_Hadiths_Verse_By_Collection(collection: \$collection, chapter_number: \$chapterNumber) {
    collection_name_en
    hadiths_chapter_name_en
    chapter_no
    hadiths_no
    title_name_en
    title_name_arb
    title_name_tamil
    title_name_hindi
    title_name_malayalam
    title_name_telugu
    title_name_urdu
    english_hadiths
    arabic_hadiths
    tamil_hadiths
    hindi_hadiths
    malayalam_hadiths
    telugu_hadiths
    urdu_hadiths
  }
}
    """;

    var body = {
      "collection": "Sahih Bukhari",
      "chapterNumber": "1"

    };
    var res = await _restCallController.gql_query(header, body);
    log("data haddetail ${json.encode(res)}");
    isLoadings4.value = false;
    gethadithdetail.value = hadithDetailModelFromJson(json.encode(res));

    update();
  }
}
