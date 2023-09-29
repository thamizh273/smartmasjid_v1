// To parse this JSON data, do
//
//     final hadithDetailModel = hadithDetailModelFromJson(jsonString);

import 'dart:convert';

HadithDetailModel hadithDetailModelFromJson(String str) => HadithDetailModel.fromJson(json.decode(str));

String hadithDetailModelToJson(HadithDetailModel data) => json.encode(data.toJson());

class HadithDetailModel {
  String? typename;
  List<GetHadithsVerseByCollection>? getHadithsVerseByCollection;

  HadithDetailModel({
    this.typename,
    this.getHadithsVerseByCollection,
  });

  factory HadithDetailModel.fromJson(Map<String, dynamic> json) => HadithDetailModel(
    typename: json["__typename"],
    getHadithsVerseByCollection: json["Get_Hadiths_Verse_By_Collection"] == null ? [] : List<GetHadithsVerseByCollection>.from(json["Get_Hadiths_Verse_By_Collection"]!.map((x) => GetHadithsVerseByCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Hadiths_Verse_By_Collection": getHadithsVerseByCollection == null ? [] : List<dynamic>.from(getHadithsVerseByCollection!.map((x) => x.toJson())),
  };
}

class GetHadithsVerseByCollection {
  Typename? typename;
  String? collectionNameEn;
  String? hadithsChapterNameEn;
  int? chapterNo;
  int? hadithsNo;
  String? titleNameEn;
  String? titleNameArb;
  String? titleNameTamil;
  String? titleNameHindi;
  String? titleNameMalayalam;
  String? titleNameTelugu;
  String? titleNameUrdu;
  String? englishHadiths;
  String? arabicHadiths;
  String? tamilHadiths;
  String? hindiHadiths;
  String? malayalamHadiths;
  String? teluguHadiths;
  String? urduHadiths;

  GetHadithsVerseByCollection({
    this.typename,
    this.collectionNameEn,
    this.hadithsChapterNameEn,
    this.chapterNo,
    this.hadithsNo,
    this.titleNameEn,
    this.titleNameArb,
    this.titleNameTamil,
    this.titleNameHindi,
    this.titleNameMalayalam,
    this.titleNameTelugu,
    this.titleNameUrdu,
    this.englishHadiths,
    this.arabicHadiths,
    this.tamilHadiths,
    this.hindiHadiths,
    this.malayalamHadiths,
    this.teluguHadiths,
    this.urduHadiths,
  });

  factory GetHadithsVerseByCollection.fromJson(Map<String, dynamic> json) => GetHadithsVerseByCollection(
    typename: typenameValues.map[json["__typename"]]!,
    collectionNameEn: json["collection_name_en"],
    hadithsChapterNameEn: json["hadiths_chapter_name_en"],
    chapterNo: json["chapter_no"],
    hadithsNo: json["hadiths_no"],
    titleNameEn: json["title_name_en"],
    titleNameArb: json["title_name_arb"],
    titleNameTamil: json["title_name_tamil"],
    titleNameHindi: json["title_name_hindi"],
    titleNameMalayalam: json["title_name_malayalam"],
    titleNameTelugu: json["title_name_telugu"],
    titleNameUrdu: json["title_name_urdu"],
    englishHadiths: json["english_hadiths"],
    arabicHadiths: json["arabic_hadiths"],
    tamilHadiths: json["tamil_hadiths"],
    hindiHadiths: json["hindi_hadiths"],
    malayalamHadiths: json["malayalam_hadiths"],
    teluguHadiths: json["telugu_hadiths"],
    urduHadiths: json["urdu_hadiths"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "collection_name_en": collectionNameEn,
    "hadiths_chapter_name_en": hadithsChapterNameEn,
    "chapter_no": chapterNo,
    "hadiths_no": hadithsNo,
    "title_name_en": titleNameEn,
    "title_name_arb": titleNameArb,
    "title_name_tamil": titleNameTamil,
    "title_name_hindi": titleNameHindi,
    "title_name_malayalam": titleNameMalayalam,
    "title_name_telugu": titleNameTelugu,
    "title_name_urdu": titleNameUrdu,
    "english_hadiths": englishHadiths,
    "arabic_hadiths": arabicHadiths,
    "tamil_hadiths": tamilHadiths,
    "hindi_hadiths": hindiHadiths,
    "malayalam_hadiths": malayalamHadiths,
    "telugu_hadiths": teluguHadiths,
    "urdu_hadiths": urduHadiths,
  };
}

enum Typename {
  HADITHS_CHAPTER_VERS
}

final typenameValues = EnumValues({
  "HADITHS_CHAPTER_VERS": Typename.HADITHS_CHAPTER_VERS
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
