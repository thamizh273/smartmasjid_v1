// To parse this JSON data, do
//
//     final hadithModel = hadithModelFromJson(jsonString);

import 'dart:convert';

HadithModel hadithModelFromJson(String str) => HadithModel.fromJson(json.decode(str));

String hadithModelToJson(HadithModel data) => json.encode(data.toJson());

class HadithModel {
  String? typename;
  List<GetHadithsCollection>? getHadithsCollection;

  HadithModel({
    this.typename,
    this.getHadithsCollection,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    typename: json["__typename"],
    getHadithsCollection: json["Get_Hadiths_Collection"] == null ? [] : List<GetHadithsCollection>.from(json["Get_Hadiths_Collection"]!.map((x) => GetHadithsCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Hadiths_Collection": getHadithsCollection == null ? [] : List<dynamic>.from(getHadithsCollection!.map((x) => x.toJson())),
  };
}

class GetHadithsCollection {
  String? typename;
  String? collectionNameEn;
  String? collectionNameArb;
  String? collectionNameTamil;
  String? collectionNameHindi;
  String? collectionNameMalayalam;
  String? collectionNameTelugu;
  String? collectionNameUrdu;
  String? totalChapters;
  String? totalHadithsNo;

  GetHadithsCollection({
    this.typename,
    this.collectionNameEn,
    this.collectionNameArb,
    this.collectionNameTamil,
    this.collectionNameHindi,
    this.collectionNameMalayalam,
    this.collectionNameTelugu,
    this.collectionNameUrdu,
    this.totalChapters,
    this.totalHadithsNo,
  });

  factory GetHadithsCollection.fromJson(Map<String, dynamic> json) => GetHadithsCollection(
    typename: json["__typename"],
    collectionNameEn: json["collection_name_en"],
    collectionNameArb: json["collection_name_arb"],
    collectionNameTamil: json["collection_name_tamil"],
    collectionNameHindi: json["collection_name_hindi"],
    collectionNameMalayalam: json["collection_name_malayalam"],
    collectionNameTelugu: json["collection_name_telugu"],
    collectionNameUrdu: json["collection_name_urdu"],
    totalChapters: json["total_chapters"],
    totalHadithsNo: json["total_hadiths_no"],
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
    "total_hadiths_no": totalHadithsNo,
  };
}
