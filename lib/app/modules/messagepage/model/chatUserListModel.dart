// To parse this JSON data, do
//
//     final chatUserListModel = chatUserListModelFromJson(jsonString);

import 'dart:convert';

ChatUserListModel chatUserListModelFromJson(String str) => ChatUserListModel.fromJson(json.decode(str));

String chatUserListModelToJson(ChatUserListModel data) => json.encode(data.toJson());

class ChatUserListModel {
  String? typename;
  List<GetChatUserList>? getChatUserList;

  ChatUserListModel({
    this.typename,
    this.getChatUserList,
  });

  factory ChatUserListModel.fromJson(Map<String, dynamic> json) => ChatUserListModel(
    typename: json["__typename"],
    getChatUserList: json["Get_Chat_User_List"] == null ? [] : List<GetChatUserList>.from(json["Get_Chat_User_List"]!.map((x) => GetChatUserList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Chat_User_List": getChatUserList == null ? [] : List<dynamic>.from(getChatUserList!.map((x) => x.toJson())),
  };
}

class GetChatUserList {
  String? typename;
  String? post;
  UserId? userId;
  String? userName;
  String? userType;
  String? profileImage;

  GetChatUserList({
    this.typename,
    this.post,
    this.userId,
    this.userName,
    this.userType,
    this.profileImage,
  });

  factory GetChatUserList.fromJson(Map<String, dynamic> json) => GetChatUserList(
    typename: json["__typename"],
    post: json["post_"],
    userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
    userName: json["user_name"],
    userType: json["user_type"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "post_": post,
    "user_id": userId?.toJson(),
    "user_name": userName,
    "user_type": userType,
    "profile_image": profileImage,
  };
}

class UserId {
  String? typename;
  String? id;

  UserId({
    this.typename,
    this.id,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    typename: json["__typename"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
  };
}
