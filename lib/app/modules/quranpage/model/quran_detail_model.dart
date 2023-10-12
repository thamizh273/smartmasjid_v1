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
  String? makkiMadina;
  String? suraChapterNo;
  String? suraNameEn;
  String? titleEn;
  String? titleArb;
  String? totalVerses;
  String? arabicStartingText;
  List<AyahList>? ayahList;

  GetQuranAyahVerse({
    this.typename,
    this.makkiMadina,
    this.suraChapterNo,
    this.suraNameEn,
    this.titleEn,
    this.titleArb,
    this.totalVerses,
    this.arabicStartingText,
    this.ayahList,
  });

  factory GetQuranAyahVerse.fromJson(Map<String, dynamic> json) => GetQuranAyahVerse(
    typename: json["__typename"],
    makkiMadina: json["makki_madina"],
    suraChapterNo: json["sura_chapter_no"],
    suraNameEn: json["sura_name_en"],
    titleEn: json["title_en"],
    titleArb: json["title_arb"],
    totalVerses: json["total_verses"],
    arabicStartingText: json["arabic_starting_text"],
    ayahList: json["ayah_list"] == null ? [] : List<AyahList>.from(json["ayah_list"]!.map((x) => AyahList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "makki_madina": makkiMadina,
    "sura_chapter_no": suraChapterNo,
    "sura_name_en": suraNameEn,
    "title_en": titleEn,
    "title_arb": titleArb,
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
  ArabicAudio? arabicAudio;
  String? engTranslation;
  String? tamilTranslation;
  String? hindiTranslation;
  String? malayalamTranslation;
  String? teluguTranslation;
  String? urduTranslation;
  String? page;

  AyahList({
    this.typename,
    this.versesKey,
    this.ayahNo,
    this.arabicText,
    this.arabicAudio,
    this.engTranslation,
    this.tamilTranslation,
    this.hindiTranslation,
    this.malayalamTranslation,
    this.teluguTranslation,
    this.urduTranslation,
    this.page,
  });

  factory AyahList.fromJson(Map<String, dynamic> json) => AyahList(
    typename: json["__typename"],
    versesKey: json["verses_key"],
    ayahNo: json["ayah_no"],
    arabicText: json["arabic_text"],
    arabicAudio: json["arabic_audio"] == null ? null : ArabicAudio.fromJson(json["arabic_audio"]),
    engTranslation: json["eng_translation"],
    tamilTranslation: json["tamil_translation"],
    hindiTranslation: json["hindi_translation"],
    malayalamTranslation: json["malayalam_translation"],
    teluguTranslation: json["telugu_translation"],
    urduTranslation: json["urdu_translation"],
    page: json["page_"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "verses_key": versesKey,
    "ayah_no": ayahNo,
    "arabic_text": arabicText,
    "arabic_audio": arabicAudio?.toJson(),
    "eng_translation": engTranslation,
    "tamil_translation": tamilTranslation,
    "hindi_translation": hindiTranslation,
    "malayalam_translation": malayalamTranslation,
    "telugu_translation": teluguTranslation,
    "urdu_translation": urduTranslation,
    "page_": page,
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
