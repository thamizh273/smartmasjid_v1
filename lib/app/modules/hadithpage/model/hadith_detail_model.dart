// To parse this JSON data, do
//
//     final hadithDetailModel = hadithDetailModelFromJson(jsonString);

import 'dart:convert';

HadithDetailModel hadithDetailModelFromJson(String str) => HadithDetailModel.fromJson(json.decode(str));

String hadithDetailModelToJson(HadithDetailModel data) => json.encode(data.toJson());

class HadithDetailModel {
  String? typename;
  GetHadithsVerseByCollection? getHadithsVerseByCollection;

  HadithDetailModel({
    this.typename,
    this.getHadithsVerseByCollection,
  });

  factory HadithDetailModel.fromJson(Map<String, dynamic> json) => HadithDetailModel(
    typename: json["__typename"],
    getHadithsVerseByCollection: json["Get_Hadiths_Verse_By_Collection"] == null ? null : GetHadithsVerseByCollection.fromJson(json["Get_Hadiths_Verse_By_Collection"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Hadiths_Verse_By_Collection": getHadithsVerseByCollection?.toJson(),
  };
}

class GetHadithsVerseByCollection {
  String? typename;
  String? collectionNameEn;
  String? collectionNameArb;
  String? collectionNameTamil;
  String? collectionNameHindi;
  String? collectionNameMalayalam;
  String? collectionNameTelugu;
  String? collectionNameUrdu;
  String? chapterNo;
  String? hadithsChapterNameEn;
  String? hadithsChapterNameArb;
  String? hadithsChapterNameTamil;
  String? hadithsChapterNameHindi;
  String? hadithsChapterNameMalayalam;
  String? hadithsChapterNameTelugu;
  String? hadithsChapterNameUrdu;
  String? hadithsTotal;
  List<HadisVersList>? hadisVersList;

  GetHadithsVerseByCollection({
    this.typename,
    this.collectionNameEn,
    this.collectionNameArb,
    this.collectionNameTamil,
    this.collectionNameHindi,
    this.collectionNameMalayalam,
    this.collectionNameTelugu,
    this.collectionNameUrdu,
    this.chapterNo,
    this.hadithsChapterNameEn,
    this.hadithsChapterNameArb,
    this.hadithsChapterNameTamil,
    this.hadithsChapterNameHindi,
    this.hadithsChapterNameMalayalam,
    this.hadithsChapterNameTelugu,
    this.hadithsChapterNameUrdu,
    this.hadithsTotal,
    this.hadisVersList,
  });

  factory GetHadithsVerseByCollection.fromJson(Map<String, dynamic> json) => GetHadithsVerseByCollection(
    typename: json["__typename"],
    collectionNameEn: json["collection_name_en"],
    collectionNameArb: json["collection_name_arb"],
    collectionNameTamil: json["collection_name_tamil"],
    collectionNameHindi: json["collection_name_hindi"],
    collectionNameMalayalam: json["collection_name_malayalam"],
    collectionNameTelugu: json["collection_name_telugu"],
    collectionNameUrdu: json["collection_name_urdu"],
    chapterNo: json["chapter_no"],
    hadithsChapterNameEn: json["hadiths_chapter_name_en"],
    hadithsChapterNameArb: json["hadiths_chapter_name_arb"],
    hadithsChapterNameTamil: json["hadiths_chapter_name_tamil"],
    hadithsChapterNameHindi: json["hadiths_chapter_name_hindi"],
    hadithsChapterNameMalayalam: json["hadiths_chapter_name_malayalam"],
    hadithsChapterNameTelugu: json["hadiths_chapter_name_telugu"],
    hadithsChapterNameUrdu: json["hadiths_chapter_name_urdu"],
    hadithsTotal: json["hadiths_total"],
    hadisVersList: json["hadis_vers_list"] == null ? [] : List<HadisVersList>.from(json["hadis_vers_list"]!.map((x) => HadisVersList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "collection_name_en": collectionNameEn,
    "collection_name_arb": collectionNameArb,
    "collection_name_tamil": collectionNameTamil,
    "collection_name_hindi": collectionNameHindi,
    "collection_name_malayalam": collectionNameMalayalam,
    "collection_name_telugu": collectionNameTelugu,
    "collection_name_urdu": collectionNameUrdu,
    "chapter_no": chapterNo,
    "hadiths_chapter_name_en": hadithsChapterNameEn,
    "hadiths_chapter_name_arb": hadithsChapterNameArb,
    "hadiths_chapter_name_tamil": hadithsChapterNameTamil,
    "hadiths_chapter_name_hindi": hadithsChapterNameHindi,
    "hadiths_chapter_name_malayalam": hadithsChapterNameMalayalam,
    "hadiths_chapter_name_telugu": hadithsChapterNameTelugu,
    "hadiths_chapter_name_urdu": hadithsChapterNameUrdu,
    "hadiths_total": hadithsTotal,
    "hadis_vers_list": hadisVersList == null ? [] : List<dynamic>.from(hadisVersList!.map((x) => x.toJson())),
  };
}

class HadisVersList {
  String? typename;
  String? collectionNameEn;
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
  String? narrated;

  HadisVersList({
    this.typename,
    this.collectionNameEn,
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
    this.narrated,
  });

  factory HadisVersList.fromJson(Map<String, dynamic> json) => HadisVersList(
    typename: json["__typename"],
    collectionNameEn: json["collection_name_en"],
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
    narrated: json["narrated"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "collection_name_en": collectionNameEn,
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
    "narrated": narrated,
  };
}
