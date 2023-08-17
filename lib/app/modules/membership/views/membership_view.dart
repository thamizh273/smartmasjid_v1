import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/past_payments.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/quick_pay.dart';

import '../../../../global.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/space.dart';
import '../../../../widgets/stext.dart';
import '../../home/views/home_view.dart';
import '../controllers/membership_controller.dart';

class MembershipView extends GetView<MembershipController> {
   MembershipView({Key? key}) : super(key: key);
  MembershipController c = Get.put(MembershipController());

  List<Member> memberList = [
    Member(amount: "500", month: "Jan", image: "assets/images/download.png")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         Container(
           height: 180.h,
           width: double.infinity,
           decoration: BoxDecoration(
             boxShadow: [
               BoxShadow(
                   blurRadius: 6,
                   spreadRadius: 6,
                   offset: Offset(0,4),
                   color: Colors.grey.shade400
               )
             ],
             borderRadius: BorderRadius.only(bottomRight: Radius.circular(32), bottomLeft: Radius.circular(32)),
             gradient: LinearGradient(colors: [
               hexStringToColor("53899B"),
               hexStringToColor("23687F"),
             ]),
           ),
           child: Padding(
             padding: const EdgeInsets.all(16),
             child: Column(
               children: [
                 Space(20),
                 Row(
                   children: [
                     GestureDetector(
                         onTap: (){
                           Navigator.of(context).pop(MaterialPageRoute(builder: (_) => HomeView()));
                         },
                         child: SvgPicture.asset("assets/svg/backnew.svg")),
                     Space(16),
                     Stxt(text: "Membership", size: f5, weight: FontWeight.w600, color: Colors.white,),
                   ],
                 ),
                 Space(70),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Stxt(text: "Janab. ", size: f5, color: Colors.white),
                     Text("Abdullah", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),)
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Stxt(text: "Membership Id: ", size: f3, color: Colors.white),
                     Stxt(text: "321654987", size: f3, color: Colors.white),
                   ],
                 ),
               ],
             ),
           ),
         ),
         Space(16),
         SizedBox(
           height: 480.h,
           child: ListView(
             scrollDirection: Axis.vertical,
             physics: BouncingScrollPhysics(),
             shrinkWrap: true,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("You are paying to "),
                   Text("Masjid-e-nooraniya", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Theme.of(context).primaryColor),),
                 ],
               ),
               Space(8),
               Padding(
                 padding: const EdgeInsets.all(16),
                 child: Container(
                   height: 150,
                   width: double.infinity,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(
                           color: Theme.of(context).primaryColor
                       )
                   ),
                   child: Column(
                     children: [
                       Space(16),
                       Stxt(text: "₹ 500.00", size: f5),
                       Space(8),
                       Stxt(text: "Membership due by 31/07/2023", size: f1),
                       Space(2),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Stxt(text: "Membership Auto pay", size: f4),
                           Obx(() {
                             return Switch(
                               activeColor: Theme.of(context).primaryColor,
                               value: c.switchValue.value,
                               onChanged: (newValue) {
                                 c.switchValue.value = newValue;
                               },
                             );
                           }),
                         ],
                       ),
                       Container(
                         height: 36,
                         width: double.infinity,
                         decoration: BoxDecoration(
                             color: Theme.of(context).primaryColor
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             GestureDetector(
                                 onTap: (){
                                   Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuickPay()));
                                 },
                                 child: Stxt(text: "Pay Now", size: f3, weight: FontWeight.w600, color: Colors.white,))
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               Space(4),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Stxt(text: "Pay for Other Membership", size: f3, color: Theme.of(context).primaryColor, weight: FontWeight.w600,),
                   Icon(Icons.double_arrow_outlined, color: Theme.of(context).primaryColor, size: 20,),
                 ],
               ),
               Space(8),
               Padding(
                 padding: const EdgeInsets.only(right: 12, left: 12),
                 child: Row(
                   children: [
                     Stxt(text: "Past Payments", size: f4),
                     Spacer(),
                     GestureDetector(
                         onTap: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (_) => PastPayments()));
                         },
                         child: Stxt(text: "View all", size: f4, weight: FontWeight.w600, color: Theme.of(context).primaryColor,)),
                   ],
                 ),
               ),
               Space(4),
               Padding(
                 padding: const EdgeInsets.only(left: 12),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Stxt(text: "Jan 2023- Jun 2023", size: f2, color: Colors.black.withOpacity(0.5),),
                   ],
                 ),
               ),
               Space(16),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   SizedBox(
                     height: 270.h,
                     width: 340.w,
                     child: ListView.separated(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemCount: 12,
                       separatorBuilder: (BuildContext context,
                           int index) => const Space(50),
                       itemBuilder: (context, index){
                         return Column(
                           children: [
                             Text("₹ 500", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),),
                             Space(4),
                             Container(
                               height: 185.h,
                               width: 15,
                               decoration: BoxDecoration(
                                 color: Colors.grey,
                                 borderRadius: BorderRadius.circular(16),
                               ),
                             ),
                             Space(4),
                             Stxt(text: "Jan", size: f2, weight: FontWeight.w500,),
                             Space(8),
                             Image.asset("assets/images/download.png", width: 25,)
                           ],
                         );
                       },
                     ),
                   ),
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 12),
                 child: Row(
                   children: [
                     Stxt(text: "Pay Bulk", size: f4)
                   ],
                 ),
               ),
               Space(16),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Container(
                         height: 100,
                         width: 130,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: Theme.of(context).primaryColor
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Stxt(text: "Quarterly", size: f4, color: Colors.white,),
                             Space(16),
                             Stxt(text: "₹ 300", size: f5, color: Colors.white,),
                           ],
                         ),
                       ),
                       Space(16),
                       Container(
                         height: 100,
                         width: 130,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: Theme.of(context).primaryColor
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Stxt(text: "Half yearly", size: f4, color: Colors.white,),
                             Space(16),
                             Stxt(text: "₹ 600", size: f5, color: Colors.white,),
                           ],
                         ),
                       ),
                       Space(16),
                       Container(
                         height: 100,
                         width: 130,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             color: Theme.of(context).primaryColor
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Stxt(text: "Annually", size: f4, color: Colors.white,),
                             Space(16),
                             Stxt(text: "₹ 1,200", size: f5, color: Colors.white,),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               Space(50),
             ],
           ),
         ),

       ],
     ),
    );
  }
}

class Member{
  String? month;
  String? amount;
  String? image;

  Member({
    this.month,
    this.amount,
    this.image,
});
}