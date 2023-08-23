// To parse this JSON data, do
//
//     final membershipPayementModel = membershipPayementModelFromJson(jsonString);

import 'dart:convert';

MembershipPayementModel membershipPayementModelFromJson(String str) => MembershipPayementModel.fromJson(json.decode(str));

String membershipPayementModelToJson(MembershipPayementModel data) => json.encode(data.toJson());

class MembershipPayementModel {
  String? typename;
  List<GetMembershipPaymentDetail>? getMembershipPaymentDetail;

  MembershipPayementModel({
    this.typename,
    this.getMembershipPaymentDetail,
  });

  factory MembershipPayementModel.fromJson(Map<String, dynamic> json) => MembershipPayementModel(
    typename: json["__typename"],
    getMembershipPaymentDetail: json["Get_Membership_Payment_Detail"] == null ? [] : List<GetMembershipPaymentDetail>.from(json["Get_Membership_Payment_Detail"]!.map((x) => GetMembershipPaymentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Membership_Payment_Detail": getMembershipPaymentDetail == null ? [] : List<dynamic>.from(getMembershipPaymentDetail!.map((x) => x.toJson())),
  };
}

class GetMembershipPaymentDetail {
  String? typename;
  int? amount;
  DateTime? expireDate;
  String? id;
  String? membershipid;
  DateTime? paymentDate;
  String? paymentMethod;
  DateTime? paymentMonth;
  String? paymentStatus;
  String? paymentType;
  int? receiptNo;
  String? transactionid;

  GetMembershipPaymentDetail({
    this.typename,
    this.amount,
    this.expireDate,
    this.id,
    this.membershipid,
    this.paymentDate,
    this.paymentMethod,
    this.paymentMonth,
    this.paymentStatus,
    this.paymentType,
    this.receiptNo,
    this.transactionid,
  });

  factory GetMembershipPaymentDetail.fromJson(Map<String, dynamic> json) => GetMembershipPaymentDetail(
    typename: json["__typename"],
    amount: json["amount"],
    expireDate: json["expire_date"] == null ? null : DateTime.parse(json["expire_date"]),
    id: json["id"],
    membershipid: json["membershipid"],
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
    paymentMethod: json["payment_method"],
    paymentMonth: json["payment_month"] == null ? null : DateTime.parse(json["payment_month"]),
    paymentStatus: json["payment_status"],
    paymentType: json["payment_type"],
    receiptNo: json["receipt_no"],
    transactionid: json["transactionid"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "amount": amount,
    "expire_date": expireDate?.toIso8601String(),
    "id": id,
    "membershipid": membershipid,
    "payment_date": paymentDate?.toIso8601String(),
    "payment_method": paymentMethod,
    "payment_month": paymentMonth?.toIso8601String(),
    "payment_status": paymentStatus,
    "payment_type": paymentType,
    "receipt_no": receiptNo,
    "transactionid": transactionid,
  };
}
