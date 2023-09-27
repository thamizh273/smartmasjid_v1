import 'dart:convert';

import 'package:chatview/chatview.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/model/messgeUpdateModel.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../routes/export.dart';
import '../controllers/messagepage_controller.dart';
import '../model/data.dart';
import '../model/theme.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.firstName, required this.profileImg,})
      : super(key: key);
  final String firstName;
  final String profileImg;





  final MessagepageController chatCtrl = Get.put(MessagepageController());




  @override
  Widget build(BuildContext context) {

    final _chatController = ChatController(
      initialMessageList: chatCtrl.readChatMessageData.value.readChatMessage!
          .message!.asMap().entries.map((entry) {
        var index = entry.key;
        final e = entry.value;
        return Message(
          id: '${index}',
          message: "${e.msg}",
          createdAt:DateTime.parse(
              e.time!.toLocal().toString()),
          sendBy: '${e.type}',
          status: MessageStatus.read,
        );
      }).toList(),


      scrollController: ScrollController(),
      chatUsers: [
        ChatUser(
          id: 'receive_message',
          name: '',
          // profilePhoto: Data.profileImage,
        ),

      ],
    );
    final _currentUser = ChatUser(
      id: 'sent_message',
      name: '${chatCtrl.chatroomData.value.getChatroom!.userId!.firstName}',
      // profilePhoto: Data.profileImage,
    );
    void _showHideTypingIndicator() {
      _chatController.setTypingIndicator = !_chatController.showTypingIndicator;
    }

    return Scaffold(
        body:
        GetX<MessagepageController>(
          init: MessagepageController(),
          initState: (_) {},
          builder: (logic) {
            var subscriptionDocument = gql(
              '''
       subscription MessageAdded {
         messageAdded(
           sender_roomid: "${logic.chatroomData.value.getChatroom!.chatRoomid ??
                  ""}"
           receiver_room_id: "${logic.readChatMessageData.value.readChatMessage!
                  .receiverRoomId}"
         ) {
           message
           receiver_room_id
           sender_roomid
           status
           time
         }
        }

              ''',
            );
            return logic.isLoadingschatmessage.value
                ? loading(context)
                : Container(
              child: Subscription(
                options: SubscriptionOptions(document: subscriptionDocument),
                builder: (result) {
                  if (result.hasException) {
                    print(result.exception);
                    return Container();
                  }
                  // if (result.data!=null &&result.isLoading) {
                  //   // Display progress
                  //   return Center(
                  //     child: const CircularProgressIndicator(),
                  //   );
                  // }
                  if (result.data != null) {
                    final newMessage = result
                        .data!['messageAdded']; // Adjust this to match your GraphQL response structure

                    if (newMessage != null) {
                      // Create a new Message object for the received message
                      final receivedMessage = Message(
                        id: '${newMessage['id']}',
                        message: '${newMessage['message']}',
                        createdAt: DateTime.now(),
                        sendBy: 'receive_message',
                        status: MessageStatus.read, // You may need to adjust this based on your logic
                      );

                      // Add the received message to your chat controller's message list
                      _chatController.addMessage(receivedMessage);
                      chatCtrl.update();
                    }
                  }

                  return ChatView(

                   // loadMoreData: () {
                   //   chatCtrl.limit.value=chatCtrl.limit.value+10;
                   //  return chatCtrl.get_chatMessage(logic.readChatMessageData.value.readChatMessage!.messagingId.toString(),"${logic.readChatMessageData.value.readChatMessage!.receiverName}","x");
                   // },
                    currentUser: _currentUser,
                    chatController: _chatController,
                    onSendTap: (String message,
                        ReplyMessage replyMessage,
                        MessageType messageType,) {
                      final id = chatCtrl.readChatMessageData.value
                          .readChatMessage!.message!.length + 1;
                      chatCtrl.sentmeaasage(message);
                      _chatController.addMessage(
                        Message(
                          id: id.toString(),
                          createdAt: DateTime.now(),
                          message: message,
                          sendBy: "sent_message",
                          replyMessage: replyMessage,
                          messageType: messageType,
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 300), () {
                        _chatController.initialMessageList.last.setStatus =
                            MessageStatus.undelivered;
                      });
                      Future.delayed(const Duration(seconds: 1), () {
                        _chatController.initialMessageList.last.setStatus =
                            MessageStatus.read;
                      });
                    },
                    featureActiveConfig: const FeatureActiveConfig(
                      enableOtherUserProfileAvatar: false,
                      enablePagination: true,
                      lastSeenAgoBuilderVisibility: true,
                      receiptsBuilderVisibility: true,
                    ),
                    chatViewState: ChatViewState.hasMessages,
                    chatViewStateConfig: ChatViewStateConfiguration(
                      loadingWidgetConfig: ChatViewStateWidgetConfiguration(
                          loadingIndicatorColor: Get.theme.primaryColor,
                          reloadButton: Container(
                            height: 30, width: 40, color: Colors.brown,)
                      ),
                      onReloadButtonTap: () {

                      },
                    ),
                    typeIndicatorConfig: TypeIndicatorConfiguration(
                      flashingCircleBrightColor: logic.theme
                          .flashingCircleBrightColor,
                      flashingCircleDarkColor: logic.theme.flashingCircleDarkColor,
                    ),
                    appBar: ChatViewAppBar(

                      leading: Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/back_icon.png',
                              scale: 2,
                            ),
                            onPressed: () {
                              Get.back();

                              chatCtrl.chatroomData.value.getChatroom!
                                  .chat![chatCtrl.indexof.value].unReadCount =
                              0;
                              chatCtrl.update();
                              chatCtrl.get_chatroom();
                            },
                          ),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Container(

                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                child: profileImg == "null"
                                    ? Image.asset("assets/images/app_logo.png")
                                    : Image(
                                    image: MemoryImage(
                                        base64Decode(profileImg)))),
                          ),
                          10.horizontalSpace,
                        ],
                      ),
                      onBackPress: () {
                        Get.back();
                        chatCtrl.chatroomData.value.getChatroom!.chat![chatCtrl
                            .indexof.value].unReadCount = 0;
                        chatCtrl.update();
                        chatCtrl.get_chatroom();
                      },
                      elevation: logic.theme.elevation,
                      backGroundColor: Get.theme.hoverColor,
                      //  profilePicture:widget.profileImg,
                      backArrowColor: Get.theme.primaryColor,
                      chatTitle: "${firstName}",
                      chatTitleTextStyle: TextStyle(
                        color: logic.theme.appBarTitleTextStyle,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.25,
                      ),
                      userStatus: "${chatCtrl.readChatMessageData.value
                          .readChatMessage!.liveStatus == true
                          ? "Online"
                          : "last seen ${chatCtrl.datestatus.value}"}",
                      userStatusTextStyle: const TextStyle(color: Colors.grey),
                      actions: [
                        // IconButton(
                        //   onPressed: ()=>logic.onThemeIconTap(),
                        //   icon: Icon(
                        //     logic.isDarkTheme.value
                        //         ? Icons.brightness_4_outlined
                        //         : Icons.dark_mode_outlined,
                        //     color: logic.theme.themeIconColor,
                        //   ),
                        // ),
                        // IconButton(
                        //   tooltip: 'Toggle TypingIndicator',
                        //
                        //   onPressed: _showHideTypingIndicator,
                        //   icon: Icon(
                        //     Icons.keyboard,
                        //     color: theme.themeIconColor,
                        //   ),
                        // ),
                      ],
                    ),
                    chatBackgroundConfig: ChatBackgroundConfiguration(
                      messageTimeIconColor: logic.theme.messageTimeIconColor,
                      messageTimeTextStyle: TextStyle(
                          color: logic.theme.messageTimeTextColor),
                      defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
                        textStyle: TextStyle(
                          color: logic.theme.chatHeaderColor,
                          fontSize: 17,
                        ),
                      ),
                      backgroundColor: logic.theme.backgroundColor,
                    ),
                    sendMessageConfig: SendMessageConfiguration(
                      enableCameraImagePicker: false,
                      enableGalleryImagePicker: false,
                      allowRecordingVoice: false,
                      imagePickerIconsConfig: ImagePickerIconsConfiguration(
                        cameraIconColor: logic.theme.cameraIconColor,
                        galleryIconColor: logic.theme.galleryIconColor,
                      ),
                      replyMessageColor: logic.theme.replyMessageColor,
                      defaultSendButtonColor: Get.theme.primaryColor,
                      replyDialogColor: logic.theme.replyDialogColor,
                      replyTitleColor: Get.theme.primaryColor,
                      textFieldBackgroundColor: logic.theme.textFieldBackgroundColor,
                      closeIconColor: logic.theme.closeIconColor,
                      textFieldConfig: TextFieldConfiguration(
                        onMessageTyping: (status) {
                          _showHideTypingIndicator();

                          /// Do with status
                          print(status.toString());
                        },
                        compositionThresholdTime: const Duration(seconds: 1),
                        textStyle: TextStyle(color: logic.theme.textFieldTextColor),
                      ),
                      micIconColor: logic.theme.replyMicIconColor,
                      voiceRecordingConfiguration: VoiceRecordingConfiguration(
                        backgroundColor: logic.theme.waveformBackgroundColor,
                        recorderIconColor: logic.theme.recordIconColor,
                        waveStyle: WaveStyle(
                          showMiddleLine: false,
                          waveColor: logic.theme.waveColor ?? Colors.white,
                          extendWaveform: true,
                        ),
                      ),
                    ),
                    chatBubbleConfig: ChatBubbleConfiguration(
                      outgoingChatBubbleConfig: ChatBubble(
                        linkPreviewConfig: LinkPreviewConfiguration(
                          backgroundColor: logic.theme.linkPreviewOutgoingChatColor,
                          bodyStyle: logic.theme.outgoingChatLinkBodyStyle,
                          titleStyle: logic.theme.outgoingChatLinkTitleStyle,
                        ),
                        receiptsWidgetConfig:
                        const ReceiptsWidgetConfig(
                            showReceiptsIn: ShowReceiptsIn.all),
                        color: Get.theme.primaryColor,
                      ),
                      inComingChatBubbleConfig: ChatBubble(
                        linkPreviewConfig: LinkPreviewConfiguration(
                          linkStyle: TextStyle(
                            color: logic.theme.inComingChatBubbleTextColor,
                            decoration: TextDecoration.underline,
                          ),
                          backgroundColor: logic.theme.linkPreviewIncomingChatColor,
                          bodyStyle: logic.theme.incomingChatLinkBodyStyle,
                          titleStyle: logic.theme.incomingChatLinkTitleStyle,
                        ),
                        textStyle: TextStyle(
                            color: logic.theme.inComingChatBubbleTextColor),
                        onMessageRead: (message) {
                          /// send your message reciepts to the other client
                          debugPrint('Message Read');
                        },
                        senderNameTextStyle:
                        TextStyle(color: logic.theme.inComingChatBubbleTextColor),
                        color: logic.theme.inComingChatBubbleColor,
                      ),
                    ),
                    replyPopupConfig: ReplyPopupConfiguration(
                      backgroundColor: logic.theme.replyPopupColor,
                      buttonTextStyle: TextStyle(
                          color: logic.theme.replyPopupButtonColor),
                      topBorderColor: logic.theme.replyPopupTopBorderColor,
                    ),
                    reactionPopupConfig: ReactionPopupConfiguration(
                      shadow: BoxShadow(
                        color: logic.isDarkTheme.value ? Colors.black54 : Colors.grey
                            .shade400,
                        blurRadius: 20,
                      ),
                      backgroundColor: logic.theme.reactionPopupColor,
                    ),
                    messageConfig: MessageConfiguration(
                      messageReactionConfig: MessageReactionConfiguration(
                        backgroundColor: logic.theme.messageReactionBackGroundColor,
                        borderColor: logic.theme.messageReactionBackGroundColor,
                        reactedUserCountTextStyle:
                        TextStyle(color: logic.theme.inComingChatBubbleTextColor),
                        reactionCountTextStyle:
                        TextStyle(color: logic.theme.inComingChatBubbleTextColor),
                        reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
                          backgroundColor: logic.theme.backgroundColor,
                          reactedUserTextStyle: TextStyle(
                            color: logic.theme.inComingChatBubbleTextColor,
                          ),
                          reactionWidgetDecoration: BoxDecoration(
                            color: logic.theme.inComingChatBubbleColor,
                            boxShadow: [
                              BoxShadow(
                                color: logic.isDarkTheme.value ? Colors.black12 : Colors
                                    .grey
                                    .shade200,
                                offset: const Offset(0, 20),
                                blurRadius: 40,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      imageMessageConfig: ImageMessageConfiguration(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        shareIconConfig: ShareIconConfiguration(
                          defaultIconBackgroundColor: logic.theme
                              .shareIconBackgroundColor,
                          defaultIconColor: logic.theme.shareIconColor,
                        ),
                      ),
                    ),
                    // profileCircleConfig: const ProfileCircleConfiguration(g
                    //   profileImageUrl: Data.profileImage,
                    // ),
                    repliedMessageConfig: RepliedMessageConfiguration(
                      backgroundColor: logic.theme.repliedMessageColor,
                      verticalBarColor: logic.theme.verticalBarColor,
                      repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
                        enableHighlightRepliedMsg: true,
                        highlightColor: Colors.pinkAccent.shade100,
                        highlightScale: 1.1,
                      ),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.25,
                      ),
                      replyTitleTextStyle: TextStyle(
                          color: logic.theme.repliedTitleTextColor),
                    ),
                    swipeToReplyConfig: SwipeToReplyConfiguration(
                      replyIconColor: logic.theme.swipeToReplyIconColor,
                    ),
                  );
                },
              ),
            );
          },
        )

    );
  }}


