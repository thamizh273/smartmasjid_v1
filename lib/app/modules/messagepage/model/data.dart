import 'package:chatview/chatview.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/controllers/messagepage_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

class Data {
  final MessagepageController chatCtrls = Get.put(MessagepageController());
  static const profileImage =
      "https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_showcaseview/master/example/assets/simform.png";
  late final List<Message> messageList;

  Data() {
    messageList = _buildMessageList();
  }

  List<Message> _buildMessageList() {
    return chatCtrls.readChatMessageData.value.readChatMessage!.message!.asMap().entries.map((entry) {
      var index = entry.key;
      final e = entry.value;
      return Message(
        id: '${index}',
        message: "${e.msg}",
        createdAt: DateTime.now(),
        sendBy: '${e.type}',
        status: MessageStatus.read,
      );
    }).toList();
  }
}


