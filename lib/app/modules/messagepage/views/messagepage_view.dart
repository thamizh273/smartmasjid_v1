import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/views/chat_page.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../widgets/space.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/messagepage_controller.dart';


class MessagepageView extends GetView<MessagepageController> {
   MessagepageView({Key? key}) : super(key: key);
  MessagepageController c = Get.put(MessagepageController());

// List<Chat> chatList = [
//   Chat(profile: "assets/images/pic.png", lastmessage: "Admin", name: "Masjid-e-nooraniya", time: "2hrs ago"),
//   Chat(profile: "assets/images/pic.png", lastmessage: "Hi", name: "Rahaman", time: "5hrs ago"),
//   Chat(profile: "assets/images/pic.png", lastmessage: "Hello", name: "Aktar", time: "1hrs ago"),
//   Chat(profile: "assets/images/pic.png", lastmessage: "Welcome", name: "Mohamed", time: "7hrs ago"),
// ];


  @override
  Widget build(BuildContext context) {
    List<Chat> chatList = [
      Chat(
          lastMessage: 'Hello',
          time: '2 hrs ago',
          user: User(
              name: 'Masjid-e-nooraniya',
              profile: 'assets/images/pic.png')),
      Chat(
          lastMessage: 'Hi',
          time: '2 hrs ago',
          user: User(
              name: 'Mohamed',
              profile: 'assets/images/pic.png')),
      Chat(
          lastMessage: 'Hello!',
          time: '2 hrs ago',
          user: User(
              name: 'Rahaman',
              profile: 'assets/images/pic.png'))
    ];


    return Scaffold(
      appBar: CustomAppbar(tittle: 'Messages'.tr,
        action: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.refresh, color: Colors.white,))
        ],
      ),

      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          Chat chat = chatList[index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ChatPage(chat: chat);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8, right: 16, left: 16),
              child: Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(-2, 4),
                          color: Colors.grey.shade400
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Space(16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset("${chat.user.profile}", width: 60,),
                    ),
                    Space(16),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stxt(text: "${chat.user.name}",
                            size: f4,
                            weight: FontWeight.w600,),
                          Space(8),
                          Stxt(
                            text: "${chat.lastMessage}", size: f3, weight: FontWeight.w300,),
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
                        Stxt(text: "${chat.time}", size: f1, color: Colors.black.withOpacity(0.5),),
                        Space(8),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(child: Text("1", style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                    Space(20),
                  ],
                ),
              ),
            ),
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return CustomDialogBox();
          }
          );
        },
      ),
    );
  }
}


class NoMeassage extends StatelessWidget {
  const NoMeassage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/messages.svg"),
            Space(16),
            Text("No messages yet, start your conversation".tr),
            // Text("Start your Conversation".tr)
          ],
        ),
      ),
    );
  }
}

class CustomDialogBox extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xffB5CCD4),
        borderRadius: BorderRadius.circular(8),
      ),
      child:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70.h,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Space(16),
                  Text("Select", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),),
                  Spacer(),
                  // Icon(Icons.close, color: Colors.white,),
                  Space(16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 300.w,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 5,
                              color: Colors.grey.shade400
                          )
                        ]
                    ),
                    child: TextField(
                      style: TextStyle(color: Theme
                          .of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.4), fontWeight: FontWeight.w600),
                      controller: pass,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        // label: Text("Note Title"),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        focusColor: Colors.black,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        suffixIcon: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.search),)
                      ),
                    ),
                  ),
                  Space(16),
                  SizedBox(
                    height: 470.h,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                        itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            height: 60.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: Offset(-2, 4),
                                      color: Colors.grey.shade400
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Space(16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Image.asset("assets/images/pic.png", width: 40,),
                                ),
                                Space(16),
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stxt(text: "Masjid-e-nooraniya",
                                        size: f2,
                                        weight: FontWeight.w600,),
                                      Space(8),
                                      Stxt(
                                        text: "Admin", size: f1, weight: FontWeight.w300,),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.message, color: Theme
                                    .of(context)
                                    .primaryColor
                                    .withOpacity(0.5), size: 30,),
                                Space(20),
                              ],
                            ),
                          ),
                        );
                        }
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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

