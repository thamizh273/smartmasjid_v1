import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartmasjid_v1/app/modules/duapage/model/dua_detail_model.dart';
import 'package:smartmasjid_v1/app/modules/duapage/model/dua_model.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../views/dua_detail.dart';

class DuapageController extends GetxController {
  //TODO: Implement DuapageController

  var isExpanded = false.obs;
  var isExpanded1 = false.obs;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
var isLoadings = false.obs;
var isLoadings1 = false.obs;
var isLoadings2 = false.obs;
  final _restCallController = Get.put(restCallController());
  var getduadata = DuaModel().obs;
  var getdetailduadata = DuaDetailModel().obs;
  var getdailydata= DuaDetailModel().obs;
  var fontFamily = "indopak".obs;
  double screenWidth = Get.width;
  var selectedMenuItem = "Indopak".obs;

  final count = 0.obs;
  @override
  void onInit() {
    duaList();
  // duadetailList("");
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

  duaList() async {
    isLoadings.value = true;
    var header = """
query Get_Duas_Verse_List(\$masjidId: String) {
  Get_Duas_Title_List_(masjid_id: \$masjidId) {
    feeling {
      duas_name_en
      duas_name_arb
      duas_name_tamil
      duas_name_hindi
      duas_name_malayalam
      duas_name_telugu
      duas_name_urdu
      others_name
      titles_list {
        title
        title_arb
        title_hindi
        title_malayalam
        title_telugu
        title_tamil
        title_urdu
      }
      duas_type
    }
    daily {
      duas_name_en
      duas_name_arb
      duas_name_tamil
      duas_name_hindi
      duas_name_malayalam
      duas_name_telugu
      duas_name_urdu
      others_name
      titles_list {
        title
        title_arb
        title_malayalam
        title_telugu
        title_tamil
        title_hindi
        title_urdu
      }
      duas_type
    }
    occasion {
      duas_name_en
      duas_name_arb
      duas_name_tamil
      duas_name_hindi
      duas_name_malayalam
      duas_name_telugu
      duas_name_urdu
      others_name
      titles_list {
        title
        title_arb
        title_malayalam
        title_telugu
        title_tamil
        title_hindi
        title_urdu
      }
      duas_type
    }
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
    log("data sign ${json.encode(res)}");
    isLoadings.value = false;
    getduadata.value = duaModelFromJson(json.encode(res));
    update();
  }
  duadetailList(String? duasNameEn) async {
    // print( "dua dua ${duasNameEn}");
    isLoadings1.value = true;
    var header = """
query Get_Duas_Verse_List(\$titleName: String) {
  Get_Duas_Verse_List(title_name: \$titleName) {
    duas_verses {
      duas_name_en
      duas_name_arb
      duas_name_tamil
      duas_name_hindi
      duas_name_malayalam
      duas_name_telugu
      duas_name_urdu
      duas_arabic_text
      duas_eng_text
      arb_translation
      eng_translation
      tamil_translation
      hindi_translation
      malayalam_translation
      telugu_translation
      urdu_translation
      title
    }
    title
    title_arb
    title_malayalam
    title_telugu
    title_hindi
    title_tamil
    title_urdu
  }
}
    """;

    var body = {
      "titleName": "$duasNameEn"

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data duaaaa ${json.encode(res)}");
    isLoadings1.value = false;
    getdetailduadata.value = duaDetailModelFromJson(json.encode(res));
   // Get.to(DuaDetail());
    update();
  }
  duadaily(String? duasNameEn) async {
    isLoadings2.value = true;
    var header = """
query Get_Duas_Verse_List(\$titleName: String) {
  Get_Duas_Verse_List(title_name: \$titleName) {
    duas_verses {
      duas_name_en
      duas_name_arb
      duas_arabic_text
      arb_translation
      title
      duas_name_tamil
      duas_name_hindi
      duas_name_telugu
      duas_name_malayalam
      duas_name_urdu
      duas_eng_text
      eng_translation
      tamil_translation
      hindi_translation
      malayalam_translation
      telugu_translation
      urdu_translation
    }
    title
    title_arb
    title_malayalam
    title_telugu
    title_tamil
    title_urdu
    title_hindi
  }
}
    """;

    var body = {
      "titleName": "$duasNameEn"

    };
    var res = await _restCallController.gql_query(header, body);
    // print("lllll");
    // print(json.encode(res));
    // print("lllll");
    log("data dua ${json.encode(res)}");
    isLoadings2.value = false;

    getdailydata.value = duaDetailModelFromJson(json.encode(res));
   // Get.to(DuaDetail());
    update();
  }
}
