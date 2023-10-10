import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smartmasjid_v1/app/modules/archivepage/views/archivepage_view.dart';
import 'package:smartmasjid_v1/widgets/loading.dart';

import '../../../../global.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/stext.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/notificationpage_controller.dart';



class NotificationpageView extends GetView<NotificationpageController> {


  NotificationpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          tittle: 'notifications'.tr,
          action: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ArchivepageView()));
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
        body: Obx(() {
          return controller.isloading.value?  DialogHelper.showLoading():controller.notificationData.value.getNotificationLog!.length ==
                      0
                  ? NoNotificationYet()
                  : ListView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      physics: BouncingScrollPhysics(),
                      itemCount: controller
                          .notificationData.value.getNotificationLog!.length,
                      // itemExtent: 80,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = controller
                            .notificationData.value.getNotificationLog![index];
                        return
                            // Dismissible(
                            // key: Key(index.toString()),
                            // direction: DismissDirection.horizontal,
                            // onDismissed: (direction) {
                            //   // Handle the dismissal action here
                            //   if (direction == DismissDirection.startToEnd) {
                            //     // Swiped from left to right (e.g., archive or mark as read)
                            //   } else if (direction ==
                            //       DismissDirection.endToStart) {
                            //     // Swiped from right to left (e.g., delete or dismiss)
                            //   }
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text('Archived')),
                            //   );
                            // },
                            // background: Container(
                            //   margin: EdgeInsets.only(left: 10),
                            //   alignment: Alignment.centerLeft,
                            //   padding: EdgeInsets.symmetric(horizontal: 20),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     gradient: LinearGradient(
                            //       colors: [Colors.green, Colors.green.shade400],
                            //       begin: Alignment.centerLeft,
                            //       end: Alignment.centerRight,
                            //     ),
                            //   ),
                            //   child: Icon(
                            //     Icons.archive_outlined,
                            //     color: Colors.white,
                            //     size: 30,
                            //   ),
                            // ),
                            // secondaryBackground: Container(
                            //   margin: EdgeInsets.only(right: 10),
                            //   alignment: Alignment.centerRight,
                            //   padding: EdgeInsets.symmetric(horizontal: 20),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     gradient: LinearGradient(
                            //       colors: [Colors.green, Colors.green.shade400],
                            //       begin: Alignment.centerRight,
                            //       end: Alignment.centerLeft,
                            //     ),
                            //   ),
                            //   child: Icon(
                            //     Icons.archive_outlined,
                            //     color: Colors.white,
                            //     size: 30,
                            //   ),
                            // ),
                            // child:
                            Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          child: ListTile(
                            minLeadingWidth: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: Get.theme.primaryColor)),
                            tileColor: Colors.white,
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30.r,
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 4,
                                  )
                                ], borderRadius: BorderRadius.circular(30.r)),
                                child: Image.asset(
                                  'assets/images/masjidlogonew.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Stxt(
                              text: '${data.notificationMessage}',
                              //   text: 'szdfxghvj.',
                              size: f2,
                              weight: FontWeight.bold,
                              color: Get.theme.primaryColor,
                            ),
                            subtitle: Stxt(
                              //   text: '${data.description}',
                              text: '${data.description}',
                              size: f1,
                              color: Get.theme.primaryColor,
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {}, child: Icon(Icons.close)),
                                Spacer(),
                                Stxt(
                                  text: DateFormat('hh:mm a').format(
                                      DateTime.parse(
                                          "${data.createdAt!.toLocal()}")),
                                  size: f1,
                                  color: Get.theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        );

                        // SizedBox(
                        //     height: 100,
                        //     child: Card(
                        //       color: Colors.grey.shade300,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10)),
                        //       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //       child: Row(
                        //         children: [
                        //           Container(
                        //             width: 12,
                        //             decoration: BoxDecoration(
                        //                 color: Theme.of(context).primaryColor,
                        //                 borderRadius: BorderRadius.horizontal(
                        //                     left: Radius.circular(10))),
                        //           ),
                        //           SizedBox(width: 8),
                        //           CircleAvatar(
                        //             backgroundColor: Colors.white,
                        //             radius: 30,
                        //             child: Image.asset('assets/images/masjidlogonew.png',fit: BoxFit.cover,),
                        //           ),
                        //           SizedBox(width: 12),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Stxt(
                        //                 text: 'Isha Prayer Remainder',
                        //                 size: f2,
                        //                 weight: FontWeight.bold,
                        //               ),
                        //               SizedBox(height: 5,),
                        //               Stxt(
                        //                 text: 'Masjid-e-nooraniya',
                        //                 size: f1,
                        //               ),
                        //             ],
                        //           ),
                        //           Spacer(),
                        //           // Padding(
                        //           //   padding: const EdgeInsets.all(8.0),
                        //           //   child: Column(
                        //           //     crossAxisAlignment: CrossAxisAlignment.end,
                        //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           //     children: [
                        //           //       Icon(
                        //           //         Icons.close,
                        //           //         color: Colors.black87,
                        //           //       ),
                        //           //       Stxt(text: '12 hrs ago', size: f1)
                        //           //     ],
                        //           //   ),
                        //           // )
                        //         ],
                        //       ),
                        //     ),
                        //  ),
                        // );
                      },
                    );
        }));
  }
}

class NoNotificationYet extends StatelessWidget {
  const NoNotificationYet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/notificationbellnew.svg'),
          const SizedBox(
            height: 20,
          ),
          Stxt(
            text: 'no_notification_yet'.tr,
            size: 20,
            weight: FontWeight.bold,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Stxt(
              text: "When_you_get_notifications,_they'll_show_up_here.".tr,
              size: f2,
              textAlign: TextAlign.center,
            ),
          ),
          SButton(text: 'refresh'.tr, color: Color(0xff19657E), ontap: () {})
        ],
      ),
    );
  }
}
