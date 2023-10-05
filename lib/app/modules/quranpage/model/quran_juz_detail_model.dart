// To parse this JSON data, do
//
//     final quranJuzDetailModel = quranJuzDetailModelFromJson(jsonString);

import 'dart:convert';

QuranJuzDetailModel quranJuzDetailModelFromJson(String str) => QuranJuzDetailModel.fromJson(json.decode(str));

String quranJuzDetailModelToJson(QuranJuzDetailModel data) => json.encode(data.toJson());

class QuranJuzDetailModel {
  String? typename;
  List<GetQuranJuzVersesList>? getQuranJuzVersesList;

  QuranJuzDetailModel({
    this.typename,
    this.getQuranJuzVersesList,
  });

  factory QuranJuzDetailModel.fromJson(Map<String, dynamic> json) => QuranJuzDetailModel(
    typename: json["__typename"],
    getQuranJuzVersesList: json["Get_Quran_Juz_Verses_List"] == null ? [] : List<GetQuranJuzVersesList>.from(json["Get_Quran_Juz_Verses_List"]!.map((x) => GetQuranJuzVersesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Quran_Juz_Verses_List": getQuranJuzVersesList == null ? [] : List<dynamic>.from(getQuranJuzVersesList!.map((x) => x.toJson())),
  };
}

class GetQuranJuzVersesList {
  String? typename;
  int? juzChapterNo;
  String? juzNameArb;
  String? juzNameEn;
  String? surahVersesStart;
  String? surahVersesEnd;
  int? totalVerses;
  List<AyahList>? ayahList;
  String? juzNameTamil;
  String? juzNameHindi;
  String? juzNameMalayalam;
  String? juzNameTelugu;
  String? juzNameUrdu;

  GetQuranJuzVersesList({
    this.typename,
    this.juzChapterNo,
    this.juzNameArb,
    this.juzNameEn,
    this.surahVersesStart,
    this.surahVersesEnd,
    this.totalVerses,
    this.ayahList,
    this.juzNameTamil,
    this.juzNameHindi,
    this.juzNameMalayalam,
    this.juzNameTelugu,
    this.juzNameUrdu,
  });

  factory GetQuranJuzVersesList.fromJson(Map<String, dynamic> json) => GetQuranJuzVersesList(
    typename: json["__typename"],
    juzChapterNo: json["juz_chapter_no"],
    juzNameArb: json["juz_name_arb"],
    juzNameEn: json["juz_name_en"],
    surahVersesStart: json["surah_verses_start"],
    surahVersesEnd: json["surah_verses_end"],
    totalVerses: json["total_verses"],
    ayahList: json["ayah_list"] == null ? [] : List<AyahList>.from(json["ayah_list"]!.map((x) => AyahList.fromJson(x))),
    juzNameTamil: json["juz_name_tamil"],
    juzNameHindi: json["juz_name_hindi"],
    juzNameMalayalam: json["juz_name_malayalam"],
    juzNameTelugu: json["juz_name_telugu"],
    juzNameUrdu: json["juz_name_urdu"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "juz_chapter_no": juzChapterNo,
    "juz_name_arb": juzNameArb,
    "juz_name_en": juzNameEn,
    "surah_verses_start": surahVersesStart,
    "surah_verses_end": surahVersesEnd,
    "total_verses": totalVerses,
    "ayah_list": ayahList == null ? [] : List<dynamic>.from(ayahList!.map((x) => x.toJson())),
    "juz_name_tamil": juzNameTamil,
    "juz_name_hindi": juzNameHindi,
    "juz_name_malayalam": juzNameMalayalam,
    "juz_name_telugu": juzNameTelugu,
    "juz_name_urdu": juzNameUrdu,
  };
}

class AyahList {
  Typename? typename;
  int? suraChapterNo;
  int? ayahNo;
  String? arabicText;
  String? versesKey;
  ArabicAudio? arabicAudio;
  String? tamilTranslation;
  String? engTranslation;
  String? hindiTranslation;
  String? malayalamTranslation;
  String? teluguTranslation;
  String? urduTranslation;

  AyahList({
    this.typename,
    this.suraChapterNo,
    this.ayahNo,
    this.arabicText,
    this.versesKey,
    this.arabicAudio,
    this.tamilTranslation,
    this.engTranslation,
    this.hindiTranslation,
    this.malayalamTranslation,
    this.teluguTranslation,
    this.urduTranslation,
  });

  factory AyahList.fromJson(Map<String, dynamic> json) => AyahList(
    typename: typenameValues.map[json["__typename"]]!,
    suraChapterNo: json["sura_chapter_no"],
    ayahNo: json["ayah_no"],
    arabicText: json["arabic_text"],
    versesKey: json["verses_key"],
    arabicAudio: json["arabic_audio"] == null ? null : ArabicAudio.fromJson(json["arabic_audio"]),
    tamilTranslation: json["tamil_translation"],
    engTranslation: json["eng_translation"],
    hindiTranslation: json["hindi_translation"],
    malayalamTranslation: json["malayalam_translation"],
    teluguTranslation: json["telugu_translation"],
    urduTranslation: json["urdu_translation"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "sura_chapter_no": suraChapterNo,
    "ayah_no": ayahNo,
    "arabic_text": arabicText,
    "verses_key": versesKey,
    "arabic_audio": arabicAudio?.toJson(),
    "tamil_translation": tamilTranslation,
    "eng_translation": engTranslation,
    "hindi_translation": hindiTranslation,
    "malayalam_translation": malayalamTranslation,
    "telugu_translation": teluguTranslation,
    "urdu_translation": urduTranslation,
  };
}

class ArabicAudio {
  String? type;
  List<int>? data;

  ArabicAudio({
    this.type,
    this.data,
  });

  factory ArabicAudio.fromJson(Map<String, dynamic> json) => ArabicAudio(
    type: json["type"],
    data: json["data"] == null ? [] : List<int>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}

enum Typename {
  GET_AYAH_LIST_JUZ
}

final typenameValues = EnumValues({
  "get_ayah_list_juz": Typename.GET_AYAH_LIST_JUZ
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
