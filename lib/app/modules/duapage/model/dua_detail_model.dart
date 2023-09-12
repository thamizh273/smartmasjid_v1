// To parse this JSON data, do
//
//     final duaDetailModel = duaDetailModelFromJson(jsonString);

import 'dart:convert';

DuaDetailModel duaDetailModelFromJson(String str) => DuaDetailModel.fromJson(json.decode(str));

String duaDetailModelToJson(DuaDetailModel data) => json.encode(data.toJson());

class DuaDetailModel {
  String? typename;
  GetDuasVerseList? getDuasVerseList;

  DuaDetailModel({
    this.typename,
    this.getDuasVerseList,
  });

  factory DuaDetailModel.fromJson(Map<String, dynamic> json) => DuaDetailModel(
    typename: json["__typename"],
    getDuasVerseList: json["Get_Duas_Verse_List"] == null ? null : GetDuasVerseList.fromJson(json["Get_Duas_Verse_List"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Duas_Verse_List": getDuasVerseList?.toJson(),
  };
}

class GetDuasVerseList {
  String? typename;
  List<DuasVerse>? duasVerses;
  String? title;
  String? titleArb;
  String? titleMalayalam;
  String? titleTelugu;
  String? titleHindi;
  String? titleTamil;
  String? titleUrdu;

  GetDuasVerseList({
    this.typename,
    this.duasVerses,
    this.title,
    this.titleArb,
    this.titleMalayalam,
    this.titleTelugu,
    this.titleHindi,
    this.titleTamil,
    this.titleUrdu,
  });

  factory GetDuasVerseList.fromJson(Map<String, dynamic> json) => GetDuasVerseList(
    typename: json["__typename"],
    duasVerses: json["duas_verses"] == null ? [] : List<DuasVerse>.from(json["duas_verses"]!.map((x) => DuasVerse.fromJson(x))),
    title: json["title"],
    titleArb: json["title_arb"],
    titleMalayalam: json["title_malayalam"],
    titleTelugu: json["title_telugu"],
    titleHindi: json["title_hindi"],
    titleTamil: json["title_tamil"],
    titleUrdu: json["title_urdu"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "duas_verses": duasVerses == null ? [] : List<dynamic>.from(duasVerses!.map((x) => x.toJson())),
    "title": title,
    "title_arb": titleArb,
    "title_malayalam": titleMalayalam,
    "title_telugu": titleTelugu,
    "title_hindi": titleHindi,
    "title_tamil": titleTamil,
    "title_urdu": titleUrdu,
  };
}

class DuasVerse {
  String? typename;
  String? duasNameEn;
  String? duasNameArb;
  String? duasNameTamil;
  String? duasNameHindi;
  String? duasNameMalayalam;
  String? duasNameTelugu;
  String? duasNameUrdu;
  String? duasArabicText;
  String? duasEngText;
  String? arbTranslation;
  String? engTranslation;
  String? tamilTranslation;
  String? hindiTranslation;
  String? malayalamTranslation;
  String? teluguTranslation;
  String? urduTranslation;
  String? title;

  DuasVerse({
    this.typename,
    this.duasNameEn,
    this.duasNameArb,
    this.duasNameTamil,
    this.duasNameHindi,
    this.duasNameMalayalam,
    this.duasNameTelugu,
    this.duasNameUrdu,
    this.duasArabicText,
    this.duasEngText,
    this.arbTranslation,
    this.engTranslation,
    this.tamilTranslation,
    this.hindiTranslation,
    this.malayalamTranslation,
    this.teluguTranslation,
    this.urduTranslation,
    this.title,
  });

  factory DuasVerse.fromJson(Map<String, dynamic> json) => DuasVerse(
    typename: json["__typename"],
    duasNameEn: json["duas_name_en"],
    duasNameArb: json["duas_name_arb"],
    duasNameTamil: json["duas_name_tamil"],
    duasNameHindi: json["duas_name_hindi"],
    duasNameMalayalam: json["duas_name_malayalam"],
    duasNameTelugu: json["duas_name_telugu"],
    duasNameUrdu: json["duas_name_urdu"],
    duasArabicText: json["duas_arabic_text"],
    duasEngText: json["duas_eng_text"],
    arbTranslation: json["arb_translation"],
    engTranslation: json["eng_translation"],
    tamilTranslation: json["tamil_translation"],
    hindiTranslation: json["hindi_translation"],
    malayalamTranslation: json["malayalam_translation"],
    teluguTranslation: json["telugu_translation"],
    urduTranslation: json["urdu_translation"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "duas_name_en": duasNameEn,
    "duas_name_arb": duasNameArb,
    "duas_name_tamil": duasNameTamil,
    "duas_name_hindi": duasNameHindi,
    "duas_name_malayalam": duasNameMalayalam,
    "duas_name_telugu": duasNameTelugu,
    "duas_name_urdu": duasNameUrdu,
    "duas_arabic_text": duasArabicText,
    "duas_eng_text": duasEngText,
    "arb_translation": arbTranslation,
    "eng_translation": engTranslation,
    "tamil_translation": tamilTranslation,
    "hindi_translation": hindiTranslation,
    "malayalam_translation": malayalamTranslation,
    "telugu_translation": teluguTranslation,
    "urdu_translation": urduTranslation,
    "title": title,
  };
}
