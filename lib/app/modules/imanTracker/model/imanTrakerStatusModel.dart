// To parse this JSON data, do
//
//     final imanTrakerStatusModel = imanTrakerStatusModelFromJson(jsonString);

import 'dart:convert';

ImanTrakerStatusModel imanTrakerStatusModelFromJson(String str) => ImanTrakerStatusModel.fromJson(json.decode(str));

String imanTrakerStatusModelToJson(ImanTrakerStatusModel data) => json.encode(data.toJson());

class ImanTrakerStatusModel {
  String? typename;
  List<GetImanTrackerStatus>? getImanTrackerStatus;

  ImanTrakerStatusModel({
    this.typename,
    this.getImanTrackerStatus,
  });

  factory ImanTrakerStatusModel.fromJson(Map<String, dynamic> json) => ImanTrakerStatusModel(
    typename: json["__typename"],
    getImanTrackerStatus: json["Get_Iman_Tracker_Status"] == null ? [] : List<GetImanTrackerStatus>.from(json["Get_Iman_Tracker_Status"]!.map((x) => GetImanTrackerStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Iman_Tracker_Status": getImanTrackerStatus == null ? [] : List<dynamic>.from(getImanTrackerStatus!.map((x) => x.toJson())),
  };
}

class GetImanTrackerStatus {
  String? typename;
  Status? status;
  String? trackerName;

  GetImanTrackerStatus({
    this.typename,
    this.status,
    this.trackerName,
  });

  factory GetImanTrackerStatus.fromJson(Map<String, dynamic> json) => GetImanTrackerStatus(
    typename: json["__typename"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    trackerName: json["tracker_name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "status": status?.toJson(),
    "tracker_name": trackerName,
  };
}

class Status {
  String? typename;
  double? injamaah;
  double? late;
  double? notprayed;
  double? ontime;
  int? totalPercent;

  Status({
    this.typename,
    this.injamaah,
    this.late,
    this.notprayed,
    this.ontime,
    this.totalPercent,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    typename: json["__typename"],
    injamaah: json["injamaah"]?.toDouble(),
    late: json["late"]?.toDouble(),
    notprayed: json["notprayed"]?.toDouble(),
    ontime: json["ontime"]?.toDouble(),
    totalPercent: json["total_percent"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "injamaah": injamaah,
    "late": late,
    "notprayed": notprayed,
    "ontime": ontime,
    "total_percent": totalPercent,
  };
}
