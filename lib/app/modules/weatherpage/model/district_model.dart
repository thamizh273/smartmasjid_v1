import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());



class DistrictModel {
  String? sTypename;
  List<GetDistrictByState>? getDistrictByState;

  DistrictModel({this.sTypename, this.getDistrictByState});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['Get_District_By_State'] != null) {
      getDistrictByState = <GetDistrictByState>[];
      json['Get_District_By_State'].forEach((v) {
        getDistrictByState!.add(new GetDistrictByState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getDistrictByState != null) {
      data['Get_District_By_State'] =
          this.getDistrictByState!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDistrictByState {
  String? sTypename;
  String? countryName;
  String? stateName;
  List<String>? district;

  GetDistrictByState(
      {this.sTypename, this.countryName, this.stateName, this.district});

  GetDistrictByState.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    district = json['district'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['district'] = this.district;
    return data;
  }
}
