// To parse this JSON data, do
//
//     final membershipPaymentMonthModel = membershipPaymentMonthModelFromJson(jsonString);

import 'dart:convert';

MembershipPaymentMonthModel membershipPaymentMonthModelFromJson(String str) => MembershipPaymentMonthModel.fromJson(json.decode(str));

String membershipPaymentMonthModelToJson(MembershipPaymentMonthModel data) => json.encode(data.toJson());

class MembershipPaymentMonthModel {
  String? typename;
  MembershipPayments? membershipPayments;

  MembershipPaymentMonthModel({
    this.typename,
    this.membershipPayments,
  });

  factory MembershipPaymentMonthModel.fromJson(Map<String, dynamic> json) => MembershipPaymentMonthModel(
    typename: json["__typename"],
    membershipPayments: json["Membership_Payments_"] == null ? null : MembershipPayments.fromJson(json["Membership_Payments_"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Membership_Payments_": membershipPayments?.toJson(),
  };
}

class MembershipPayments {
  String? typename;
  String? emailId;
  String? firstName;
  String? masjidId;
  String? membershipid;
  List<MonthList>? monthList;
  String? phoneNumber;
  String? userId;
  String? masjidName;
  String? masjidUpiId;
  int? totalAmountPay;

  MembershipPayments({
    this.typename,
    this.emailId,
    this.firstName,
    this.masjidId,
    this.membershipid,
    this.monthList,
    this.phoneNumber,
    this.userId,
    this.masjidName,
    this.masjidUpiId,
    this.totalAmountPay,
  });

  factory MembershipPayments.fromJson(Map<String, dynamic> json) => MembershipPayments(
    typename: json["__typename"],
    emailId: json["email_id"],
    firstName: json["first_name"],
    masjidId: json["masjid_id"],
    membershipid: json["membershipid"],
    monthList: json["month_list"] == null ? [] : List<MonthList>.from(json["month_list"]!.map((x) => MonthList.fromJson(x))),
    phoneNumber: json["phone_number"],
    userId: json["user_id"],
    masjidName: json["masjid_name"],
    masjidUpiId: json["masjid_upi_id"],
    totalAmountPay: json["total_amount_pay"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "email_id": emailId,
    "first_name": firstName,
    "masjid_id": masjidId,
    "membershipid": membershipid,
    "month_list": monthList == null ? [] : List<dynamic>.from(monthList!.map((x) => x.toJson())),
    "phone_number": phoneNumber,
    "user_id": userId,
    "masjid_name": masjidName,
    "masjid_upi_id": masjidUpiId,
    "total_amount_pay": totalAmountPay,
  };
}

class MonthList {
  String? typename;
  String? amount;
  DateTime? monthDue;
  String? paymentMonth;
  String? paymentStatus;

  MonthList({
    this.typename,
    this.amount,
    this.monthDue,
    this.paymentMonth,
    this.paymentStatus,
  });

  factory MonthList.fromJson(Map<String, dynamic> json) => MonthList(
    typename: json["__typename"],
    amount: json["amount"],
    monthDue: json["month_due"] == null ? null : DateTime.parse(json["month_due"]),
    paymentMonth: json["payment_month"],
    paymentStatus: json["payment_status"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "amount": amount,
    "month_due": monthDue?.toIso8601String(),
    "payment_month": paymentMonth,
    "payment_status": paymentStatus,
  };
}
