// To parse this JSON data, do
//
//     final masjidGalleryModel = masjidGalleryModelFromJson(jsonString);

import 'dart:convert';

MasjidGalleryModel masjidGalleryModelFromJson(String str) => MasjidGalleryModel.fromJson(json.decode(str));

String masjidGalleryModelToJson(MasjidGalleryModel data) => json.encode(data.toJson());

class MasjidGalleryModel {
  String? typename;
  List<GetMasjidGalleryImage>? getMasjidGalleryImages;

  MasjidGalleryModel({
    this.typename,
    this.getMasjidGalleryImages,
  });

  factory MasjidGalleryModel.fromJson(Map<String, dynamic> json) => MasjidGalleryModel(
    typename: json["__typename"],
    getMasjidGalleryImages: json["Get_Masjid_Gallery_Images"] == null ? [] : List<GetMasjidGalleryImage>.from(json["Get_Masjid_Gallery_Images"]!.map((x) => GetMasjidGalleryImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Masjid_Gallery_Images": getMasjidGalleryImages == null ? [] : List<dynamic>.from(getMasjidGalleryImages!.map((x) => x.toJson())),
  };
}

class GetMasjidGalleryImage {
  String? typename;
  Image? image;
  String? masjidId;
  String? id;
  String? adminId;

  GetMasjidGalleryImage({
    this.typename,
    this.image,
    this.masjidId,
    this.id,
    this.adminId,
  });

  factory GetMasjidGalleryImage.fromJson(Map<String, dynamic> json) => GetMasjidGalleryImage(
    typename: json["__typename"],
    image: json["Image"] == null ? null : Image.fromJson(json["Image"]),
    masjidId: json["masjid_id"],
    id: json["id"],
    adminId: json["admin_id"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Image": image?.toJson(),
    "masjid_id": masjidId,
    "id": id,
    "admin_id": adminId,
  };
}

class Image {
  String? type;
  List<int>? data;

  Image({
    this.type,
    this.data,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    type: json["type"],
    data: json["data"] == null ? [] : List<int>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
