import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/controllers/messagepage_controller.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/views/messagepage_view.dart';
import 'package:smartmasjid_v1/app/modules/quranpage/views/qurandetails.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';


class ChatPage extends StatefulWidget {
  final Chat chat;
   ChatPage({super.key, required this.chat });
   final MessagepageController c = Get.put(MessagepageController());


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Messages> messagesList = [
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
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop(MaterialPageRoute(builder: (_) => MessagepageView()));
            },
              child: SvgPicture.asset("assets/svg/backnew.svg", fit: BoxFit.scaleDown,)),
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  widget.chat.user.profile!,
                  fit: BoxFit.fitHeight,
                  width: 40,
                  height: 40,
                ),
              ),
              Space(16),
              Flexible(child: Text(widget.chat.user.name)),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.shade100,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.black12,
                          offset: Offset(0, 1)
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    '01 january 2023', style: TextStyle(fontSize: 11),),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         color: Colors.amber.shade200,
            //         boxShadow: [
            //           BoxShadow(
            //               blurRadius: 2,
            //               spreadRadius: 2,
            //               color: Colors.black12,
            //               offset: Offset(0, 2)
            //           )
            //         ]
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(Icons.lock, size: 15,),
            //           Column(
            //             children: [
            //               Text(
            //                 'Messages and calls are end-to-end encrypted.No',
            //                 style: TextStyle(fontSize: 12),),
            //               Text(
            //                 'one outside of this chat,not even WhatsApp,can read',
            //                 style: TextStyle(fontSize: 12),),
            //               Text('or listen to them.Tap to learn more',
            //                 style: TextStyle(fontSize: 12),),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Spacer(),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: messagesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Messages messages = messagesList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff478FA7),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: Offset(0, 2)
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Text(messages.message,
                                      style: TextStyle(fontSize: 12, color: Colors.white),),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(messages.time,
                                        style: TextStyle(fontSize: 11, color: Colors.white),),
                                      Icon(Icons.done_all, size: 15, color: Colors.white,)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 8, left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: input,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: Text('Type a message'),hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: IconButton(
                            color: Theme.of(context).primaryColor, onPressed: () {  }, icon: Icon(Icons.emoji_emotions_outlined),),
                          suffixIcon: IconButton(
                            color:  Theme.of(context).primaryColor, onPressed: () {  }, icon: Icon(Icons.camera_alt_outlined),),
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {
                    setState(() {
                      messagesList.add(Messages(message: input.text, time: '12:08 pm'));
                    });
                  }, icon: Icon(Icons.send, color:  Theme.of(context).primaryColor,))
                ],
              ),
            )
          ],
        )
    );
  }
}


class Messages{
  String message, time;
  Messages({required this.message, required this.time});
}

class Chat{
  String lastMessage, time;
  User user;
  Chat({required this.lastMessage,required this.time,required this.user,});
}

class User {
  String name;
  String? profile;

  User({required this.name, this.profile});
}