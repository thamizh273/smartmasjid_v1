// To parse this JSON data, do
//
//     final quranJuzModel = quranJuzModelFromJson(jsonString);

import 'dart:convert';

QuranJuzModel quranJuzModelFromJson(String str) => QuranJuzModel.fromJson(json.decode(str));

String quranJuzModelToJson(QuranJuzModel data) => json.encode(data.toJson());

class QuranJuzModel {
  String? typename;
  List<GetQuranJuzChapter>? getQuranJuzChapter;

  QuranJuzModel({
    this.typename,
    this.getQuranJuzChapter,
  });

  factory QuranJuzModel.fromJson(Map<String, dynamic> json) => QuranJuzModel(
    typename: json["__typename"],
    getQuranJuzChapter: json["Get_Quran_Juz_Chapter"] == null ? [] : List<GetQuranJuzChapter>.from(json["Get_Quran_Juz_Chapter"]!.map((x) => GetQuranJuzChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Quran_Juz_Chapter": getQuranJuzChapter == null ? [] : List<dynamic>.from(getQuranJuzChapter!.map((x) => x.toJson())),
  };
}

class GetQuranJuzChapter {
  Typename? typename;
  int? juzChapterNo;
  String? juzNameArb;
  String? juzNameEn;
  String? juzNameTamil;
  JuzName? juzNameHindi;
  JuzName? juzNameMalayalam;
  JuzName? juzNameTelugu;
  JuzName? juzNameUrdu;
  String? surahVersesStart;
  String? surahVersesEnd;
  int? totalVerses;

  GetQuranJuzChapter({
    this.typename,
    this.juzChapterNo,
    this.juzNameArb,
    this.juzNameEn,
    this.juzNameTamil,
    this.juzNameHindi,
    this.juzNameMalayalam,
    this.juzNameTelugu,
    this.juzNameUrdu,
    this.surahVersesStart,
    this.surahVersesEnd,
    this.totalVerses,
  });

  factory GetQuranJuzChapter.fromJson(Map<String, dynamic> json) => GetQuranJuzChapter(
    typename: typenameValues.map[json["__typename"]]!,
    juzChapterNo: json["juz_chapter_no"],
    juzNameArb: json["juz_name_arb"],
    juzNameEn: json["juz_name_en"],
    juzNameTamil: json["juz_name_tamil"],
    juzNameHindi: juzNameValues.map[json["juz_name_hindi"]]!,
    juzNameMalayalam: juzNameValues.map[json["juz_name_malayalam"]]!,
    juzNameTelugu: juzNameValues.map[json["juz_name_telugu"]]!,
    juzNameUrdu: juzNameValues.map[json["juz_name_urdu"]]!,
    surahVersesStart: json["surah_verses_start"],
    surahVersesEnd: json["surah_verses_end"],
    totalVerses: json["total_verses"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "juz_chapter_no": juzChapterNo,
    "juz_name_arb": juzNameArb,
    "juz_name_en": juzNameEn,
    "juz_name_tamil": juzNameTamil,
    "juz_name_hindi": juzNameValues.reverse[juzNameHindi],
    "juz_name_malayalam": juzNameValues.reverse[juzNameMalayalam],
    "juz_name_telugu": juzNameValues.reverse[juzNameTelugu],
    "juz_name_urdu": juzNameValues.reverse[juzNameUrdu],
    "surah_verses_start": surahVersesStart,
    "surah_verses_end": surahVersesEnd,
    "total_verses": totalVerses,
  };
}

enum JuzName {
  NULL
}

final juzNameValues = EnumValues({
  "null": JuzName.NULL
});

enum Typename {
  QURAN_JUZ_CHAPTER
}

final typenameValues = EnumValues({
  "quran_juz_chapter": Typename.QURAN_JUZ_CHAPTER
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
