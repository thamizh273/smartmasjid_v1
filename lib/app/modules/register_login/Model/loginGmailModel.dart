// To parse this JSON data, do
//
//     final loginGmailModel = loginGmailModelFromJson(jsonString);

import 'dart:convert';

LoginGmailModel loginGmailModelFromJson(String str) => LoginGmailModel.fromJson(json.decode(str));

String loginGmailModelToJson(LoginGmailModel data) => json.encode(data.toJson());

class LoginGmailModel {
  String? typename;
  LoginWithGmail? loginWithGmail;

  LoginGmailModel({
    this.typename,
    this.loginWithGmail,
  });

  factory LoginGmailModel.fromJson(Map<String, dynamic> json) => LoginGmailModel(
    typename: json["__typename"],
    loginWithGmail: json["Login_With_Gmail"] == null ? null : LoginWithGmail.fromJson(json["Login_With_Gmail"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Login_With_Gmail": loginWithGmail?.toJson(),
  };
}

class LoginWithGmail {
  String? typename;
  String? masjidId;
  String? message;
  dynamic refreshToken;
  dynamic token;
  String? userId;

  LoginWithGmail({
    this.typename,
    this.masjidId,
    this.message,
    this.refreshToken,
    this.token,
    this.userId,
  });

  factory LoginWithGmail.fromJson(Map<String, dynamic> json) => LoginWithGmail(
    typename: json["__typename"],
    masjidId: json["masjid_id"],
    message: json["message"],
    refreshToken: json["refresh_token"],
    token: json["token"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "masjid_id": masjidId,
    "message": message,
    "refresh_token": refreshToken,
    "token": token,
    "user_id": userId,
  };
}
