// To parse this JSON data, do
//
//     final guestPrayerModel = guestPrayerModelFromJson(jsonString);

import 'dart:convert';

GuestPrayerModel guestPrayerModelFromJson(String str) => GuestPrayerModel.fromJson(json.decode(str));

String guestPrayerModelToJson(GuestPrayerModel data) => json.encode(data.toJson());

class GuestPrayerModel {
  String? typename;
  GetPrayerTimeGuest? getPrayerTimeGuest;

  GuestPrayerModel({
    this.typename,
    this.getPrayerTimeGuest,
  });

  factory GuestPrayerModel.fromJson(Map<String, dynamic> json) => GuestPrayerModel(
    typename: json["__typename"],
    getPrayerTimeGuest: json["Get_Prayer_Time_guest"] == null ? null : GetPrayerTimeGuest.fromJson(json["Get_Prayer_Time_guest"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Prayer_Time_guest": getPrayerTimeGuest?.toJson(),
  };
}

class GetPrayerTimeGuest {
  String? typename;
  Prayer? prayer;
  String? city;
  String? currentDate;
  String? todayHijriDate;

  GetPrayerTimeGuest({
    this.typename,
    this.prayer,
    this.city,
    this.currentDate,
    this.todayHijriDate,
  });

  factory GetPrayerTimeGuest.fromJson(Map<String, dynamic> json) => GetPrayerTimeGuest(
    typename: json["__typename"],
    prayer: json["prayer"] == null ? null : Prayer.fromJson(json["prayer"]),
    city: json["city"],
    currentDate: json["current_date"],
    todayHijriDate: json["today_hijri_date"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "prayer": prayer?.toJson(),
    "city": city,
    "current_date": currentDate,
    "today_hijri_date": todayHijriDate,
  };
}

class Prayer {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  Prayer({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) =>
      Prayer(
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        imsak: json["Imsak"],
        midnight: json["Midnight"],
        firstthird: json["Firstthird"],
        lastthird: json["Lastthird"],
      );

  Map<String, dynamic> toJson() =>
      {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsak,
        "Midnight": midnight,
        "Firstthird": firstthird,
        "Lastthird": lastthird,
      };
}