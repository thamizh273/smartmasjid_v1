// To parse this JSON data, do
//
//     final getImanTrakerEntryModel = getImanTrakerEntryModelFromJson(jsonString);

import 'dart:convert';

GetImanTrakerEntryModel getImanTrakerEntryModelFromJson(String str) => GetImanTrakerEntryModel.fromJson(json.decode(str));

String getImanTrakerEntryModelToJson(GetImanTrakerEntryModel data) => json.encode(data.toJson());

class GetImanTrakerEntryModel {
  String? typename;
  List<GetPrayerListTracker>? getPrayerListTracker;

  GetImanTrakerEntryModel({
    this.typename,
    this.getPrayerListTracker,
  });

  factory GetImanTrakerEntryModel.fromJson(Map<String, dynamic> json) => GetImanTrakerEntryModel(
    typename: json["__typename"],
    getPrayerListTracker: json["Get_Prayer_list_Tracker"] == null ? [] : List<GetPrayerListTracker>.from(json["Get_Prayer_list_Tracker"]!.map((x) => GetPrayerListTracker.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Prayer_list_Tracker": getPrayerListTracker == null ? [] : List<dynamic>.from(getPrayerListTracker!.map((x) => x.toJson())),
  };
}

class GetPrayerListTracker {
  String? typename;
  String? prayerId;
  String? prayerName;
  String? status;

  GetPrayerListTracker({
    this.typename,
    this.prayerId,
    this.prayerName,
    this.status,
  });

  factory GetPrayerListTracker.fromJson(Map<String, dynamic> json) => GetPrayerListTracker(
    typename: json["__typename"],
    prayerId: json["prayer_id"],
    prayerName: json["prayer_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "prayer_id": prayerId,
    "prayer_name": prayerName,
    "status": status,
  };
}
