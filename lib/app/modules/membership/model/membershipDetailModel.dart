// To parse this JSON data, do
//
//     final membershipDetailModel = membershipDetailModelFromJson(jsonString);

import 'dart:convert';

MembershipDetailModel membershipDetailModelFromJson(String str) => MembershipDetailModel.fromJson(json.decode(str));

String membershipDetailModelToJson(MembershipDetailModel data) => json.encode(data.toJson());

class MembershipDetailModel {
  String? typename;
  GetMembershipDetail? getMembershipDetail;

  MembershipDetailModel({
    this.typename,
    this.getMembershipDetail,
  });

  factory MembershipDetailModel.fromJson(Map<String, dynamic> json) => MembershipDetailModel(
    typename: json["__typename"],
    getMembershipDetail: json["Get_Membership_Detail"] == null ? null : GetMembershipDetail.fromJson(json["Get_Membership_Detail"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Membership_Detail": getMembershipDetail?.toJson(),
  };
}

class GetMembershipDetail {
  String? typename;
  MasjidId? masjidId;
  String? membershipid;
  List<MonthChart>? monthChart;
  CurrentPayment? currentPayment;
  UserId? userId;
  int? bulkPayAnnual;
  int? bulkPaySix;
  int? bulkPayThree;

  GetMembershipDetail({
    this.typename,
    this.masjidId,
    this.membershipid,
    this.monthChart,
    this.currentPayment,
    this.userId,
    this.bulkPayAnnual,
    this.bulkPaySix,
    this.bulkPayThree,
  });

  factory GetMembershipDetail.fromJson(Map<String, dynamic> json) => GetMembershipDetail(
    typename: json["__typename"],
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    membershipid: json["membershipid"],
    monthChart: json["month_chart"] == null ? [] : List<MonthChart>.from(json["month_chart"]!.map((x) => MonthChart.fromJson(x))),
    currentPayment: json["current_payment"] == null ? null : CurrentPayment.fromJson(json["current_payment"]),
    userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
    bulkPayAnnual: json["bulk_pay_annual"],
    bulkPaySix: json["bulk_pay_six"],
    bulkPayThree: json["bulk_pay_three"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "masjid_id": masjidId?.toJson(),
    "membershipid": membershipid,
    "month_chart": monthChart == null ? [] : List<dynamic>.from(monthChart!.map((x) => x.toJson())),
    "current_payment": currentPayment?.toJson(),
    "user_id": userId?.toJson(),
    "bulk_pay_annual": bulkPayAnnual,
    "bulk_pay_six": bulkPaySix,
    "bulk_pay_three": bulkPayThree,
  };
}

class CurrentPayment {
  String? typename;
  int? amount;
  DateTime? paymentMonth;
  String? paymentStatus;
  String? expireDate;

  CurrentPayment({
    this.typename,
    this.amount,
    this.paymentMonth,
    this.paymentStatus,
    this.expireDate,
  });

  factory CurrentPayment.fromJson(Map<String, dynamic> json) => CurrentPayment(
    typename: json["__typename"],
    amount: json["amount"],
    paymentMonth: json["payment_month"] == null ? null : DateTime.parse(json["payment_month"]),
    paymentStatus: json["payment_status"],
    expireDate: json["expire_date"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "amount": amount,
    "payment_month": paymentMonth?.toIso8601String(),
    "payment_status": paymentStatus,
    "expire_date": expireDate,
  };
}

class MasjidId {
  String? typename;
  String? id;
  String? masjidName;

  MasjidId({
    this.typename,
    this.id,
    this.masjidName,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    id: json["id"],
    masjidName: json["masjid_name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "masjid_name": masjidName,
  };
}

class MonthChart {
  String? typename;
  String? amount;
  DateTime? paymentMonth;
  String? paymentStatus;

  MonthChart({
    this.typename,
    this.amount,
    this.paymentMonth,
    this.paymentStatus,
  });

  factory MonthChart.fromJson(Map<String, dynamic> json) => MonthChart(
    typename: json["__typename"],
    amount: json["amount"],
    paymentMonth: json["payment_month"] == null ? null : DateTime.parse(json["payment_month"]),
    paymentStatus: json["payment_status"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "amount": amount,
    "payment_month": paymentMonth?.toIso8601String(),
    "payment_status": paymentStatus,
  };
}

class UserId {
  String? typename;
  String? id;
  String? firstName;
  String? userUniqueId;
  String? phoneNumber;

  UserId({
    this.typename,
    this.id,
    this.firstName,
    this.userUniqueId,
    this.phoneNumber,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    typename: json["__typename"],
    id: json["id"],
    firstName: json["first_name"],
    userUniqueId: json["user_unique_id"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "first_name": firstName,
    "user_unique_id": userUniqueId,
    "phone_number": phoneNumber,
  };
}
