// To parse this JSON data, do
//
//     final masjidFinderModel = masjidFinderModelFromJson(jsonString);

import 'dart:convert';

MasjidFinderModel masjidFinderModelFromJson(String str) => MasjidFinderModel.fromJson(json.decode(str));

String masjidFinderModelToJson(MasjidFinderModel data) => json.encode(data.toJson());

class MasjidFinderModel {
  String? typename;
  List<GetMasjidFilter>? getMasjidFilter;

  MasjidFinderModel({
    this.typename,
    this.getMasjidFilter,
  });

  factory MasjidFinderModel.fromJson(Map<String, dynamic> json) => MasjidFinderModel(
    typename: json["__typename"],
    getMasjidFilter: json["get_masjid_filter"] == null ? [] : List<GetMasjidFilter>.from(json["get_masjid_filter"]!.map((x) => GetMasjidFilter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "get_masjid_filter": getMasjidFilter == null ? [] : List<dynamic>.from(getMasjidFilter!.map((x) => x.toJson())),
  };
}

class GetMasjidFilter {
  String? typename;
  String? area;
  String? id;
  MasjidImage? masjidImage;
  String? masjidName;
  String? pinCode;
  String? city;
  String? district;
  String? state;

  GetMasjidFilter({
    this.typename,
    this.area,
    this.id,
    this.masjidImage,
    this.masjidName,
    this.pinCode,
    this.city,
    this.district,
    this.state,
  });

  factory GetMasjidFilter.fromJson(Map<String, dynamic> json) => GetMasjidFilter(
    typename: json["__typename"],
    area: json["area"],
    id: json["id"],
    masjidImage: json["masjid_image"] == null ? null : MasjidImage.fromJson(json["masjid_image"]),
    masjidName: json["masjid_name"],
    pinCode: json["pin_code"],
    city: json["city"],
    district: json["district"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "area": area,
    "id": id,
    "masjid_image": masjidImage?.toJson(),
    "masjid_name": masjidName,
    "pin_code": pinCode,
    "city": city,
    "district": district,
    "state": state,
  };
}

class MasjidImage {
  String? type;
  List<dynamic>? data;

  MasjidImage({
    this.type,
    this.data,
  });

  factory MasjidImage.fromJson(Map<String, dynamic> json) => MasjidImage(
    type: json["type"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
