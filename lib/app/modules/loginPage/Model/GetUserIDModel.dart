

import 'dart:convert';

GetUserIdModel getUserIdModelFromJson(String str) => GetUserIdModel.fromJson(json.decode(str));

String getUserIdModelToJson(GetUserIdModel data) => json.encode(data.toJson());



class GetUserIdModel {
  String? sTypename;
  LoginUser? loginUser;

  GetUserIdModel({this.sTypename, this.loginUser});

  GetUserIdModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    loginUser = json['Login_User'] != null
        ? new LoginUser.fromJson(json['Login_User'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.loginUser != null) {
      data['Login_User'] = this.loginUser!.toJson();
    }
    return data;
  }
}

class LoginUser {
  String? sTypename;
  String? message;
  String? refreshToken;
  String? token;
  String? userId;

  LoginUser(
      {this.sTypename,
        this.message,
        this.refreshToken,
        this.token,
        this.userId});

  LoginUser.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    message = json['message'];
    refreshToken = json['refresh_token'];
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['message'] = this.message;
    data['refresh_token'] = this.refreshToken;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}
