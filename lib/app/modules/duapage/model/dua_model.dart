// To parse this JSON data, do
//
//     final duaModel = duaModelFromJson(jsonString);

import 'dart:convert';

DuaModel duaModelFromJson(String str) => DuaModel.fromJson(json.decode(str));

String duaModelToJson(DuaModel data) => json.encode(data.toJson());

class DuaModel {
  String? typename;
  List<GetDuasTitleList>? getDuasTitleList;

  DuaModel({
    this.typename,
    this.getDuasTitleList,
  });

  factory DuaModel.fromJson(Map<String, dynamic> json) => DuaModel(
    typename: json["__typename"],
    getDuasTitleList: json["Get_Duas_Title_List_"] == null ? [] : List<GetDuasTitleList>.from(json["Get_Duas_Title_List_"]!.map((x) => GetDuasTitleList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Duas_Title_List_": getDuasTitleList == null ? [] : List<dynamic>.from(getDuasTitleList!.map((x) => x.toJson())),
  };
}

class GetDuasTitleList {
  GetDuasTitleListTypename? typename;
  String? duasNameEn;
  dynamic duasNameArb;
  dynamic duasNameTamil;
  dynamic duasNameHindi;
  List<dynamic>? othersName;
  List<TitlesList>? titlesList;
  DuasType? duasType;

  GetDuasTitleList({
    this.typename,
    this.duasNameEn,
    this.duasNameArb,
    this.duasNameTamil,
    this.duasNameHindi,
    this.othersName,
    this.titlesList,
    this.duasType,
  });

  factory GetDuasTitleList.fromJson(Map<String, dynamic> json) => GetDuasTitleList(
    typename: getDuasTitleListTypenameValues.map[json["__typename"]]!,
    duasNameEn: json["duas_name_en"],
    duasNameArb: json["duas_name_arb"],
    duasNameTamil: json["duas_name_tamil"],
    duasNameHindi: json["duas_name_hindi"],
    othersName: json["others_name"] == null ? [] : List<dynamic>.from(json["others_name"]!.map((x) => x)),
    titlesList: json["titles_list"] == null ? [] : List<TitlesList>.from(json["titles_list"]!.map((x) => TitlesList.fromJson(x))),
    duasType: duasTypeValues.map[json["duas_type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "__typename": getDuasTitleListTypenameValues.reverse[typename],
    "duas_name_en": duasNameEn,
    "duas_name_arb": duasNameArb,
    "duas_name_tamil": duasNameTamil,
    "duas_name_hindi": duasNameHindi,
    "others_name": othersName == null ? [] : List<dynamic>.from(othersName!.map((x) => x)),
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

enum GetDuasTitleListTypename {
  DUAS_TITLE
}

final getDuasTitleListTypenameValues = EnumValues({
  "DUAS_TITLE": GetDuasTitleListTypename.DUAS_TITLE
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
