import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/archivepage/views/archivepage_view.dart';

import '../../../../global.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/stext.dart';
import '../../home/widgets/appBar.dart';
import '../controllers/notificationpage_controller.dart';
class Notification {
  final String name;
  final String location;
  final String imagePath;

  Notification({required this.name, required this.location, required this.imagePath});
}

class NotificationpageView extends GetView<NotificationpageController> {
  List<Notification> notificationList = [
    // Notification(name: "Isha Prayer Reminder", location: "Masjid-e-nooraniya", imagePath: "imagePath"),
    // Notification(name: "Isha Prayer Reminder", location: "Masjid-e-nooraniya", imagePath: "imagePath"),
    // Notification(name: "Isha Prayer Reminder", location: "Masjid-e-nooraniya", imagePath: "imagePath"),
  ];
   NotificationpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(tittle: 'Notifications',
          action: [
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ArchivepageView()));
            }, icon: Icon(Icons.archive,color: Colors.white, size: 30,))
          ],
        ),
        body:
        // ListView.builder(
        //   padding: EdgeInsets.only(top: 20),
        //   physics: BouncingScrollPhysics(),
        //   itemCount: 10,
        //   //shrinkWrap: true,
        //   itemBuilder: (context, index) {
        //     return SizedBox(
        //       height: 100,
        //       child: Card(
        //         color: Colors.grey.shade300,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10)),
        //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //         child: Row(
        //           children: [
        //             Container(
        //               width: 12,
        //               decoration: BoxDecoration(
        //                   color: Theme.of(context).primaryColor,
        //                   borderRadius: BorderRadius.horizontal(
        //                       left: Radius.circular(10))),
        //             ),
        //             SizedBox(width: 8),
        //             CircleAvatar(
        //               backgroundColor: Colors.white,
        //               radius: 30,
        //               child: Image.asset('assets/images/logo.png',height: 45,fit: BoxFit.cover,),
        //             ),
        //             SizedBox(width: 12),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Stxt(
        //                   text: 'Isha Prayer Remainder',
        //                   size: f2,
        //                   weight: FontWeight.bold,
        //                 ),
        //                 SizedBox(height: 5,),
        //                 Stxt(
        //                   text: 'Masjid-e-nooraniya',
        //                   size: f1,
        //                 ),
        //               ],
        //             ),
        //             Spacer(),
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Icon(
        //                     Icons.close,
        //                     color: Colors.black87,
        //                   ),
        //                   Stxt(text: '12 hrs ago', size: f1)
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // )
        notificationList.isEmpty?NoNotificationYet():   ListView.builder(
          padding: EdgeInsets.only(top: 20),
          physics: BouncingScrollPhysics(),
          itemCount: notificationList.length,
          // shrinkWrap: true,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(index.toString()),

              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                // Handle the dismissal action here
                if (direction == DismissDirection.startToEnd) {
                  // Swiped from left to right (e.g., archive or mark as read)
                }
                else if (direction == DismissDirection.endToStart) {
                  // Swiped from right to left (e.g., delete or dismiss)

                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Archived')),
                );
              },
              background: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(      borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.shade400],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Icon(
                  Icons.archive_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              secondaryBackground: Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.shade400],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: Icon(
                  Icons.archive_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              child: SizedBox(
                height: 100,
                child: Card(
                  color: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10))),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Image.asset('assets/images/masjidlogonew.png',fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stxt(
                            text: 'Isha Prayer Remainder',
                            size: f2,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: 5,),
                          Stxt(
                            text: 'Masjid-e-nooraniya',
                            size: f1,
                          ),
                        ],
                      ),
                      Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Icon(
                      //         Icons.close,
                      //         color: Colors.black87,
                      //       ),
                      //       Stxt(text: '12 hrs ago', size: f1)
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            );
          },
        )

    );
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
            text: 'No Notification Yet',
            size: 20,
            weight: FontWeight.bold,
          ),
           Padding(
            padding: EdgeInsets.all(8.0),
            child: Stxt(
              text: "When you get notifications, they'll show up \n  here",
              size: f2,
              textAlign: TextAlign.center,
            ),
          ),
          SButton(text: 'Refresh',color: Color(0xff19657E), ontap: () {  })
        ],
      ),
    );
  }
}