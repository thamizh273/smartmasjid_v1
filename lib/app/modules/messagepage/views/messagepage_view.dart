import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/model/chatroomModel.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/views/chatUserList.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/views/chat_page.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/utils/color_utils.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/messagepage_controller.dart';
import 'chattest.dart';

class MessagepageView extends GetView<MessagepageController> {
  MessagepageView({Key? key}) : super(key: key);

// List<Chat> chatList = [
//   Chat(profile: "assets/images/pic.png", lastmessage: "Admin", name: "Masjid-e-nooraniya", time: "2hrs ago"),
//   Chat(profile: "assets/images/pic.png", lastmessage: "Hi", name: "Rahaman", time: "5hrs ago"),
//   Chat(profile: "assets/images/pic.png", lastmessage: "Hello", name: "Aktar", time: "1hrs ago"),
//   Chat(profile: "assets/images/pic.png", lastmessage: "Welcome", name: "Mohamed", time: "7hrs ago"),
// ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: 'messages'.tr,
        action: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(() {
        return controller.isLoadings.value
            ?  DialogHelper.showLoading()
            : controller.chatroomData.value.getChatroom!.chat!.isEmpty
            ? NoMeassage()
            : ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:
            controller.chatroomData.value.getChatroom!.chat!.length,
            itemBuilder: (context, index) {
              var data = controller.chatroomData.value.getChatroom!
                  .chat![index];

              return GestureDetector(
                onTap: () {
                  controller.indexof.value = index;
                  controller.get_chatMessage(data.messagingId!.id,
                      data.messagingId!.firstName.toString(),
                      data.messagingId!.profileImage.toString());
                  // controller.isLoadingschatmessage.isTrue?loading(context): Get.to(ChatScreen( firstName: data.messagingId!.firstName.toString(),));
                  //   Navigator.of(context).push(
                  // MaterialPageRoute(builder: (context) {
                  //   return ChatPage(chat: chat);
                  // }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 4, right: 8, left: 8),
                  child: Container(
                    height: 65.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(-2, 4),
                              color: Get.theme.shadowColor)
                        ]),
                    child: Row(
                      children: [
                        12.horizontalSpace,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Get.theme.hoverColor,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: data.messagingId!.profileImage == "null"
                                  ? Image.asset("assets/images/app_logo.png")
                                  : Image(
                                  image: MemoryImage(base64Decode(data
                                      .messagingId!.profileImage
                                      .toString())))),
                        ),
                        16.horizontalSpace,
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stxt(
                                text: "${data.messagingId!.firstName}",
                                overflow: TextOverflow.ellipsis,
                                size: f4,
                                weight: FontWeight.w600,
                                color: Get.theme.primaryColor,
                              ),
                              4.verticalSpace,
                              Stxt(
                                overflow: TextOverflow.ellipsis,
                                text: "${data.lastMessage}",
                                size: f3,
                                color: clr_gray.shade700,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        // Icon(Icons.message, color: Theme
                        //     .of(context)
                        //     .primaryColor
                        //     .withOpacity(0.5), size: 30,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Space(16),
                            Stxt(
                              text: data.liveStatus == true
                                  ? "Online"
                                  : DateFormat('h:mm a').format(
                                  DateTime.parse(
                                      "${data.lastMessageTime!.toLocal()}")),
                              size: f1,
                              color: data.liveStatus == true
                                  ? clr_green
                                  : Colors.black.withOpacity(0.5),
                            ),
                            Space(8),
                            data.unReadCount == 0
                                ? SizedBox()
                                : Container(
                              clipBehavior: Clip.antiAlias,
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(30),
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              ),
                              child: Center(
                                  child: Text(
                                    "${data.unReadCount}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                        Space(20),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () {
          controller.get_chatUserList();
          Get.to(ChatUserListPage());
        },
      ),
    );
  }
}

class NoMeassage extends StatelessWidget {
  const NoMeassage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/messages.svg"),
          Space(16),
          Text("No messages yet, start your conversation".tr),
          // Text("Start your Conversation".tr)
        ],
      ),
    );
  }
}


//
// class Chat{
//   String lastMessage, time;
//   User user;
//   Chat({required this.lastMessage,required this.time, required this.user});
// }
