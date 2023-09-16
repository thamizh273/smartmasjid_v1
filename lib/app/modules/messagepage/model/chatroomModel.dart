// To parse this JSON data, do
//
//     final chatroomModel = chatroomModelFromJson(jsonString);

import 'dart:convert';

ChatroomModel chatroomModelFromJson(String str) => ChatroomModel.fromJson(json.decode(str));

String chatroomModelToJson(ChatroomModel data) => json.encode(data.toJson());

class ChatroomModel {
  String? typename;
  GetChatroom? getChatroom;

  ChatroomModel({
    this.typename,
    this.getChatroom,
  });

  factory ChatroomModel.fromJson(Map<String, dynamic> json) => ChatroomModel(
    typename: json["__typename"],
    getChatroom: json["Get_Chatroom"] == null ? null : GetChatroom.fromJson(json["Get_Chatroom"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Chatroom": getChatroom?.toJson(),
  };
}

class GetChatroom {
  String? typename;
  String? chatRoomid;
  String? id;
  DateTime? lastSeen;
  bool? liveStatus;
  int? notificationCount;
  Id? userId;
  List<Chat>? chat;

  GetChatroom({
    this.typename,
    this.chatRoomid,
    this.id,
    this.lastSeen,
    this.liveStatus,
    this.notificationCount,
    this.userId,
    this.chat,
  });

  factory GetChatroom.fromJson(Map<String, dynamic> json) => GetChatroom(
    typename: json["__typename"],
    chatRoomid: json["chat_roomid"],
    id: json["id"],
    lastSeen: json["last_seen"] == null ? null : DateTime.parse(json["last_seen"]),
    liveStatus: json["live_status"],
    notificationCount: json["notification_count"],
    userId: json["user_id"] == null ? null : Id.fromJson(json["user_id"]),
    chat: json["chat"] == null ? [] : List<Chat>.from(json["chat"]!.map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "chat_roomid": chatRoomid,
    "id": id,
    "last_seen": lastSeen?.toIso8601String(),
    "live_status": liveStatus,
    "notification_count": notificationCount,
    "user_id": userId?.toJson(),
    "chat": chat == null ? [] : List<dynamic>.from(chat!.map((x) => x.toJson())),
  };
}

class Chat {
  String? typename;
  String? id;
  String? lastMessage;
  DateTime? lastMessageTime;
  bool? liveStatus;
  int? unReadCount;
  Id? messagingId;

  Chat({
    this.typename,
    this.id,
    this.lastMessage,
    this.lastMessageTime,
    this.liveStatus,
    this.unReadCount,
    this.messagingId,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    typename: json["__typename"],
    id: json["id"],
    lastMessage: json["last_message"],
    lastMessageTime: json["last_message_time"] == null ? null : DateTime.parse(json["last_message_time"]),
    liveStatus: json["live_status"],
    unReadCount: json["un_read_count"],
    messagingId: json["messaging_id"] == null ? null : Id.fromJson(json["messaging_id"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "last_message": lastMessage,
    "last_message_time": lastMessageTime?.toIso8601String(),
    "live_status": liveStatus,
    "un_read_count": unReadCount,
    "messaging_id": messagingId?.toJson(),
  };
}

class Id {
  String? typename;
  String? id;
  String? firstName;
  String? profileImage;

  Id({
    this.typename,
    this.id,
    this.firstName,
    this.profileImage,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    typename: json["__typename"],
    id: json["id"],
    firstName: json["first_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "first_name": firstName,
    "profile_image": profileImage,
  };
}
