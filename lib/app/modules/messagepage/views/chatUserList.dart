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
                    ?  DialogHelper.showLoading()
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
                                    chatUserListCtrl_.indexof.value=index;
                                    //chatUserListCtrl_.get_chatMessage(data.userId!.id);
                                    chatUserListCtrl_.get_chatMessage(data.userId!.id,data.userName.toString(),"${data.profileImage}");
                                  },
                                  hoverColor: Colors.brown,
                                  splashColor: Get.theme.primaryColor,
                                  selectedColor: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  tileColor: clr_white,
                                  leading: ClipRRect(
                                    borderRadius:BorderRadius.circular(50),
                                    child: Container(
                                        width: 50,height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child:(data.profileImage== "null"||data.profileImage =="")
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
                                    color: Get.theme.primaryColor,
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
