// To parse this JSON data, do
//
//     final quranModel = quranModelFromJson(jsonString);

import 'dart:convert';

QuranModel quranModelFromJson(String str) => QuranModel.fromJson(json.decode(str));

String quranModelToJson(QuranModel data) => json.encode(data.toJson());

class QuranModel {
  String? typename;
  List<QuranFilter>? quranFilter;

  QuranModel({
    this.typename,
    this.quranFilter,
  });

  factory QuranModel.fromJson(Map<String, dynamic> json) => QuranModel(
    typename: json["__typename"],
    quranFilter: json["Quran_Filter"] == null ? [] : List<QuranFilter>.from(json["Quran_Filter"]!.map((x) => QuranFilter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Quran_Filter": quranFilter == null ? [] : List<dynamic>.from(quranFilter!.map((x) => x.toJson())),
  };
}

class QuranFilter {
  Typename? typename;
  String? masjidId;
  String? suraChapterNo;
  String? suraNameEn;
  String? suraNameArb;
  String? suraNameTamil;
  String? suraNameHindi;
  String? suraNameMalayalam;
  String? suraNameTelugu;
  String? suraNameUrdu;
  String? titleEn;
  String? titleTamil;
  String? titleHindi;
  String? titleArabic;
  String? titleMalayalam;
  String? titleTelugu;
  String? titleUrdu;
  String? totalVerses;
  QuranType? quranType;

  QuranFilter({
    this.typename,
    this.masjidId,
    this.suraChapterNo,
    this.suraNameEn,
    this.suraNameArb,
    this.suraNameTamil,
    this.suraNameHindi,
    this.suraNameMalayalam,
    this.suraNameTelugu,
    this.suraNameUrdu,
    this.titleEn,
    this.titleTamil,
    this.titleHindi,
    this.titleArabic,
    this.titleMalayalam,
    this.titleTelugu,
    this.titleUrdu,
    this.totalVerses,
    this.quranType,
  });

  factory QuranFilter.fromJson(Map<String, dynamic> json) => QuranFilter(
    typename: typenameValues.map[json["__typename"]]!,
    masjidId: json["masjid_id"],
    suraChapterNo: json["sura_chapter_no"],
    suraNameEn: json["sura_name_en"],
    suraNameArb: json["sura_name_arb"],
    suraNameTamil: json["sura_name_tamil"],
    suraNameHindi: json["sura_name_hindi"],
    suraNameMalayalam: json["sura_name_malayalam"],
    suraNameTelugu: json["sura_name_telugu"],
    suraNameUrdu: json["sura_name_urdu"],
    titleEn: json["title_en"],
    titleTamil: json["title_tamil"],
    titleHindi: json["title_hindi"],
    titleArabic: json["title_arabic"],
    titleMalayalam: json["title_malayalam"],
    titleTelugu: json["title_telugu"],
    titleUrdu: json["title_urdu"],
    totalVerses: json["total_verses"],
    quranType: quranTypeValues.map[json["quran_type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "masjid_id": masjidId,
    "sura_chapter_no": suraChapterNo,
    "sura_name_en": suraNameEn,
    "sura_name_arb": suraNameArb,
    "sura_name_tamil": suraNameTamil,
    "sura_name_hindi": suraNameHindi,
    "sura_name_malayalam": suraNameMalayalam,
    "sura_name_telugu": suraNameTelugu,
    "sura_name_urdu": suraNameUrdu,
    "title_en": titleEn,
    "title_tamil": titleTamil,
    "title_hindi": titleHindi,
    "title_arabic": titleArabic,
    "title_malayalam": titleMalayalam,
    "title_telugu": titleTelugu,
    "title_urdu": titleUrdu,
    "total_verses": totalVerses,
    "quran_type": quranTypeValues.reverse[quranType],
  };
}

enum QuranType {
  MADNI,
  MAKKI
}

final quranTypeValues = EnumValues({
  "Madni": QuranType.MADNI,
  "Makki": QuranType.MAKKI
});

enum Typename {
  QURAN
}

final typenameValues = EnumValues({
  "QURAN": Typename.QURAN
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
