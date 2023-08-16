// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String? typename;
  List<GetNotificationLog>? getNotificationLog;

  NotificationModel({
    this.typename,
    this.getNotificationLog,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    typename: json["__typename"],
    getNotificationLog: json["Get_Notification_Log"] == null ? [] : List<GetNotificationLog>.from(json["Get_Notification_Log"]!.map((x) => GetNotificationLog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Notification_Log": getNotificationLog == null ? [] : List<dynamic>.from(getNotificationLog!.map((x) => x.toJson())),
  };
}

class GetNotificationLog {
  String? typename;
  String? userId;
  bool? readStatus;
  String? notificationType;
  String? notificationMessage;
  MasjidId? masjidId;
  String? description;
  DateTime? createdAt;
  String? id;

  GetNotificationLog({
    this.typename,
    this.userId,
    this.readStatus,
    this.notificationType,
    this.notificationMessage,
    this.masjidId,
    this.description,
    this.createdAt,
    this.id,
  });

  factory GetNotificationLog.fromJson(Map<String, dynamic> json) => GetNotificationLog(
    typename: json["__typename"],
    userId: json["user_id"],
    readStatus: json["read_status_"],
    notificationType: json["notification_type"],
    notificationMessage: json["notification_message"],
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "user_id": userId,
    "read_status_": readStatus,
    "notification_type": notificationType,
    "notification_message": notificationMessage,
    "masjid_id": masjidId?.toJson(),
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class MasjidId {
  String? typename;
  String? id;
  String? masjidName;
  MasjidImage? masjidImage;

  MasjidId({
    this.typename,
    this.id,
    this.masjidName,
    this.masjidImage,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    id: json["id"],
    masjidName: json["masjid_name"],
    masjidImage: json["masjid_image"] == null ? null : MasjidImage.fromJson(json["masjid_image"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "masjid_name": masjidName,
    "masjid_image": masjidImage?.toJson(),
  };
}

class MasjidImage {
  String? type;
  List<dynamic>? data;

  MasjidImage({
    this.type,
    this.data,
  });

  factory MasjidImage.fromJson(Map<String, dynamic> json) => MasjidImage(
    type: json["type"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
