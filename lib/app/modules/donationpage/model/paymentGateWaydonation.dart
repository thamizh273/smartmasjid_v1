// To parse this JSON data, do
//
//     final paymentGateWayDonationModel = paymentGateWayDonationModelFromJson(jsonString);

import 'dart:convert';

PaymentGateWayDonationModel paymentGateWayDonationModelFromJson(String str) => PaymentGateWayDonationModel.fromJson(json.decode(str));

String paymentGateWayDonationModelToJson(PaymentGateWayDonationModel data) => json.encode(data.toJson());

class PaymentGateWayDonationModel {
  String? typename;
  PaymentGateWay? paymentGateWay;

  PaymentGateWayDonationModel({
    this.typename,
    this.paymentGateWay,
  });

  factory PaymentGateWayDonationModel.fromJson(Map<String, dynamic> json) => PaymentGateWayDonationModel(
    typename: json["__typename"],
    paymentGateWay: json["Payment_Gate_Way_"] == null ? null : PaymentGateWay.fromJson(json["Payment_Gate_Way_"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Payment_Gate_Way_": paymentGateWay?.toJson(),
  };
}

class PaymentGateWay {
  String? typename;
  String? id;
  String? userId;
  String? paymentId;
  String? merchantId;
  String? masjidId;
  String? token;
  String? message;
  String? code;

  PaymentGateWay({
    this.typename,
    this.id,
    this.userId,
    this.paymentId,
    this.merchantId,
    this.masjidId,
    this.token,
    this.message,
    this.code,
  });

  factory PaymentGateWay.fromJson(Map<String, dynamic> json) => PaymentGateWay(
    typename: json["__typename"],
    id: json["_id"],
    userId: json["user_id"],
    paymentId: json["payment_id"],
    merchantId: json["merchant_id"],
    masjidId: json["masjid_id"],
    token: json["token"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "_id": id,
    "user_id": userId,
    "payment_id": paymentId,
    "merchant_id": merchantId,
    "masjid_id": masjidId,
    "token": token,
    "message": message,
    "code": code,
  };
}
