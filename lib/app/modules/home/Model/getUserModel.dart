// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  String? typename;
  GetUserById? getUserById;

  GetUserModel({
    this.typename,
    this.getUserById,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
    typename: json["__typename"],
    getUserById: json["Get_User_By_Id"] == null ? null : GetUserById.fromJson(json["Get_User_By_Id"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_User_By_Id": getUserById?.toJson(),
  };
}

class GetUserById {
  String? typename;
  String? id;
  ProfileImage? profileImage;
  String? authUid;
  dynamic dob;
  String? emailId;
  String? firstName;
  String? language;
  String? lastName;
  dynamic liveStatus;
  MasjidId? masjidId;
  String? memberStatus;
  String? phoneNumber;
  dynamic post;
  String? userType;

  GetUserById({
    this.typename,
    this.id,
    this.profileImage,
    this.authUid,
    this.dob,
    this.emailId,
    this.firstName,
    this.language,
    this.lastName,
    this.liveStatus,
    this.masjidId,
    this.memberStatus,
    this.phoneNumber,
    this.post,
    this.userType,
  });

  factory GetUserById.fromJson(Map<String, dynamic> json) => GetUserById(
    typename: json["__typename"],
    id: json["id"],
    profileImage: json["profile_image"] == null ? null : ProfileImage.fromJson(json["profile_image"]),
    authUid: json["auth_uid"],
    dob: json["dob"],
    emailId: json["email_id"],
    firstName: json["first_name"],
    language: json["language"],
    lastName: json["last_name"],
    liveStatus: json["live_status"],
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    memberStatus: json["member_status"],
    phoneNumber: json["phone_number"],
    post: json["post"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "profile_image": profileImage?.toJson(),
    "auth_uid": authUid,
    "dob": dob,
    "email_id": emailId,
    "first_name": firstName,
    "language": language,
    "last_name": lastName,
    "live_status": liveStatus,
    "masjid_id": masjidId?.toJson(),
    "member_status": memberStatus,
    "phone_number": phoneNumber,
    "post": post,
    "user_type": userType,
  };
}

class MasjidId {
  String? typename;
  String? id;
  String? masjidName;
  String? state;
  String? area;
  String? about;
  String? district;

  MasjidId({
    this.typename,
    this.id,
    this.masjidName,
    this.state,
    this.area,
    this.about,
    this.district,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    id: json["id"],
    masjidName: json["masjid_name"],
    state: json["state"],
    area: json["area"],
    about: json["about"],
    district: json["district"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "masjid_name": masjidName,
    "state": state,
    "area": area,
    "about": about,
    "district": district,
  };
}

class ProfileImage {
  String? type;
  List<int>? data;

  ProfileImage({
    this.type,
    this.data,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    type: json["type"],
    data: json["data"] == null ? [] : List<int>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
