// To parse this JSON data, do
//
//     final paymentInvoiceModel = paymentInvoiceModelFromJson(jsonString);

import 'dart:convert';

PaymentInvoiceModel paymentInvoiceModelFromJson(String str) => PaymentInvoiceModel.fromJson(json.decode(str));

String paymentInvoiceModelToJson(PaymentInvoiceModel data) => json.encode(data.toJson());

class PaymentInvoiceModel {
  String? typename;
  ViewPaymentReceipt? viewPaymentReceipt;

  PaymentInvoiceModel({
    this.typename,
    this.viewPaymentReceipt,
  });

  factory PaymentInvoiceModel.fromJson(Map<String, dynamic> json) => PaymentInvoiceModel(
    typename: json["__typename"],
    viewPaymentReceipt: json["View__Payment__Receipt"] == null ? null : ViewPaymentReceipt.fromJson(json["View__Payment__Receipt"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "View__Payment__Receipt": viewPaymentReceipt?.toJson(),
  };
}

class ViewPaymentReceipt {
  String? typename;
  int? amount;
  String? billCollector;
  String? expireDate;
  String? inWords;
  MasjidId? masjidId;
  int? receiptNo;
  String? paymentDate;
  UserId? userId;
  String? paymentType;
  String? paymentMonth;
  String? paymentMethod;
  String? secretary;

  ViewPaymentReceipt({
    this.typename,
    this.amount,
    this.billCollector,
    this.expireDate,
    this.inWords,
    this.masjidId,
    this.receiptNo,
    this.paymentDate,
    this.userId,
    this.paymentType,
    this.paymentMonth,
    this.paymentMethod,
    this.secretary,
  });

  factory ViewPaymentReceipt.fromJson(Map<String, dynamic> json) => ViewPaymentReceipt(
    typename: json["__typename"],
    amount: json["amount"],
    billCollector: json["bill_collector"],
    expireDate: json["expire_date"],
    inWords: json["in_words_"],
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    receiptNo: json["receipt_no"],
    paymentDate: json["payment_date"],
    userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
    paymentType: json["payment_type"],
    paymentMonth: json["payment_month"],
    paymentMethod: json["payment_method"],
    secretary: json["secretary_"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "amount": amount,
    "bill_collector": billCollector,
    "expire_date": expireDate,
    "in_words_": inWords,
    "masjid_id": masjidId?.toJson(),
    "receipt_no": receiptNo,
    "payment_date": paymentDate,
    "user_id": userId?.toJson(),
    "payment_type": paymentType,
    "payment_month": paymentMonth,
    "payment_method": paymentMethod,
    "secretary_": secretary,
  };
}

class MasjidId {
  String? typename;
  String? masjidName;
  String? phoneNumber;
  String? pinCode;
  String? state;
  String? address;
  String? area;
  String? city;
  String? country;
  String? district;

  MasjidId({
    this.typename,
    this.masjidName,
    this.phoneNumber,
    this.pinCode,
    this.state,
    this.address,
    this.area,
    this.city,
    this.country,
    this.district,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    masjidName: json["masjid_name"],
    phoneNumber: json["phone_number"],
    pinCode: json["pin_code"],
    state: json["state"],
    address: json["address"],
    area: json["area"],
    city: json["city"],
    country: json["country"],
    district: json["district"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "masjid_name": masjidName,
    "phone_number": phoneNumber,
    "pin_code": pinCode,
    "state": state,
    "address": address,
    "area": area,
    "city": city,
    "country": country,
    "district": district,
  };
}

class UserId {
  String? typename;
  String? firstName;
  String? userUniqueId;

  UserId({
    this.typename,
    this.firstName,
    this.userUniqueId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    typename: json["__typename"],
    firstName: json["first_name"],
    userUniqueId: json["user_unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "first_name": firstName,
    "user_unique_id": userUniqueId,
  };
}
