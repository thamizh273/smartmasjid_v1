

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
  String? area;
  String? id;
  String? masjidImage;
  String? masjidName;
  String? pinCode;
  String? city;
  String? district;
  String? state;

  GetMasjidFilter(
      {this.sTypename,
        this.area,
        this.id,
        this.masjidImage,
        this.masjidName,
        this.pinCode,
        this.city,
        this.district,
        this.state});

  GetMasjidFilter.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    area = json['area'];
    id = json['id'];
    masjidImage = json['masjid_image'];
    masjidName = json['masjid_name'];
    pinCode = json['pin_code'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['area'] = this.area;
    data['id'] = this.id;
    data['masjid_image'] = this.masjidImage;
    data['masjid_name'] = this.masjidName;
    data['pin_code'] = this.pinCode;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    return data;
  }
}
