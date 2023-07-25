// To parse this JSON data, do
//
//     final prayerTimeModel = prayerTimeModelFromJson(jsonString);

import 'dart:convert';

PrayerTimeModel prayerTimeModelFromJson(String str) => PrayerTimeModel.fromJson(json.decode(str));

String prayerTimeModelToJson(PrayerTimeModel data) => json.encode(data.toJson());

class PrayerTimeModel {
  String? typename;
  GetTodayMasjidPrayerTime? getTodayMasjidPrayerTime;

  PrayerTimeModel({
    this.typename,
    this.getTodayMasjidPrayerTime,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) => PrayerTimeModel(
    typename: json["__typename"],
    getTodayMasjidPrayerTime: json["Get_Today_Masjid_Prayer_Time"] == null ? null : GetTodayMasjidPrayerTime.fromJson(json["Get_Today_Masjid_Prayer_Time"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Today_Masjid_Prayer_Time": getTodayMasjidPrayerTime?.toJson(),
  };
}

class GetTodayMasjidPrayerTime {
  String? typename;
  List<TodayPrayerList>? todayPrayerList;
  String? todayHijriDate;

  GetTodayMasjidPrayerTime({
    this.typename,
    this.todayPrayerList,
    this.todayHijriDate,
  });

  factory GetTodayMasjidPrayerTime.fromJson(Map<String, dynamic> json) => GetTodayMasjidPrayerTime(
    typename: json["__typename"],
    todayPrayerList: json["today_prayer_list"] == null ? [] : List<TodayPrayerList>.from(json["today_prayer_list"]!.map((x) => TodayPrayerList.fromJson(x))),
    todayHijriDate: json["today_hijri_date"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "today_prayer_list": todayPrayerList == null ? [] : List<dynamic>.from(todayPrayerList!.map((x) => x.toJson())),
    "today_hijri_date": todayHijriDate,
  };
}

class TodayPrayerList {
  String? typename;
  DateTime? endTime;
  String? id;
  dynamic image;
  String? masjidId;
  bool? notification;
  String? prayerName;
  String? prayerStatus;
  DateTime? startTime;

  TodayPrayerList({
    this.typename,
    this.endTime,
    this.id,
    this.image,
    this.masjidId,
    this.notification,
    this.prayerName,
    this.prayerStatus,
    this.startTime,
  });

  factory TodayPrayerList.fromJson(Map<String, dynamic> json) => TodayPrayerList(
    typename: json["__typename"],
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    id: json["id"],
    image: json["image"],
    masjidId: json["masjid_id"],
    notification: json["notification"],
    prayerName: json["prayer_name"],
    prayerStatus: json["prayer_status"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "end_time": endTime?.toIso8601String(),
    "id": id,
    "image": image,
    "masjid_id": masjidId,
    "notification": notification,
    "prayer_name": prayerName,
    "prayer_status": prayerStatus,
    "start_time": startTime?.toIso8601String(),
  };
}
