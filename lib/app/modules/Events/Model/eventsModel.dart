// To parse this JSON data, do
//
//     final eventsModel = eventsModelFromJson(jsonString);

import 'dart:convert';

EventsModel eventsModelFromJson(String str) => EventsModel.fromJson(json.decode(str));

String eventsModelToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  String? typename;
  List<GetMasjidEvents>? getMasjidEvents;

  EventsModel({
    this.typename,
    this.getMasjidEvents,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
    typename: json["__typename"],
    getMasjidEvents: json["Get_Masjid_Events_"] == null ? [] : List<GetMasjidEvents>.from(json["Get_Masjid_Events_"]!.map((x) => GetMasjidEvents.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "Get_Masjid_Events_": getMasjidEvents == null ? [] : List<dynamic>.from(getMasjidEvents!.map((x) => x.toJson())),
  };
}

class GetMasjidEvents {
  String? typename;
  String? image;
  String? id;
  String? area;
  DateTime? startTime;
  DateTime? endTime;
  MasjidId? masjidId;
  String? title;
  String? description;

  GetMasjidEvents({
    this.typename,
    this.image,
    this.id,
    this.area,
    this.startTime,
    this.endTime,
    this.masjidId,
    this.title,
    this.description,
  });

  factory GetMasjidEvents.fromJson(Map<String, dynamic> json) => GetMasjidEvents(
    typename: json["__typename"],
    image: json["image"],
    id: json["id"],
    area: json["area"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    masjidId: json["masjid_id"] == null ? null : MasjidId.fromJson(json["masjid_id"]),
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "image": image,
    "id": id,
    "area": area,
    "start_time": startTime?.toIso8601String(),
    "end_time": endTime?.toIso8601String(),
    "masjid_id": masjidId?.toJson(),
    "title": title,
    "description": description,
  };
}

class MasjidId {
  String? typename;
  String? masjidName;

  MasjidId({
    this.typename,
    this.masjidName,
  });

  factory MasjidId.fromJson(Map<String, dynamic> json) => MasjidId(
    typename: json["__typename"],
    masjidName: json["masjid_name"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename,
    "masjid_name": masjidName,
  };
}
