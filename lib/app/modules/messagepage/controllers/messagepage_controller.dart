import 'dart:convert';
import 'dart:developer';


import 'package:chatview/chatview.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../../../server/config.dart';
import '../../home/controllers/home_controller.dart';
import '../model/chatUserListModel.dart';
import '../model/chatroomModel.dart';
import '../model/read_Chat_Message_Model.dart';
import '../views/chattest.dart';

class MessagepageController extends GetxController {
  //TODO: Implement MessagepageController

var userNames="".obs;
var int=0.obs;

  RxInt indexof=0.obs;
  var isLoadings = false.obs;
  var isLoadingschatUserList = false.obs;
  var isLoadingschatmessage = false.obs;
  var isLoadingssendmsg = false.obs;
  final TextEditingController input = TextEditingController();
  final _restCallController = Get.put(restCallController());
  final _homeController= Get.find<HomeController>();
  var chatroomData=ChatroomModel().obs;
  var chatListUserData=ChatUserListModel().obs;
  var readChatMessageData=ReadChatMessageModel().obs;
  @override
  void onInit() {
    get_chatroom();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  get_chatroom() async {
   // print("eeee ${_homeController.getUserData.value.getUserById!.masjidId!.id}");
    //masjidListdata.value.getMasjidFilter=null;
    isLoadings.value = true;
    var header = """
query Get_Chatroom(\$userId: ID!) {
  Get_Chatroom(user_id: \$userId) {
    chat_roomid
    id
    last_seen
    live_status
    notification_count
    user_id {
      id
      first_name
    }
    chat {
      id
      last_message
      last_message_time
      live_status
      un_read_count
      messaging_id {
        id
        first_name
        profile_image
      }
    }
  }
}
    """;
    var body = {
      "userId": "${_homeController.getUserData.value.getUserById!.id}"
    };
    var res = await _restCallController.gql_query(header, body);
    // log("getchat");
    //
    // log(json.encode(res));
    // log("getchat");
    isLoadings.value = false;
    chatroomData.value = chatroomModelFromJson(json.encode(res));
    update();
  }
  get_chatUserList() async {
   // print("eeee ${_homeController.getUserData.value.getUserById!.masjidId!.id}");
    //masjidListdata.value.getMasjidFilter=null;
    isLoadingschatUserList.value = true;
    var header = """
query Get_Chat_User_List(\$userId: ID!, \$searchBy: String) {
  Get_Chat_User_List(user_id: \$userId, search_by: \$searchBy) {
    post_
    user_id {
      id
    }
    user_name
    user_type
    profile_image
  }
}
    """;
    var body = {
      "userId": "${_homeController.getUserData.value.getUserById!.id}",
      "searchBy": ""
    };
    var res = await _restCallController.gql_query(header, body);
    // log("getchatUser");
    // log(json.encode(res));
    // log("getchatUser");
    isLoadingschatUserList.value = false;
    chatListUserData.value = chatUserListModelFromJson(json.encode(res));
   // update();
  }
  get_chatMessage(String? reciverID, String? firstName) async {
    print("rr1${_homeController.getUserData.value.getUserById!.id}");
    print("rr2${chatroomData.value.getChatroom!.chatRoomid}");
    print("rr3${reciverID}");
    print("rr4${chatroomData.value.getChatroom!.id}");
    print("rrrrrrrrrrr");
    isLoadingschatmessage.value = true;
    var header = """
query Read_Chat_Message(\$userId: ID!, \$chatRoomid: String!, \$messagingId: String!, \$id: ID, \$limit: Float) {
  Read_Chat_Message(user_id: \$userId, chat_roomid: \$chatRoomid, messaging_id: \$messagingId, _id: \$id, limit: \$limit) {
    message {
      message
      type
      time
    }
    chat_roomid
    receiver_room_id
    user_id
    id
    messaging_id
  }
}
    """;
    var body = {  "userId": "${_homeController.getUserData.value.getUserById!.id}",
      "chatRoomid": "${chatroomData.value.getChatroom!.chatRoomid}",
      "messagingId": "${reciverID}",
      "id": "${chatroomData.value.getChatroom!.id}",
      "limit": 15
    };
    var res = await _restCallController.gql_query(header, body);
    log("getmessage");
    log(json.encode(res));
    log("getmessage");
    isLoadingschatmessage.value = false;
    readChatMessageData.value = readChatMessageModelFromJson(json.encode(res));
    Get.to(ChatScreen( firstName: "$firstName"));
    update();
  }

final messages = RxList<String>();
void addMessage(String message) {
  messages.add(message);
}

sentmeaasage(String msg,) async {
  isLoadingssendmsg.value=true;
  var header =
  """mutation Sent_Chat_Message(\$userId: ID!, \$receiverId: ID!, \$id: ID!, \$senderRoomid: String!, \$receiverRoomId: String!, \$message: String!) {
  Sent_Chat_Message(user_id: \$userId, receiver_id: \$receiverId, id_: \$id, sender_roomid: \$senderRoomid, receiver_room_id: \$receiverRoomId, message: \$message) {
    message
    time
  }
}""";
  var body = {  "userId": "${_homeController.getUserData.value.getUserById!.id}",
    "receiverId": "${readChatMessageData.value.readChatMessage!.messagingId}",
    "id": "${chatroomData.value.getChatroom!.id}",
    "senderRoomid": "${chatroomData.value.getChatroom!.chatRoomid}",
    "receiverRoomId": "${readChatMessageData.value.readChatMessage!.receiverRoomId}",
    "message": "${msg}"
  };
  var res = await _restCallController.gql_mutation(header, body);
  print(json.encode(res));
  isLoadingssendmsg.value=false;

  // if (res.toString().contains("SUCCESS")) {
  //
  //   getMembershipDetails();
  //   payforOthers.value==true? Get.close(3):    Get.close(2);
  //   //Get.offAndToNamed(Routes.HOME);
  //
  //   // var hh = res["SUCCESS"]["Update_User"];
  //   toast(error: "SUCCESS", msg: "${status}");
  // }

  return res;
}



}

