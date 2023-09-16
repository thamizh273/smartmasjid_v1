import 'dart:convert';

import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/messagepage/views/chat_page.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/loading.dart';
import '../../../routes/export.dart';
import '../controllers/messagepage_controller.dart';

class ChatUserListPage extends StatelessWidget {
  ChatUserListPage({super.key});
   final  chatUserListCtrl_=Get.put(MessagepageController());
  final TextEditingController pass = TextEditingController();
  final TextEditingController c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tittle: "Contacts".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                return chatUserListCtrl_.isLoadingschatUserList.value
                    ? loading(context)
                    : Column(
                        children: [
                          Safa_textfield(
                            fillColor: clr_white,
                              hint: "Search".tr,
                              suffixIcon: IconButton(
                                onPressed: () {
                                //  Navigator.pop(context);
                                },
                                icon: Icon(Icons.search),
                              )),

                          15.verticalSpace,
                          ListView.separated(
                               
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: chatUserListCtrl_.chatListUserData.value
                                  .getChatUserList!.length,
                              itemBuilder: (context, index) {
                                var data = chatUserListCtrl_.chatListUserData.value
                                    .getChatUserList![index];
                                return ListTile(
                                  onTap: (){
                                    Get.to(ChatPage(username: data.userName!, profileImg: data.profileImage!,));
                                  },
                                  hoverColor: Colors.brown,
                                  splashColor: Colors.red,
                                  selectedColor: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  tileColor: clr_white,
                                  leading: ClipRRect(
                                    borderRadius:BorderRadius.circular(50),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child:data.profileImage== "null"
                                          ? Image.asset("assets/images/app_logo.png")
                                          : Image(
                                          image: MemoryImage(base64Decode(data.profileImage
                                              .toString())))


                                    ),
                                  ),
                                  title: Stxt(
                                    text: "${data.userName}",
                                    overflow: TextOverflow.ellipsis,
                                    size: f2,
                                    weight: FontWeight.w600,
                                  ),
                                  subtitle: Stxt(
                                    text: "${data.post}",
                                    size: f1,
                                    weight: FontWeight.w300,
                                  ),
                                  trailing: Icon(
                                    Icons.message,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    size: 30,
                                  ),
                                );

                              }, separatorBuilder: (BuildContext context, int index) { return 5.verticalSpace; },)
                        ],
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
