// To parse this JSON data, do
//
//     final payMembershipPaymentGateWayModel = payMembershipPaymentGateWayModelFromJson(jsonString);

import 'dart:convert';

PayMembershipPaymentGateWayModel payMembershipPaymentGateWayModelFromJson(String str) => PayMembershipPaymentGateWayModel.fromJson(json.decode(str));

String payMembershipPaymentGateWayModelToJson(PayMembershipPaymentGateWayModel data) => json.encode(data.toJson());

class PayMembershipPaymentGateWayModel {
  String? typename;
  PayMembershipPaymentGateWay? payMembershipPaymentGateWay;

  PayMembershipPaymentGateWayModel({
    this.typename,
    this.payMembershipPaymentGateWay,
  });

  factory PayMembershipPaymentGateWayModel.fromJson(Map<String, dynamic> json) => PayMembershipPaymentGateWayModel(
    typename: json["__typename"],
    payMembershipPaymentGateWay: json["Pay_Membership_Payment_Gate_Way"] == null ? null : PayMembershipPaymentGateWay.fromJson(json["Pay_Membership_Payment_Gate_Way"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Pay_Membership_Payment_Gate_Way": payMembershipPaymentGateWay?.toJson(),
  };
}

class PayMembershipPaymentGateWay {
  String? typename;
  String? id;
  String? code;
  String? masjidId;
  String? message;
  String? paymentId;
  String? token;
  String? userId;

  PayMembershipPaymentGateWay({
    this.typename,
    this.id,
    this.code,
    this.masjidId,
    this.message,
    this.paymentId,
    this.token,
    this.userId,
  });

  factory PayMembershipPaymentGateWay.fromJson(Map<String, dynamic> json) => PayMembershipPaymentGateWay(
    typename: json["__typename"],
    id: json["_id"],
    code: json["code"],
    masjidId: json["masjid_id"],
    message: json["message"],
    paymentId: json["payment_id"],
    token: json["token"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "_id": id,
    "code": code,
    "masjid_id": masjidId,
    "message": message,
    "payment_id": paymentId,
    "token": token,
    "user_id": userId,
  };
}
