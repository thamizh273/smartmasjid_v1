import 'dart:convert';

PrayerPageModel prayerPageModelFromJson(String str) => PrayerPageModel.fromJson(json.decode(str));

String prayerPageModelToJson(PrayerPageModel data) => json.encode(data.toJson());



class PrayerPageModel {
  String? sTypename;
  List<GetMasjidPrayerTimeFilter>? getMasjidPrayerTimeFilter;

  PrayerPageModel({this.sTypename, this.getMasjidPrayerTimeFilter});

  PrayerPageModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['Get_Masjid_Prayer_Time_Filter'] != null) {
      getMasjidPrayerTimeFilter = <GetMasjidPrayerTimeFilter>[];
      json['Get_Masjid_Prayer_Time_Filter'].forEach((v) {
        getMasjidPrayerTimeFilter!
            .add(new GetMasjidPrayerTimeFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getMasjidPrayerTimeFilter != null) {
      data['Get_Masjid_Prayer_Time_Filter'] =
          this.getMasjidPrayerTimeFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetMasjidPrayerTimeFilter {
  String? sTypename;
  String? id;
  String? startTime;
  String? endTime;
  String? prayerName;
  bool? notification;
  String? prayerStatus;

  GetMasjidPrayerTimeFilter(
      {this.sTypename,
        this.id,
        this.startTime,
        this.endTime,
        this.prayerName,
        this.notification,
        this.prayerStatus});

  GetMasjidPrayerTimeFilter.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    prayerName = json['prayer_name'];
    notification = json['notification'];
    prayerStatus = json['prayer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['prayer_name'] = this.prayerName;
    data['notification'] = this.notification;
    data['prayer_status'] = this.prayerStatus;
    return data;
  }
}
