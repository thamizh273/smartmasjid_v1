import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/controllers/messagepage_controller.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/views/messagepage_view.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../../utils/color_utils.dart';


class ChatPage extends StatelessWidget {

  ChatPage({super.key, required this.username, required this.profileImg});

  final String username;
  final String profileImg;
  final MessagepageController messageCtrl = Get.put(MessagepageController());


  final List<Messages> messagesList = [
    Messages(message: 'Hello', time: '8.30 pm'),
    Messages(message: 'Hii', time: '8.30 pm'),
    Messages(message: 'Hello', time: '8.30 pm'),
    Messages(message: 'Hello', time: '8.30 pm'),
  ];

  final TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(
                    MaterialPageRoute(builder: (_) => MessagepageView()));
              },
              child: SvgPicture.asset(
                "assets/svg/backnew.svg", fit: BoxFit.scaleDown,)),
          title: Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: profileImg == "null"
                      ? Image.asset("assets/images/app_logo.png")
                      : Image(
                      image: MemoryImage(base64Decode(profileImg
                          .toString())))
              ),
              Space(16),
              Flexible(child: Text('${username}')),
            ],
          ),
          titleSpacing: 0,
          // actions: [
          //   IconButton(
          //       onPressed: () {}, icon: Icon(Icons.videocam_rounded)),
          //   IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          //   IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          // ],
        ),
        body: Obx(() {
          return messageCtrl.isLoadingschatmessage.value?loading(context):StickyGroupedListView(
            physics: BouncingScrollPhysics(),
            elements: messageCtrl.readChatMessageData.value.readChatMessage!.message!,
            order: StickyGroupedListOrder.ASC,
            groupBy: (element) =>
                DateTime(element.time!.year,element.time!.month,element.time!.day),
            groupComparator: (DateTime value1, DateTime value2) =>
                value2.compareTo(value1),
            itemComparator: (element1, element2) =>
                (element1.time!).compareTo(element2.time!),
            floatingHeader: true,
            groupSeparatorBuilder: _getGroupSeparator,
            itemBuilder: _getItem,
          );

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(5),
          //             color: Colors.blue.shade100,
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 2,
          //                   spreadRadius: 2,
          //                   color: Colors.black12,
          //                   offset: Offset(0, 1)
          //               )
          //             ]
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.all(2),
          //           child: Text(
          //             '01 january 2023', style: TextStyle(fontSize: 11),),
          //         ),
          //       ),
          //     ),
          //     // Padding(
          //     //   padding: const EdgeInsets.all(16),
          //     //   child: Container(
          //     //     decoration: BoxDecoration(
          //     //         borderRadius: BorderRadius.circular(8),
          //     //         color: Colors.amber.shade200,
          //     //         boxShadow: [
          //     //           BoxShadow(
          //     //               blurRadius: 2,
          //     //               spreadRadius: 2,
          //     //               color: Colors.black12,
          //     //               offset: Offset(0, 2)
          //     //           )
          //     //         ]
          //     //     ),
          //     //     child: Padding(
          //     //       padding: const EdgeInsets.all(8.0),
          //     //       child: Row(
          //     //         mainAxisAlignment: MainAxisAlignment.center,
          //     //         children: [
          //     //           Icon(Icons.lock, size: 15,),
          //     //           Column(
          //     //             children: [
          //     //               Text(
          //     //                 'Messages and calls are end-to-end encrypted.No',
          //     //                 style: TextStyle(fontSize: 12),),
          //     //               Text(
          //     //                 'one outside of this chat,not even WhatsApp,can read',
          //     //                 style: TextStyle(fontSize: 12),),
          //     //               Text('or listen to them.Tap to learn more',
          //     //                 style: TextStyle(fontSize: 12),),
          //     //             ],
          //     //           )
          //     //         ],
          //     //       ),
          //     //     ),
          //     //   ),
          //     // ),
          //     // Spacer(),
          //     Expanded(
          //       flex: 1,
          //       child: ListView.builder(
          //           itemCount: messageCtrl.readChatMessageData.value.readChatMessage!.message!.length,
          //           itemBuilder: (BuildContext context, int index) {
          //
          //             var data=messageCtrl.readChatMessageData.value.readChatMessage!.message![index];
          //             final data1=data.type;
          //             final mainAxisAlignment = data1 == "receive_message"
          //                 ? MainAxisAlignment.start
          //                 : MainAxisAlignment.end;
          //             return Padding(
          //               padding: const EdgeInsets.only(
          //                   top: 8, bottom: 8, right: 16, left: 16),
          //               child: Row(
          //                 mainAxisAlignment:mainAxisAlignment,
          //                 children: [
          //                   Container(
          //                     width: 100,
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(10),
          //                         color: Color(0xff478FA7),
          //                         boxShadow: [
          //                           BoxShadow(
          //                               color: Colors.black12,
          //                               blurRadius: 2,
          //                               spreadRadius: 2,
          //                               offset: Offset(0, 2)
          //                           )
          //                         ]
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: Column(
          //                         children: [
          //                           Padding(
          //                             padding: const EdgeInsets.only(right: 16),
          //                             child: Text("${data.msg}",
          //                               style: TextStyle(fontSize: 12,
          //                                   color: Colors.white),),
          //                           ),
          //                           Row(
          //                             children: [
          //                               Spacer(),
          //                               Text("g",
          //                                 style: TextStyle(fontSize: 11,
          //                                     color: Colors.white),),
          //                               Icon(Icons.done_all, size: 15,
          //                                 color: Colors.white,)
          //                             ],
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           }),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           top: 16, bottom: 16, right: 8, left: 8),
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(30),
          //                 color: Colors.white,
          //               ),
          //               child: TextField(
          //                 controller: input,
          //                 cursorColor: Colors.black,
          //                 decoration: InputDecoration(
          //                   label: Text('Type a message'),
          //                   hintText: 'Type a message',
          //                   border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(30),
          //                   ),
          //                   prefixIcon: IconButton(
          //                     color: Theme
          //                         .of(context)
          //                         .primaryColor,
          //                     onPressed: () {},
          //                     icon: Icon(Icons.emoji_emotions_outlined),),
          //                   suffixIcon: IconButton(
          //                     color: Theme
          //                         .of(context)
          //                         .primaryColor,
          //                     onPressed: () {},
          //                     icon: Icon(Icons.camera_alt_outlined),),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           IconButton(onPressed: () {
          //             //  setState(() {
          //             messagesList.add(Messages(message: input.text,
          //                 time: '12:08 pm'));
          //             // });
          //           }, icon: Icon(Icons.send, color: Theme
          //               .of(context)
          //               .primaryColor,))
          //         ],
          //       ),
          //     )
          //   ],
          // );
        })
    );
  }
}


Widget _getItem(BuildContext ctx, element) {
  var icons=['donate','servicedr','donate','donate',];
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    elevation: 8.0,
    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.0),
    child: SizedBox(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.0),
       // leading:iconss(ctx,element),

        //subtitle: Text('${element.date.hour}:00'),
        subtitle: Stxt(text:  DateFormat.jm().format(
            DateTime.parse(
                "${element.time!.toLocal()}")), size: f2),

        title: Stxt(
            text: '${element.msg}',
            size: f3,
            weight: FontWeight.w500),
        // trailing: Stxt(
        //     text: "-${element.transactionAmount}",
        //     size: f4,
        //     weight: FontWeight.bold,
        //     color: clr_red),
      ),
    ),
  );
}
Widget _getGroupSeparator(element) {
  return SizedBox(
    height: 50,
    child: Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 4),
        width: 120,
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          border: Border.all(
            color: Get.theme.primaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Stxt(
            text:
            '${element.time!.day}/${element.time!.month}/${element.time!.year}',
            size: f2,
            color: clr_white,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

class Messages {
  String message, time;

  Messages({required this.message, required this.time});
}

class Chat {
  String lastMessage, time;
  User user;

  Chat({required this.lastMessage, required this.time, required this.user,});
}

class User {
  String name;
  String? profile;

  User({required this.name, this.profile});
}