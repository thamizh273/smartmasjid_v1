// To parse this JSON data, do
//
//     final getUserIdPhoneModel = getUserIdPhoneModelFromJson(jsonString);

import 'dart:convert';

GetUserIdPhoneModel getUserIdPhoneModelFromJson(String str) => GetUserIdPhoneModel.fromJson(json.decode(str));

String getUserIdPhoneModelToJson(GetUserIdPhoneModel data) => json.encode(data.toJson());

class GetUserIdPhoneModel {
  String? typename;
  LoginUser? loginUser;

  GetUserIdPhoneModel({
    this.typename,
    this.loginUser,
  });

  factory GetUserIdPhoneModel.fromJson(Map<String, dynamic> json) => GetUserIdPhoneModel(
    typename: json["__typename"],
    loginUser: json["Login_User"] == null ? null : LoginUser.fromJson(json["Login_User"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Login_User": loginUser?.toJson(),
  };
}

class LoginUser {
  String? typename;
  String? message;
  String? refreshToken;
  String? token;
  String? userId;

  LoginUser({
    this.typename,
    this.message,
    this.refreshToken,
    this.token,
    this.userId,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    typename: json["__typename"],
    message: json["message"],
    refreshToken: json["refresh_token"],
    token: json["token"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "message": message,
    "refresh_token": refreshToken,
    "token": token,
    "user_id": userId,
  };
}
