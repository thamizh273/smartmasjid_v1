// To parse this JSON data, do
//
//     final readChatMessageModel = readChatMessageModelFromJson(jsonString);

import 'dart:convert';

ReadChatMessageModel readChatMessageModelFromJson(String str) => ReadChatMessageModel.fromJson(json.decode(str));

String readChatMessageModelToJson(ReadChatMessageModel data) => json.encode(data.toJson());

class ReadChatMessageModel {
  String? typename;
  ReadChatMessage? readChatMessage;

  ReadChatMessageModel({
    this.typename,
    this.readChatMessage,
  });

  factory ReadChatMessageModel.fromJson(Map<String, dynamic> json) => ReadChatMessageModel(
    typename: json["__typename"],
    readChatMessage: json["Read_Chat_Message"] == null ? null : ReadChatMessage.fromJson(json["Read_Chat_Message"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Read_Chat_Message": readChatMessage?.toJson(),
  };
}

class ReadChatMessage {
  String? typename;
  List<Message>? message;
  String? chatRoomid;
  String? receiverRoomId;
  String? userId;
  String? id;
  String? messagingId;
  String? receiverName;
  DateTime? lastSeen;
  bool? liveStatus;

  ReadChatMessage({
    this.typename,
    this.message,
    this.chatRoomid,
    this.receiverRoomId,
    this.userId,
    this.id,
    this.messagingId,
    this.receiverName,
    this.lastSeen,
    this.liveStatus,
  });

  factory ReadChatMessage.fromJson(Map<String, dynamic> json) => ReadChatMessage(
    typename: json["__typename"],
    message: json["message"] == null ? [] : List<Message>.from(json["message"]!.map((x) => Message.fromJson(x))),
    chatRoomid: json["chat_roomid"],
    receiverRoomId: json["receiver_room_id"],
    userId: json["user_id"],
    id: json["id"],
    messagingId: json["messaging_id"],
    receiverName: json["receiver_name"],
    lastSeen: json["last_seen"] == null ? null : DateTime.parse(json["last_seen"]),
    liveStatus: json["live_status"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    "chat_roomid": chatRoomid,
    "receiver_room_id": receiverRoomId,
    "user_id": userId,
    "id": id,
    "messaging_id": messagingId,
    "receiver_name": receiverName,
    "last_seen": lastSeen?.toIso8601String(),
    "live_status": liveStatus,
  };
}

class Message {
  Typename? typename;
  String? msg;
  String? type;
  DateTime? time;

  Message({
    this.typename,
    this.msg,
    this.type,
    this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    typename: typenameValues.map[json["__typename"]]!,
    msg: json["message"],
    type: json["type"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "message": msg,
    "type": type,
    "time": time?.toIso8601String(),
  };
}

enum Typename {
  MESSAGE_LIST
}

final typenameValues = EnumValues({
  "message_list": Typename.MESSAGE_LIST
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
