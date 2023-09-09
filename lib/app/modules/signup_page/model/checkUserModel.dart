// To parse this JSON data, do
//
//     final checkUserModel = checkUserModelFromJson(jsonString);

import 'dart:convert';

CheckUserModel checkUserModelFromJson(String str) => CheckUserModel.fromJson(json.decode(str));

String checkUserModelToJson(CheckUserModel data) => json.encode(data.toJson());

class CheckUserModel {
  String? typename;
  String? checkUserValidVerification;

  CheckUserModel({
    this.typename,
    this.checkUserValidVerification,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => CheckUserModel(
    typename: json["__typename"],
    checkUserValidVerification: json["Check_User_Valid_Verification"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Check_User_Valid_Verification": checkUserValidVerification,
  };
}
