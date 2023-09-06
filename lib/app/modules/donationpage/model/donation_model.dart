// To parse this JSON data, do
//
//     final masjidDonationsModel = masjidDonationsModelFromJson(jsonString);

import 'dart:convert';

MasjidDonationsModel masjidDonationsModelFromJson(String str) => MasjidDonationsModel.fromJson(json.decode(str));

String masjidDonationsModelToJson(MasjidDonationsModel data) => json.encode(data.toJson());

class MasjidDonationsModel {
  String? typename;
  List<GetMasjidDonation>? getMasjidDonations;

  MasjidDonationsModel({
    this.typename,
    this.getMasjidDonations,
  });

  factory MasjidDonationsModel.fromJson(Map<String, dynamic> json) => MasjidDonationsModel(
    typename: json["__typename"],
    getMasjidDonations: json["Get_Masjid_Donations"] == null ? [] : List<GetMasjidDonation>.from(json["Get_Masjid_Donations"]!.map((x) => GetMasjidDonation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Masjid_Donations": getMasjidDonations == null ? [] : List<dynamic>.from(getMasjidDonations!.map((x) => x.toJson())),
  };
}

class GetMasjidDonation {
  String? typename;
  double? collectionAmount;
  String? currencyType;
  double? donationRaisedAmount;
  String? donationTitle;
  String? donationType;
  DateTime? expiryDate;
  Fundraiser? fundraiser;
  String? id;
  MasjidId? masjidId;
  double? neededAmount;
  int? percentCalculation;
  DateTime? startDate;
  String? image;

  GetMasjidDonation({
    this.typename,
    this.collectionAmount,
    this.currencyType,
    this.donationRaisedAmount,
    this.donationTitle,
    this.donationType,
    this.expiryDate,
    this.fundraiser,
    this.id,
    this.masjidId,
    this.neededAmount,
    this.percentCalculation,
    this.startDate,
    this.image,
  });

  factory GetMasjidDonation.fromJson(Map<String, dynamic> json) => GetMasjidDonation(
    typename: json["__typename"],
    collectionAmount: json["collection_amount"]?.toDouble(),
    currencyType: json["currency_type"],
    donationRaisedAmount: json["donation_raised_amount"]?.toDouble(),
    donationTitle: json["donation_title"],
    donationType: json["donation_type"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    fundraiser: json["fundraiser"] == null ? null : Fundraiser.fromJson(json["fundraiser"]),
    id: json["id"],
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    neededAmount: json["needed_amount"]?.toDouble(),
    percentCalculation: json["percent_calculation"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "collection_amount": collectionAmount,
    "currency_type": currencyType,
    "donation_raised_amount": donationRaisedAmount,
    "donation_title": donationTitle,
    "donation_type": donationType,
    "expiry_date": expiryDate?.toIso8601String(),
    "fundraiser": fundraiser?.toJson(),
    "id": id,
    "masjid_id": masjidId?.toJson(),
    "needed_amount": neededAmount,
    "percent_calculation": percentCalculation,
    "start_date": startDate?.toIso8601String(),
    "image": image,
  };
}

class Fundraiser {
  String? typename;
  String? id;
  String? firstName;

  Fundraiser({
    this.typename,
    this.id,
    this.firstName,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json) => Fundraiser(
    typename: json["__typename"],
    id: json["id"],
    firstName: json["first_name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "first_name": firstName,
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
