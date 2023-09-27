


import 'dart:convert';

MessageUpdateModel messageUpdateModelFromJson(String str) => MessageUpdateModel.fromJson(json.decode(str));

class MessageUpdateModel {
  String? sTypename;
  String? message;
  String? receiverRoomId;
  String? senderRoomid;
  String? status;
  String? time;

  MessageUpdateModel(
      {this.sTypename,
        this.message,
        this.receiverRoomId,
        this.senderRoomid,
        this.status,
        this.time});

  MessageUpdateModel.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    message = json['message'];
    receiverRoomId = json['receiver_room_id'];
    senderRoomid = json['sender_roomid'];
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['message'] = this.message;
    data['receiver_room_id'] = this.receiverRoomId;
    data['sender_roomid'] = this.senderRoomid;
    data['status'] = this.status;
    data['time'] = this.time;
    return data;
  }
}
