import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  String? sTypename;
  GetWeatherReport? getWeatherReport;

  WeatherModel({this.sTypename, this.getWeatherReport});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    getWeatherReport = json['Get_Weather_Report'] != null
        ? new GetWeatherReport.fromJson(json['Get_Weather_Report'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.getWeatherReport != null) {
      data['Get_Weather_Report'] = this.getWeatherReport!.toJson();
    }
    return data;
  }
}

class GetWeatherReport {
  String? sTypename;
  Location? location;
  CurrentWeatherData? currentWeatherData;
  Day1? day1;
  Day2? day2;
  Day1? day3;
  Day1? day4;
  Day1? day5;
  Day1? day6;
  Day1? day7;
  Day1? day8;
  Day1? day9;
  Day1? day10;
  String? hijriDate;

  GetWeatherReport(
      {this.sTypename,
        this.location,
        this.currentWeatherData,
        this.day1,
        this.day2,
        this.day3,
        this.day4,
        this.day5,
        this.day6,
        this.day7,
        this.day8,
        this.day9,
        this.day10,
        this.hijriDate});

  GetWeatherReport.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    currentWeatherData = json['current_weather_data'] != null
        ? new CurrentWeatherData.fromJson(json['current_weather_data'])
        : null;
    day1 = json['day_1'] != null ? new Day1.fromJson(json['day_1']) : null;
    day2 = json['day_2'] != null ? new Day2.fromJson(json['day_2']) : null;
    day3 = json['day_3'] != null ? new Day1.fromJson(json['day_3']) : null;
    day4 = json['day_4'] != null ? new Day1.fromJson(json['day_4']) : null;
    day5 = json['day_5'] != null ? new Day1.fromJson(json['day_5']) : null;
    day6 = json['day_6'] != null ? new Day1.fromJson(json['day_6']) : null;
    day7 = json['day_7'] != null ? new Day1.fromJson(json['day_7']) : null;
    day8 = json['day_8'] != null ? new Day1.fromJson(json['day_8']) : null;
    day9 = json['day_9'] != null ? new Day1.fromJson(json['day_9']) : null;
    day10 = json['day_10'] != null ? new Day1.fromJson(json['day_10']) : null;
    hijriDate = json['hijri_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.currentWeatherData != null) {
      data['current_weather_data'] = this.currentWeatherData!.toJson();
    }
    if (this.day1 != null) {
      data['day_1'] = this.day1!.toJson();
    }
    if (this.day2 != null) {
      data['day_2'] = this.day2!.toJson();
    }
    if (this.day3 != null) {
      data['day_3'] = this.day3!.toJson();
    }
    if (this.day4 != null) {
      data['day_4'] = this.day4!.toJson();
    }
    if (this.day5 != null) {
      data['day_5'] = this.day5!.toJson();
    }
    if (this.day6 != null) {
      data['day_6'] = this.day6!.toJson();
    }
    if (this.day7 != null) {
      data['day_7'] = this.day7!.toJson();
    }
    if (this.day8 != null) {
      data['day_8'] = this.day8!.toJson();
    }
    if (this.day9 != null) {
      data['day_9'] = this.day9!.toJson();
    }
    if (this.day10 != null) {
      data['day_10'] = this.day10!.toJson();
    }
    data['hijri_date'] = this.hijriDate;
    return data;
  }
}

class Location {
  String? sTypename;
  String? region;
  String? country;
  String? localtime;

  Location({this.sTypename, this.region, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    region = json['region'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['region'] = this.region;
    data['country'] = this.country;
    data['localtime'] = this.localtime;
    return data;
  }
}

class CurrentWeatherData {
  String? sTypename;
  String? maxtempC;
  String? maxtempF;
  String? mintempC;
  String? mintempF;
  String? maxwindMph;
  String? maxwindKph;
  String? avghumidity;
  String? dailyChanceOfRain;
  Condition? condition;

  CurrentWeatherData(
      {this.sTypename,
        this.maxtempC,
        this.maxtempF,
        this.mintempC,
        this.mintempF,
        this.maxwindMph,
        this.maxwindKph,
        this.avghumidity,
        this.dailyChanceOfRain,
        this.condition});

  CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    maxwindMph = json['maxwind_mph'];
    maxwindKph = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['maxtemp_c'] = this.maxtempC;
    data['maxtemp_f'] = this.maxtempF;
    data['mintemp_c'] = this.mintempC;
    data['mintemp_f'] = this.mintempF;
    data['maxwind_mph'] = this.maxwindMph;
    data['maxwind_kph'] = this.maxwindKph;
    data['avghumidity'] = this.avghumidity;
    data['daily_chance_of_rain'] = this.dailyChanceOfRain;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    return data;
  }
}

class Condition {
  String? sTypename;
  String? text;

  Condition({this.sTypename, this.text});

  Condition.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['text'] = this.text;
    return data;
  }
}

class Day1 {
  String? sTypename;
  String? date;
  String? day;
  String? maxtempC;
  String? maxtempF;
  String? mintempC;
  String? mintempF;
  String? maxwindMph;
  String? maxwindKph;
  String? avghumidity;
  String? dailyChanceOfRain;
  Condition? condition;

  Day1(
      {this.sTypename,
        this.date,
        this.day,
        this.maxtempC,
        this.maxtempF,
        this.mintempC,
        this.mintempF,
        this.maxwindMph,
        this.maxwindKph,
        this.avghumidity,
        this.dailyChanceOfRain,
        this.condition});

  Day1.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    date = json['date'];
    day = json['day'];
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    maxwindMph = json['maxwind_mph'];
    maxwindKph = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['date'] = this.date;
    data['day'] = this.day;
    data['maxtemp_c'] = this.maxtempC;
    data['maxtemp_f'] = this.maxtempF;
    data['mintemp_c'] = this.mintempC;
    data['mintemp_f'] = this.mintempF;
    data['maxwind_mph'] = this.maxwindMph;
    data['maxwind_kph'] = this.maxwindKph;
    data['avghumidity'] = this.avghumidity;
    data['daily_chance_of_rain'] = this.dailyChanceOfRain;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    return data;
  }
}

class Day2 {
  String? sTypename;
  String? day;
  String? maxtempC;
  String? maxtempF;
  String? mintempC;
  String? mintempF;
  String? maxwindMph;
  String? maxwindKph;
  String? avghumidity;
  String? dailyChanceOfRain;
  Condition? condition;

  Day2(
      {this.sTypename,
        this.day,
        this.maxtempC,
        this.maxtempF,
        this.mintempC,
        this.mintempF,
        this.maxwindMph,
        this.maxwindKph,
        this.avghumidity,
        this.dailyChanceOfRain,
        this.condition});

  Day2.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    day = json['day'];
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    maxwindMph = json['maxwind_mph'];
    maxwindKph = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['day'] = this.day;
    data['maxtemp_c'] = this.maxtempC;
    data['maxtemp_f'] = this.maxtempF;
    data['mintemp_c'] = this.mintempC;
    data['mintemp_f'] = this.mintempF;
    data['maxwind_mph'] = this.maxwindMph;
    data['maxwind_kph'] = this.maxwindKph;
    data['avghumidity'] = this.avghumidity;
    data['daily_chance_of_rain'] = this.dailyChanceOfRain;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    return data;
  }
}
