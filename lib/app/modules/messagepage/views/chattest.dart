import 'dart:convert';

import 'package:chatview/chatview.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/model/messgeUpdateModel.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../routes/export.dart';
import '../controllers/messagepage_controller.dart';
import '../model/data.dart';
import '../model/theme.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.firstName,}) : super(key: key);
  final String firstName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  AppTheme theme = LightTheme();
  bool isDarkTheme = false;

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
          createdAt: DateTime.now(),
          sendBy: '${e.type}',
          status: MessageStatus.delivered,
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
           sender_roomid: "${logic.chatroomData.value.getChatroom!.chatRoomid??""}"
           receiver_room_id: "${logic.readChatMessageData.value.readChatMessage!.receiverRoomId}"
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
            return logic.isLoadingschatmessage.value?loading(context): Container(
              child: Subscription(
                options: SubscriptionOptions(document: subscriptionDocument ),
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
                    final newMessage = result.data!['messageAdded']; // Adjust this to match your GraphQL response structure

                    if (newMessage != null) {
                      // Create a new Message object for the received message
                      final receivedMessage = Message(
                        id: '${newMessage['id']}',
                        message: '${newMessage['message']}',
                        createdAt: DateTime.now(),
                        sendBy: 'receive_message',
                        status: MessageStatus.delivered, // You may need to adjust this based on your logic
                      );

                      // Add the received message to your chat controller's message list
                      _chatController.addMessage(receivedMessage);
                      chatCtrl.update();
                    }
                  }

                  return ChatView(

                   loadMoreData: () {
                    return chatCtrl.get_chatMessage(logic.readChatMessageData.value.readChatMessage!.messagingId.toString(),"dfghjk") ;
                   },
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
                          enablePagination: true,
                          lastSeenAgoBuilderVisibility: true,
                          receiptsBuilderVisibility: true,
                        ),
                        chatViewState: ChatViewState.hasMessages,
                        chatViewStateConfig: ChatViewStateConfiguration(
                          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
                            loadingIndicatorColor: Get.theme.primaryColor,
                            reloadButton:Container(height: 30,width: 40,color: Colors.brown,)
                          ),
                          onReloadButtonTap: () {

                          },
                        ),
                        typeIndicatorConfig: TypeIndicatorConfiguration(
                          flashingCircleBrightColor: theme.flashingCircleBrightColor,
                          flashingCircleDarkColor: theme.flashingCircleDarkColor,
                        ),
                        appBar: ChatViewAppBar(
                          onBackPress: (){
                            Get.back();
                            chatCtrl.chatroomData.value.getChatroom!.chat![chatCtrl.indexof.value].unReadCount=0;
                            chatCtrl.update();
                            chatCtrl.get_chatroom();
                          },
                          elevation: theme.elevation,
                          backGroundColor: theme.appBarColor,
                          profilePicture: Data.profileImage,
                          backArrowColor: Get.theme.primaryColor,
                          chatTitle: "${widget.firstName}",
                          chatTitleTextStyle: TextStyle(
                            color: theme.appBarTitleTextStyle,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 0.25,
                          ),
                          userStatus: "online",
                          userStatusTextStyle: const TextStyle(color: Colors.grey),
                          actions: [
                            IconButton(
                              onPressed: _onThemeIconTap,
                              icon: Icon(
                                isDarkTheme
                                    ? Icons.brightness_4_outlined
                                    : Icons.dark_mode_outlined,
                                color: theme.themeIconColor,
                              ),
                            ),
                            IconButton(
                              tooltip: 'Toggle TypingIndicator',

                              onPressed: _showHideTypingIndicator,
                              icon: Icon(
                                Icons.keyboard,
                                color: theme.themeIconColor,
                              ),
                            ),
                          ],
                        ),
                        chatBackgroundConfig: ChatBackgroundConfiguration(
                          messageTimeIconColor: theme.messageTimeIconColor,
                          messageTimeTextStyle: TextStyle(
                              color: theme.messageTimeTextColor),
                          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
                            textStyle: TextStyle(
                              color: theme.chatHeaderColor,
                              fontSize: 17,
                            ),
                          ),
                          backgroundColor: theme.backgroundColor,
                        ),
                        sendMessageConfig: SendMessageConfiguration(
                          imagePickerIconsConfig: ImagePickerIconsConfiguration(
                            cameraIconColor: theme.cameraIconColor,
                            galleryIconColor: theme.galleryIconColor,
                          ),
                          replyMessageColor: theme.replyMessageColor,
                          defaultSendButtonColor: Get.theme.primaryColor,
                          replyDialogColor: theme.replyDialogColor,
                          replyTitleColor: Get.theme.primaryColor,
                          textFieldBackgroundColor: theme.textFieldBackgroundColor,
                          closeIconColor: theme.closeIconColor,
                          textFieldConfig: TextFieldConfiguration(
                            onMessageTyping: (status) {
                              /// Do with status
                              debugPrint(status.toString());
                            },
                            compositionThresholdTime: const Duration(seconds: 1),
                            textStyle: TextStyle(color: theme.textFieldTextColor),
                          ),
                          micIconColor: theme.replyMicIconColor,
                          voiceRecordingConfiguration: VoiceRecordingConfiguration(
                            backgroundColor: theme.waveformBackgroundColor,
                            recorderIconColor: theme.recordIconColor,
                            waveStyle: WaveStyle(
                              showMiddleLine: false,
                              waveColor: theme.waveColor ?? Colors.white,
                              extendWaveform: true,
                            ),
                          ),
                        ),
                        chatBubbleConfig: ChatBubbleConfiguration(
                          outgoingChatBubbleConfig: ChatBubble(
                            linkPreviewConfig: LinkPreviewConfiguration(
                              backgroundColor: theme.linkPreviewOutgoingChatColor,
                              bodyStyle: theme.outgoingChatLinkBodyStyle,
                              titleStyle: theme.outgoingChatLinkTitleStyle,
                            ),
                            receiptsWidgetConfig:
                            const ReceiptsWidgetConfig(
                                showReceiptsIn: ShowReceiptsIn.all),
                            color: Get.theme.primaryColor,
                          ),
                          inComingChatBubbleConfig: ChatBubble(
                            linkPreviewConfig: LinkPreviewConfiguration(
                              linkStyle: TextStyle(
                                color: theme.inComingChatBubbleTextColor,
                                decoration: TextDecoration.underline,
                              ),
                              backgroundColor: theme.linkPreviewIncomingChatColor,
                              bodyStyle: theme.incomingChatLinkBodyStyle,
                              titleStyle: theme.incomingChatLinkTitleStyle,
                            ),
                            textStyle: TextStyle(
                                color: theme.inComingChatBubbleTextColor),
                            onMessageRead: (message) {
                              /// send your message reciepts to the other client
                              debugPrint('Message Read');
                            },
                            senderNameTextStyle:
                            TextStyle(color: theme.inComingChatBubbleTextColor),
                            color: theme.inComingChatBubbleColor,
                          ),
                        ),
                        replyPopupConfig: ReplyPopupConfiguration(
                          backgroundColor: theme.replyPopupColor,
                          buttonTextStyle: TextStyle(
                              color: theme.replyPopupButtonColor),
                          topBorderColor: theme.replyPopupTopBorderColor,
                        ),
                        reactionPopupConfig: ReactionPopupConfiguration(
                          shadow: BoxShadow(
                            color: isDarkTheme ? Colors.black54 : Colors.grey
                                .shade400,
                            blurRadius: 20,
                          ),
                          backgroundColor: theme.reactionPopupColor,
                        ),
                        messageConfig: MessageConfiguration(
                          messageReactionConfig: MessageReactionConfiguration(
                            backgroundColor: theme.messageReactionBackGroundColor,
                            borderColor: theme.messageReactionBackGroundColor,
                            reactedUserCountTextStyle:
                            TextStyle(color: theme.inComingChatBubbleTextColor),
                            reactionCountTextStyle:
                            TextStyle(color: theme.inComingChatBubbleTextColor),
                            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
                              backgroundColor: theme.backgroundColor,
                              reactedUserTextStyle: TextStyle(
                                color: theme.inComingChatBubbleTextColor,
                              ),
                              reactionWidgetDecoration: BoxDecoration(
                                color: theme.inComingChatBubbleColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: isDarkTheme ? Colors.black12 : Colors.grey
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
                              defaultIconBackgroundColor: theme
                                  .shareIconBackgroundColor,
                              defaultIconColor: theme.shareIconColor,
                            ),
                          ),
                        ),
                        profileCircleConfig: const ProfileCircleConfiguration(
                          profileImageUrl: Data.profileImage,
                        ),
                        repliedMessageConfig: RepliedMessageConfiguration(
                          backgroundColor: theme.repliedMessageColor,
                          verticalBarColor: theme.verticalBarColor,
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
                              color: theme.repliedTitleTextColor),
                        ),
                        swipeToReplyConfig: SwipeToReplyConfiguration(
                          replyIconColor: theme.swipeToReplyIconColor,
                        ),
                      );

                },
              ),
            );
          },
        )

    );
  }


  void _onThemeIconTap() {
    setState(() {
      if (isDarkTheme) {
        theme = LightTheme();
        isDarkTheme = false;
      } else {
        theme = DarkTheme();
        isDarkTheme = true;
      }
    });
  }
}