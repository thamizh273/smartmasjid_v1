// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  String? typename;
  GetWeatherReportFutureDate? getWeatherReportFutureDate;

  WeatherModel({
    this.typename,
    this.getWeatherReportFutureDate,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    typename: json["__typename"],
    getWeatherReportFutureDate: json["Get_Weather_Report_Future_Date"] == null ? null : GetWeatherReportFutureDate.fromJson(json["Get_Weather_Report_Future_Date"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Weather_Report_Future_Date": getWeatherReportFutureDate?.toJson(),
  };
}

class GetWeatherReportFutureDate {
  String? typename;
  Day? day1;
  Day? day2;
  Day? day4;
  Day? day5;
  Day? day6;
  String? hijriDate;
  Today? today;
  Day? day3;

  GetWeatherReportFutureDate({
    this.typename,
    this.day1,
    this.day2,
    this.day4,
    this.day5,
    this.day6,
    this.hijriDate,
    this.today,
    this.day3,
  });

  factory GetWeatherReportFutureDate.fromJson(Map<String, dynamic> json) => GetWeatherReportFutureDate(
    typename: json["__typename"],
    day1: json["day_1"] == null ? null : Day.fromJson(json["day_1"]),
    day2: json["day_2"] == null ? null : Day.fromJson(json["day_2"]),
    day4: json["day_4"] == null ? null : Day.fromJson(json["day_4"]),
    day5: json["day_5"] == null ? null : Day.fromJson(json["day_5"]),
    day6: json["day_6"] == null ? null : Day.fromJson(json["day_6"]),
    hijriDate: json["hijri_date"],
    today: json["today_"] == null ? null : Today.fromJson(json["today_"]),
    day3: json["day_3"] == null ? null : Day.fromJson(json["day_3"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "day_1": day1?.toJson(),
    "day_2": day2?.toJson(),
    "day_4": day4?.toJson(),
    "day_5": day5?.toJson(),
    "day_6": day6?.toJson(),
    "hijri_date": hijriDate,
    "today_": today?.toJson(),
    "day_3": day3?.toJson(),
  };
}

class Day {
  String? typename;
  DateTime? date;
  String? day;
  String? dailyChanceOfRain;
  String? maxtempC;
  Condition? condition;
  String? avghumidity;
  String? maxwindKph;

  Day({
    this.typename,
    this.date,
    this.day,
    this.dailyChanceOfRain,
    this.maxtempC,
    this.condition,
    this.avghumidity,
    this.maxwindKph,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    typename: json["__typename"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    maxtempC: json["maxtemp_c"],
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    avghumidity: json["avghumidity"],
    maxwindKph: json["maxwind_kph"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day,
    "daily_chance_of_rain": dailyChanceOfRain,
    "maxtemp_c": maxtempC,
    "condition": condition?.toJson(),
    "avghumidity": avghumidity,
    "maxwind_kph": maxwindKph,
  };
}

class Condition {
  String? typename;
  String? text;
  String? icon;

  Condition({
    this.typename,
    this.text,
    this.icon,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    typename: json["__typename"],
    text: json["text"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "text": text,
    "icon": icon,
  };
}

class Today {
  String? typename;
  String? date;
  String? day;
  String? humidity;
  String? tempC;
  Condition? condition;
  String? windDir;
  String? windKph;

  Today({
    this.typename,
    this.date,
    this.day,
    this.humidity,
    this.tempC,
    this.condition,
    this.windDir,
    this.windKph,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    typename: json["__typename"],
    date: json["date"],
    day: json["day"],
    humidity: json["humidity"],
    tempC: json["temp_c"],
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    windDir: json["wind_dir"],
    windKph: json["wind_kph"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "date": date,
    "day": day,
    "humidity": humidity,
    "temp_c": tempC,
    "condition": condition?.toJson(),
    "wind_dir": windDir,
    "wind_kph": windKph,
  };
} 
