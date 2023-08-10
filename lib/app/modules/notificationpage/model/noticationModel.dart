
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
  DateTime? createdAt;
  String? description;
  String? id;
  MasjidId? masjidId;
  String? notificationMessage;
  String? notificationType;
  bool? readStatus;
  DateTime? updatedAt;
  UserId? userId;

  GetNotificationLog({
    this.typename,
    this.createdAt,
    this.description,
    this.id,
    this.masjidId,
    this.notificationMessage,
    this.notificationType,
    this.readStatus,
    this.updatedAt,
    this.userId,
  });

  factory GetNotificationLog.fromJson(Map<String, dynamic> json) => GetNotificationLog(
    typename: json["__typename"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    id: json["id"],
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    notificationMessage: json["notification_message"],
    notificationType: json["notification_type"],
    readStatus: json["read_status_"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "id": id,
    "masjid_id": masjidId?.toJson(),
    "notification_message": notificationMessage,
    "notification_type": notificationType,
    "read_status_": readStatus,
    "updatedAt": updatedAt?.toIso8601String(),
    "user_id": userId?.toJson(),
  };
}

class MasjidId {
  String? typename;
  String? id;
  MasjidImage? masjidImage;
  String? masjidName;

  MasjidId({
    this.typename,
    this.id,
    this.masjidImage,
    this.masjidName,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    id: json["id"],
    masjidImage: json["masjid_image"] == null ? null : MasjidImage.fromJson(json["masjid_image"]),
    masjidName: json["masjid_name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "masjid_image": masjidImage?.toJson(),
    "masjid_name": masjidName,
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

class UserId {
  String? typename;
  String? id;
  String? firstName;

  UserId({
    this.typename,
    this.id,
    this.firstName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    typename: json["__typename"],
    id: json["id"],
    firstName: json["first_name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "first_name": firstName,
  };
}
