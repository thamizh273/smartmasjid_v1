// To parse this JSON data, do
//
//     final hadithChapterModel = hadithChapterModelFromJson(jsonString);

import 'dart:convert';

HadithChapterModel hadithChapterModelFromJson(String str) => HadithChapterModel.fromJson(json.decode(str));

String hadithChapterModelToJson(HadithChapterModel data) => json.encode(data.toJson());

class HadithChapterModel {
  String? typename;
  GetHadithsChapterByCollection? getHadithsChapterByCollection;

  HadithChapterModel({
    this.typename,
    this.getHadithsChapterByCollection,
  });

  factory HadithChapterModel.fromJson(Map<String, dynamic> json) => HadithChapterModel(
    typename: json["__typename"],
    getHadithsChapterByCollection: json["Get_Hadiths_Chapter_By_Collection"] == null ? null : GetHadithsChapterByCollection.fromJson(json["Get_Hadiths_Chapter_By_Collection"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Hadiths_Chapter_By_Collection": getHadithsChapterByCollection?.toJson(),
  };
}

class GetHadithsChapterByCollection {
  String? typename;
  String? collectionNameEn;
  String? collectionNameArb;
  String? collectionNameTamil;
  String? collectionNameHindi;
  String? collectionNameMalayalam;
  String? collectionNameTelugu;
  String? collectionNameUrdu;
  String? totalChapters;
  List<ChapterList>? chapterList;

  GetHadithsChapterByCollection({
    this.typename,
    this.collectionNameEn,
    this.collectionNameArb,
    this.collectionNameTamil,
    this.collectionNameHindi,
    this.collectionNameMalayalam,
    this.collectionNameTelugu,
    this.collectionNameUrdu,
    this.totalChapters,
    this.chapterList,
  });

  factory GetHadithsChapterByCollection.fromJson(Map<String, dynamic> json) => GetHadithsChapterByCollection(
    typename: json["__typename"],
    collectionNameEn: json["collection_name_en"],
    collectionNameArb: json["collection_name_arb"],
    collectionNameTamil: json["collection_name_tamil"],
    collectionNameHindi: json["collection_name_hindi"],
    collectionNameMalayalam: json["collection_name_malayalam"],
    collectionNameTelugu: json["collection_name_telugu"],
    collectionNameUrdu: json["collection_name_urdu"],
    totalChapters: json["total_chapters"],
    chapterList: json["chapter_list"] == null ? [] : List<ChapterList>.from(json["chapter_list"]!.map((x) => ChapterList.fromJson(x))),
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
    "total_chapters": totalChapters,
    "chapter_list": chapterList == null ? [] : List<dynamic>.from(chapterList!.map((x) => x.toJson())),
  };
}

class ChapterList {
  Typename? typename;
  String? hadithsChapterNameEn;
  String? hadithsChapterNameArb;
  String? hadithsChapterNameTamil;
  String? hadithsChapterNameHindi;
  String? hadithsChapterNameMalayalam;
  String? hadithsChapterNameTelugu;
  String? hadithsChapterNameUrdu;
  int? chapterNo;
  int? hadithsNoStart;
  int? hadithsNoEnd;
  int? hadithsTotal;

  ChapterList({
    this.typename,
    this.hadithsChapterNameEn,
    this.hadithsChapterNameArb,
    this.hadithsChapterNameTamil,
    this.hadithsChapterNameHindi,
    this.hadithsChapterNameMalayalam,
    this.hadithsChapterNameTelugu,
    this.hadithsChapterNameUrdu,
    this.chapterNo,
    this.hadithsNoStart,
    this.hadithsNoEnd,
    this.hadithsTotal,
  });

  factory ChapterList.fromJson(Map<String, dynamic> json) => ChapterList(
    typename: typenameValues.map[json["__typename"]]!,
    hadithsChapterNameEn: json["hadiths_chapter_name_en"],
    hadithsChapterNameArb: json["hadiths_chapter_name_arb"],
    hadithsChapterNameTamil: json["hadiths_chapter_name_tamil"],
    hadithsChapterNameHindi: json["hadiths_chapter_name_hindi"],
    hadithsChapterNameMalayalam: json["hadiths_chapter_name_malayalam"],
    hadithsChapterNameTelugu: json["hadiths_chapter_name_telugu"],
    hadithsChapterNameUrdu: json["hadiths_chapter_name_urdu"],
    chapterNo: json["chapter_no"],
    hadithsNoStart: json["hadiths_no_start"],
    hadithsNoEnd: json["hadiths_no_end"],
    hadithsTotal: json["hadiths_total"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "hadiths_chapter_name_en": hadithsChapterNameEn,
    "hadiths_chapter_name_arb": hadithsChapterNameArb,
    "hadiths_chapter_name_tamil": hadithsChapterNameTamil,
    "hadiths_chapter_name_hindi": hadithsChapterNameHindi,
    "hadiths_chapter_name_malayalam": hadithsChapterNameMalayalam,
    "hadiths_chapter_name_telugu": hadithsChapterNameTelugu,
    "hadiths_chapter_name_urdu": hadithsChapterNameUrdu,
    "chapter_no": chapterNo,
    "hadiths_no_start": hadithsNoStart,
    "hadiths_no_end": hadithsNoEnd,
    "hadiths_total": hadithsTotal,
  };
}

enum Typename {
  CHAPTERS
}

final typenameValues = EnumValues({
  "chapters": Typename.CHAPTERS
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
