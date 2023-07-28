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
  String? profileImage;
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
  List<Address>? address;
  String? userUniqueId;

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
    this.address,
    this.userUniqueId,
  });

  factory GetUserById.fromJson(Map<String, dynamic> json) => GetUserById(
    typename: json["__typename"],
    id: json["id"],
    profileImage: json["profile_image"],
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
    address: json["address"] == null ? [] : List<Address>.from(json["address"]!.map((x) => Address.fromJson(x))),
    userUniqueId: json["user_unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "profile_image": profileImage,
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
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x.toJson())),
    "user_unique_id": userUniqueId,
  };
}

class Address {
  String? typename;
  String? addressType;
  String? area;
  String? country;
  String? district;
  String? doorNo;
  String? masjidId;
  String? pincode;
  String? state;
  String? streetName;
  String? userId;
  String? userType;
  String? id;

  Address({
    this.typename,
    this.addressType,
    this.area,
    this.country,
    this.district,
    this.doorNo,
    this.masjidId,
    this.pincode,
    this.state,
    this.streetName,
    this.userId,
    this.userType,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    typename: json["__typename"],
    addressType: json["address_type"],
    area: json["area"],
    country: json["country"],
    district: json["district"],
    doorNo: json["door_no"],
    masjidId: json["masjid_id"],
    pincode: json["pincode"],
    state: json["state"],
    streetName: json["street_name"],
    userId: json["user_id"],
    userType: json["user_type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "address_type": addressType,
    "area": area,
    "country": country,
    "district": district,
    "door_no": doorNo,
    "masjid_id": masjidId,
    "pincode": pincode,
    "state": state,
    "street_name": streetName,
    "user_id": userId,
    "user_type": userType,
    "id": id,
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
  String? address;

  MasjidId({
    this.typename,
    this.id,
    this.masjidName,
    this.state,
    this.area,
    this.about,
    this.district,
    this.address,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    id: json["id"],
    masjidName: json["masjid_name"],
    state: json["state"],
    area: json["area"],
    about: json["about"],
    district: json["district"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "masjid_name": masjidName,
    "state": state,
    "area": area,
    "about": about,
    "district": district,
    "address": address,
  };
}
