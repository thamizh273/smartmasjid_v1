// To parse this JSON data, do
//
//     final duaModel = duaModelFromJson(jsonString);

import 'dart:convert';

DuaModel duaModelFromJson(String str) => DuaModel.fromJson(json.decode(str));

String duaModelToJson(DuaModel data) => json.encode(data.toJson());

class DuaModel {
  String? typename;
  GetDuasTitleList? getDuasTitleList;

  DuaModel({
    this.typename,
    this.getDuasTitleList,
  });

  factory DuaModel.fromJson(Map<String, dynamic> json) => DuaModel(
    typename: json["__typename"],
    getDuasTitleList: json["Get_Duas_Title_List_"] == null ? null : GetDuasTitleList.fromJson(json["Get_Duas_Title_List_"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Duas_Title_List_": getDuasTitleList?.toJson(),
  };
}

class GetDuasTitleList {
  String? typename;
  List<Daily>? feeling;
  List<Daily>? daily;
  List<Daily>? occasion;

  GetDuasTitleList({
    this.typename,
    this.feeling,
    this.daily,
    this.occasion,
  });

  factory GetDuasTitleList.fromJson(Map<String, dynamic> json) => GetDuasTitleList(
    typename: json["__typename"],
    feeling: json["feeling"] == null ? [] : List<Daily>.from(json["feeling"]!.map((x) => Daily.fromJson(x))),
    daily: json["daily"] == null ? [] : List<Daily>.from(json["daily"]!.map((x) => Daily.fromJson(x))),
    occasion: json["occasion"] == null ? [] : List<Daily>.from(json["occasion"]!.map((x) => Daily.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "feeling": feeling == null ? [] : List<dynamic>.from(feeling!.map((x) => x.toJson())),
    "daily": daily == null ? [] : List<dynamic>.from(daily!.map((x) => x.toJson())),
    "occasion": occasion == null ? [] : List<dynamic>.from(occasion!.map((x) => x.toJson())),
  };
}

class Daily {
  DailyTypename? typename;
  String? duasNameEn;
  dynamic duasNameArb;
  dynamic duasNameTamil;
  dynamic duasNameHindi;
  List<TitlesList>? titlesList;
  DuasType? duasType;

  Daily({
    this.typename,
    this.duasNameEn,
    this.duasNameArb,
    this.duasNameTamil,
    this.duasNameHindi,
    this.titlesList,
    this.duasType,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    typename: dailyTypenameValues.map[json["__typename"]]!,
    duasNameEn: json["duas_name_en"],
    duasNameArb: json["duas_name_arb"],
    duasNameTamil: json["duas_name_tamil"],
    duasNameHindi: json["duas_name_hindi"],
    titlesList: json["titles_list"] == null ? [] : List<TitlesList>.from(json["titles_list"]!.map((x) => TitlesList.fromJson(x))),
    duasType: duasTypeValues.map[json["duas_type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "__typename": dailyTypenameValues.reverse[typename],
    "duas_name_en": duasNameEn,
    "duas_name_arb": duasNameArb,
    "duas_name_tamil": duasNameTamil,
    "duas_name_hindi": duasNameHindi,
    "titles_list": titlesList == null ? [] : List<dynamic>.from(titlesList!.map((x) => x.toJson())),
    "duas_type": duasTypeValues.reverse[duasType],
  };
}

enum DuasType {
  DAILY,
  FEELING,
  OCCASION
}

final duasTypeValues = EnumValues({
  "daily": DuasType.DAILY,
  "feeling": DuasType.FEELING,
  "occasion": DuasType.OCCASION
});

class TitlesList {
  TitlesListTypename? typename;
  String? title;

  TitlesList({
    this.typename,
    this.title,
  });

  factory TitlesList.fromJson(Map<String, dynamic> json) => TitlesList(
    typename: titlesListTypenameValues.map[json["__typename"]]!,
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": titlesListTypenameValues.reverse[typename],
    "title": title,
  };
}

enum TitlesListTypename {
  TITLE_LISTS
}

final titlesListTypenameValues = EnumValues({
  "title_lists": TitlesListTypename.TITLE_LISTS
});

enum DailyTypename {
  DUAS_TITLE
}

final dailyTypenameValues = EnumValues({
  "DUAS_TITLE": DailyTypename.DUAS_TITLE
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
