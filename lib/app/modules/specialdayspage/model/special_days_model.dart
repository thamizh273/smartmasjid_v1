// To parse this JSON data, do
//
//     final specialDaysModel = specialDaysModelFromJson(jsonString);

import 'dart:convert';

SpecialDaysModel specialDaysModelFromJson(String str) => SpecialDaysModel.fromJson(json.decode(str));

String specialDaysModelToJson(SpecialDaysModel data) => json.encode(data.toJson());

class SpecialDaysModel {
  String? typename;
  List<GetHolyDay>? getHolyDays;

  SpecialDaysModel({
    this.typename,
    this.getHolyDays,
  });

  factory SpecialDaysModel.fromJson(Map<String, dynamic> json) => SpecialDaysModel(
    typename: json["__typename"],
    getHolyDays: json["Get_Holy_days"] == null ? [] : List<GetHolyDay>.from(json["Get_Holy_days"]!.map((x) => GetHolyDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Holy_days": getHolyDays == null ? [] : List<dynamic>.from(getHolyDays!.map((x) => x.toJson())),
  };
}

class GetHolyDay {
  Typename? typename;
  String? holydaysName;
  String? arabicDate;
  DateTime? englishDate;
  String? date;
  String? day;
  String? month;
  String? year;

  GetHolyDay({
    this.typename,
    this.holydaysName,
    this.arabicDate,
    this.englishDate,
    this.date,
    this.day,
    this.month,
    this.year,
  });

  factory GetHolyDay.fromJson(Map<String, dynamic> json) => GetHolyDay(
    typename: typenameValues.map[json["__typename"]]!,
    holydaysName: json["holydays_name"],
    arabicDate: json["arabic_date"],
    englishDate: json["english_date"] == null ? null : DateTime.parse(json["english_date"]),
    date: json["date_"],
    day: json["day"],
    month: json["month_"],
    year: json["year_"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "holydays_name": holydaysName,
    "arabic_date": arabicDate,
    "english_date": englishDate?.toIso8601String(),
    "date_": date,
    "day": day,
    "month_": month,
    "year_": year,
  };
}

enum Typename {
  HOLY_DAYS
}

final typenameValues = EnumValues({
  "HOLY_DAYS": Typename.HOLY_DAYS
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
