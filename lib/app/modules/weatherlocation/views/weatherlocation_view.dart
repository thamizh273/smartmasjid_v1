import 'package:flutter/material.dart';

class WeatherLocation  {
  final String city;
  final String dateTime;
  final String temperature;
  final String WeatherType;
  final String iconUrl;
  final int wind;
  final int rain;
  final int humidity;

  WeatherLocation({
    required this.city,
    required this.dateTime,
    required this.temperature,
    required this.WeatherType,
    required this.iconUrl,
    required this.wind,
    required this.rain,
    required this.humidity,
  });
}

final locationList = [
  WeatherLocation(city: "Kolkata",
      dateTime: "07.50 PM - Dhuʻl-Qiʻdah, 22 Mar 2023",
      temperature: "24\u2103",
      WeatherType: "Night",
      iconUrl: "assets/svg/moon.svg",
      wind: 10,
      rain: 2,
      humidity: 10),
  WeatherLocation(city: "London",
      dateTime: "07.50 PM - Dhuʻl-Qiʻdah, 22 Mar 2023",
      temperature: "18\u2103",
      WeatherType: "Cloudy",
      iconUrl: "assets/svg/cloud.svg",
      wind: 20,
      rain: 2,
      humidity: 30),
  WeatherLocation(city: "New York",
      dateTime: "07.50 PM - Dhuʻl-Qiʻdah, 22 Mar 2023",
      temperature: "32\u2103",
      WeatherType: "Rainy",
      iconUrl: "assets/svg/rainy-day.svg",
      wind: 10,
      rain: 2,
      humidity: 16),

];

