// To parse this JSON data, do
//
//     final masjidFacilityModel = masjidFacilityModelFromJson(jsonString);

import 'dart:convert';

MasjidFacilityModel masjidFacilityModelFromJson(String str) => MasjidFacilityModel.fromJson(json.decode(str));

String masjidFacilityModelToJson(MasjidFacilityModel data) => json.encode(data.toJson());

class MasjidFacilityModel {
  String? typename;
  List<GetMasjidFacilitiesList>? getMasjidFacilitiesList;

  MasjidFacilityModel({
    this.typename,
    this.getMasjidFacilitiesList,
  });

  factory MasjidFacilityModel.fromJson(Map<String, dynamic> json) => MasjidFacilityModel(
    typename: json["__typename"],
    getMasjidFacilitiesList: json["Get_Masjid_Facilities_List"] == null ? [] : List<GetMasjidFacilitiesList>.from(json["Get_Masjid_Facilities_List"]!.map((x) => GetMasjidFacilitiesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Masjid_Facilities_List": getMasjidFacilitiesList == null ? [] : List<dynamic>.from(getMasjidFacilitiesList!.map((x) => x.toJson())),
  };
}

class GetMasjidFacilitiesList {
  String? typename;
  String? id;
  String? facilityTitle;
  List<NameList>? nameList;

  GetMasjidFacilitiesList({
    this.typename,
    this.id,
    this.facilityTitle,
    this.nameList,
  });

  factory GetMasjidFacilitiesList.fromJson(Map<String, dynamic> json) => GetMasjidFacilitiesList(
    typename: json["__typename"],
    id: json["id"],
    facilityTitle: json["facility_title"],
    nameList: json["name_list"] == null ? [] : List<NameList>.from(json["name_list"]!.map((x) => NameList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "id": id,
    "facility_title": facilityTitle,
    "name_list": nameList == null ? [] : List<dynamic>.from(nameList!.map((x) => x.toJson())),
  };
}

class NameList {
  Typename? typename;
  String? id;
  String? facilityName;
  bool? facilityStatus;

  NameList({
    this.typename,
    this.id,
    this.facilityName,
    this.facilityStatus,
  });

  factory NameList.fromJson(Map<String, dynamic> json) => NameList(
    typename: typenameValues.map[json["__typename"]]!,
    id: json["id"],
    facilityName: json["facility_name"],
    facilityStatus: json["facility_status"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typenameValues.reverse[typename],
    "id": id,
    "facility_name": facilityName,
    "facility_status": facilityStatus,
  };
}

enum Typename {
  FACILITIES_LIST
}

final typenameValues = EnumValues({
  "facilities__list": Typename.FACILITIES_LIST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
