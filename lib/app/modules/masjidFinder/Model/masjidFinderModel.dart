

import 'dart:convert';

MasjidFinderModel masjidFinderModelFromJson(String str) => MasjidFinderModel.fromJson(json.decode(str));

String masjidFinderModelToJson(MasjidFinderModel data) => json.encode(data.toJson());

class MasjidFinderModel {
  String? sTypename;
  List<GetMasjidFilter>? getMasjidFilter;

  MasjidFinderModel({this.sTypename, this.getMasjidFilter});

  MasjidFinderModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['get_masjid_filter'] != null) {
      getMasjidFilter = <GetMasjidFilter>[];
      json['get_masjid_filter'].forEach((v) {
        getMasjidFilter!.add(new GetMasjidFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getMasjidFilter != null) {
      data['get_masjid_filter'] =
          this.getMasjidFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetMasjidFilter {
  String? sTypename;
  String? id;
  String? masjidName;
  String? masjidImage;
  String? area;

  GetMasjidFilter(
      {this.sTypename, this.id, this.masjidName, this.masjidImage, this.area});

  GetMasjidFilter.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    masjidName = json['masjid_name'];
    masjidImage = json['masjid_image'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['id'] = this.id;
    data['masjid_name'] = this.masjidName;
    data['masjid_image'] = this.masjidImage;
    data['area'] = this.area;
    return data;
  }
}
