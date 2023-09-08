// To parse this JSON data, do
//
//     final quranDetailModel = quranDetailModelFromJson(jsonString);

import 'dart:convert';

QuranDetailModel quranDetailModelFromJson(String str) => QuranDetailModel.fromJson(json.decode(str));

String quranDetailModelToJson(QuranDetailModel data) => json.encode(data.toJson());

class QuranDetailModel {
  String? typename;
  List<GetQuranAyahVerse>? getQuranAyahVerse;

  QuranDetailModel({
    this.typename,
    this.getQuranAyahVerse,
  });

  factory QuranDetailModel.fromJson(Map<String, dynamic> json) => QuranDetailModel(
    typename: json["__typename"],
    getQuranAyahVerse: json["Get_Quran_Ayah_Verse"] == null ? [] : List<GetQuranAyahVerse>.from(json["Get_Quran_Ayah_Verse"]!.map((x) => GetQuranAyahVerse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Quran_Ayah_Verse": getQuranAyahVerse == null ? [] : List<dynamic>.from(getQuranAyahVerse!.map((x) => x.toJson())),
  };
}

class GetQuranAyahVerse {
  String? typename;
  String? suraChapterNo;
  String? suraNameEn;
  String? makkiMadina;
  String? titleArb;
  String? titleEn;
  String? totalVerses;
  String? arabicStartingText;
  List<AyahList>? ayahList;

  GetQuranAyahVerse({
    this.typename,
    this.suraChapterNo,
    this.suraNameEn,
    this.makkiMadina,
    this.titleArb,
    this.titleEn,
    this.totalVerses,
    this.arabicStartingText,
    this.ayahList,
  });

  factory GetQuranAyahVerse.fromJson(Map<String, dynamic> json) => GetQuranAyahVerse(
    typename: json["__typename"],
    suraChapterNo: json["sura_chapter_no"],
    suraNameEn: json["sura_name_en"],
    makkiMadina: json["makki_madina"],
    titleArb: json["title_arb"],
    titleEn: json["title_en"],
    totalVerses: json["total_verses"],
    arabicStartingText: json["arabic_starting_text"],
    ayahList: json["ayah_list"] == null ? [] : List<AyahList>.from(json["ayah_list"]!.map((x) => AyahList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "sura_chapter_no": suraChapterNo,
    "sura_name_en": suraNameEn,
    "makki_madina": makkiMadina,
    "title_arb": titleArb,
    "title_en": titleEn,
    "total_verses": totalVerses,
    "arabic_starting_text": arabicStartingText,
    "ayah_list": ayahList == null ? [] : List<dynamic>.from(ayahList!.map((x) => x.toJson())),
  };
}

class AyahList {
  String? typename;
  String? versesKey;
  int? ayahNo;
  String? arabicText;
  String? engTranslation;
  String? tamilTranslation;
  String? hindiTranslation;
  String? malayalamTranslation;
  String? teluguTranslation;
  ArabicAudio? arabicAudio;
  String? urduTranslation;

  AyahList({
    this.typename,
    this.versesKey,
    this.ayahNo,
    this.arabicText,
    this.engTranslation,
    this.tamilTranslation,
    this.hindiTranslation,
    this.malayalamTranslation,
    this.teluguTranslation,
    this.arabicAudio,
    this.urduTranslation,
  });

  factory AyahList.fromJson(Map<String, dynamic> json) => AyahList(
    typename: json["__typename"],
    versesKey: json["verses_key"],
    ayahNo: json["ayah_no"],
    arabicText: json["arabic_text"],
    engTranslation: json["eng_translation"],
    tamilTranslation: json["tamil_translation"],
    hindiTranslation: json["hindi_translation"],
    malayalamTranslation: json["malayalam_translation"],
    teluguTranslation: json["telugu_translation"],
    arabicAudio: json["arabic_audio"] == null ? null : ArabicAudio.fromJson(json["arabic_audio"]),
    urduTranslation: json["urdu_translation"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "verses_key": versesKey,
    "ayah_no": ayahNo,
    "arabic_text": arabicText,
    "eng_translation": engTranslation,
    "tamil_translation": tamilTranslation,
    "hindi_translation": hindiTranslation,
    "malayalam_translation": malayalamTranslation,
    "telugu_translation": teluguTranslation,
    "arabic_audio": arabicAudio?.toJson(),
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
