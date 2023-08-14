// To parse this JSON data, do
//
//     final duaDetailModel = duaDetailModelFromJson(jsonString);

import 'dart:convert';

DuaDetailModel duaDetailModelFromJson(String str) => DuaDetailModel.fromJson(json.decode(str));

String duaDetailModelToJson(DuaDetailModel data) => json.encode(data.toJson());

class DuaDetailModel {
  String? typename;
  List<GetDuasVerseList>? getDuasVerseList;

  DuaDetailModel({
    this.typename,
    this.getDuasVerseList,
  });

  factory DuaDetailModel.fromJson(Map<String, dynamic> json) => DuaDetailModel(
    typename: json["__typename"],
    getDuasVerseList: json["Get_Duas_Verse_List"] == null ? [] : List<GetDuasVerseList>.from(json["Get_Duas_Verse_List"]!.map((x) => GetDuasVerseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Duas_Verse_List": getDuasVerseList == null ? [] : List<dynamic>.from(getDuasVerseList!.map((x) => x.toJson())),
  };
}

class GetDuasVerseList {
  String? typename;
  String? duasNameEn;
  String? duasNameArb;
  String? duasNameTamil;
  String? duasNameHindi;
  String? duasArabicText;
  String? duasEngText;
  String? engTranslation;
  String? tamilTranslation;
  String? hindiTranslation;
  String? title;

  GetDuasVerseList({
    this.typename,
    this.duasNameEn,
    this.duasNameArb,
    this.duasNameTamil,
    this.duasNameHindi,
    this.duasArabicText,
    this.duasEngText,
    this.engTranslation,
    this.tamilTranslation,
    this.hindiTranslation,
    this.title,
  });

  factory GetDuasVerseList.fromJson(Map<String, dynamic> json) => GetDuasVerseList(
    typename: json["__typename"],
    duasNameEn: json["duas_name_en"],
    duasNameArb: json["duas_name_arb"],
    duasNameTamil: json["duas_name_tamil"],
    duasNameHindi: json["duas_name_hindi"],
    duasArabicText: json["duas_arabic_text"],
    duasEngText: json["duas_eng_text"],
    engTranslation: json["eng_translation"],
    tamilTranslation: json["tamil_translation"],
    hindiTranslation: json["hindi_translation"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "duas_name_en": duasNameEn,
    "duas_name_arb": duasNameArb,
    "duas_name_tamil": duasNameTamil,
    "duas_name_hindi": duasNameHindi,
    "duas_arabic_text": duasArabicText,
    "duas_eng_text": duasEngText,
    "eng_translation": engTranslation,
    "tamil_translation": tamilTranslation,
    "hindi_translation": hindiTranslation,
    "title": title,
  };
}
