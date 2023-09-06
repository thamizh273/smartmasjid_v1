// To parse this JSON data, do
//
//     final pastDonationModel = pastDonationModelFromJson(jsonString);

import 'dart:convert';

PastDonationModel pastDonationModelFromJson(String str) => PastDonationModel.fromJson(json.decode(str));

String pastDonationModelToJson(PastDonationModel data) => json.encode(data.toJson());

class PastDonationModel {
  String? typename;
  List<GetDonationPayList>? getDonationPayList;

  PastDonationModel({
    this.typename,
    this.getDonationPayList,
  });

  factory PastDonationModel.fromJson(Map<String, dynamic> json) => PastDonationModel(
    typename: json["__typename"],
    getDonationPayList: json["Get_Donation_Pay_list"] == null ? [] : List<GetDonationPayList>.from(json["Get_Donation_Pay_list"]!.map((x) => GetDonationPayList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Donation_Pay_list": getDonationPayList == null ? [] : List<dynamic>.from(getDonationPayList!.map((x) => x.toJson())),
  };
}

class GetDonationPayList {
  String? typename;
  int? amountDonated;
  DonationId? donationId;
  String? paymentDate;
  String? paymentMethod;
  String? id;

  GetDonationPayList({
    this.typename,
    this.amountDonated,
    this.donationId,
    this.paymentDate,
    this.paymentMethod,
    this.id,
  });

  factory GetDonationPayList.fromJson(Map<String, dynamic> json) => GetDonationPayList(
    typename: json["__typename"],
    amountDonated: json["amount_donated"],
    donationId: json["donation_id_"] == null ? null : DonationId.fromJson(json["donation_id_"]),
    paymentDate: json["payment_date"],
    paymentMethod: json["payment_method"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "amount_donated": amountDonated,
    "donation_id_": donationId?.toJson(),
    "payment_date": paymentDate,
    "payment_method": paymentMethod,
    "id": id,
  };
}

class DonationId {
  String? typename;
  String? donationTitle;
  String? donationType;
  String? image;
  String? id;

  DonationId({
    this.typename,
    this.donationTitle,
    this.donationType,
    this.image,
    this.id,
  });

  factory DonationId.fromJson(Map<String, dynamic> json) => DonationId(
    typename: json["__typename"],
    donationTitle: json["donation_title"],
    donationType: json["donation_type"],
    image: json["image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "donation_title": donationTitle,
    "donation_type": donationType,
    "image": image,
    "id": id,
  };
}
