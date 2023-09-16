import 'dart:convert';
import 'dart:developer';


import '../../../rest_call_controller/rest_call_controller.dart';
import '../../../routes/export.dart';
import '../../home/controllers/home_controller.dart';
import '../model/chatUserListModel.dart';
import '../model/chatroomModel.dart';

class MessagepageController extends GetxController {
  //TODO: Implement MessagepageController


  var isLoadings = false.obs;
  var isLoadingschatUserList = false.obs;
  final TextEditingController input = TextEditingController();
  final _restCallController = Get.put(restCallController());
  final _homeController= Get.find<HomeController>();
  var chatroomData=ChatroomModel().obs;
  var chatListUserData=ChatUserListModel().obs;
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
    log("getchat");

    log(json.encode(res));
    log("getchat");
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
    log("getchatUser");
    log(json.encode(res));
    log("getchatUser");
    isLoadingschatUserList.value = false;
    chatListUserData.value = chatUserListModelFromJson(json.encode(res));
   // update();
  }
}
