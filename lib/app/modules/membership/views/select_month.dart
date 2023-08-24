import 'package:flutter/material.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/stext.dart';

import '../../../../widgets/space.dart';
import '../../donationpage/views/payment_method.dart';
import '../controllers/membership_controller.dart';


class SelectMonth extends StatelessWidget {
  SelectMonth({super.key});

  final memcntrl = Get.put(MembershipController());
  final SvgPicture paid = SvgPicture.asset("assets/svg/paid.svg", width: 16);
  final SvgPicture unpaid = SvgPicture.asset("assets/svg/unpaid.svg", width: 16);
  final Stxt paid1 = Stxt(text: "Paid", size: f2, weight: FontWeight.w500,);
  final Stxt unpaid1 = Stxt(text: "Unpaid", size: f2, weight: FontWeight.w500,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Select Month",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stxt(
              text: "Your unpaid membership months are shown here. \nYou can select and pay for them in total or in single months.",
              size: f2,
              textAlign: TextAlign.center, weight: FontWeight.w500,),
            Space(40),
            SizedBox(
              height: 400.h,
              child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery
                        .of(context)
                        .orientation ==
                        Orientation.landscape ? 3 : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 50,
                    childAspectRatio: (2 / 1),
                  ),
                  itemBuilder: (context, index,) {
                    SvgPicture pay = index % 2 == 0? paid : unpaid;
                    Stxt pay1 = index % 2 == 0 ? paid1:unpaid1;
                    return FractionallySizedBox(
                      heightFactor: 1.6,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(color: Theme
                              .of(context)
                              .primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stxt(text: "January",
                                    size: f3,
                                    weight: FontWeight.w500,),
                                  Space(8),
                                  Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                    ),
                                    child: Transform.scale(
                                      scale: 0.75,
                                      // Adjust this value to change the checkbox size.
                                      child: Obx(() {
                                        return Checkbox(
                                          activeColor: Get.theme.primaryColor,
                                          checkColor: Colors.white,
                                          value: memcntrl.isChecked.value,
                                          onChanged: (value) {
                                            memcntrl.isChecked.value = value!;
                                            memcntrl.update();
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              Space(4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  pay1,
                                  Space(8),
                                  pay
                                ],
                              ),
                              Space(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stxt(text: "₹ 200", size: f3, weight: FontWeight.w600, color: Get.theme.primaryColor,),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            Spacer(),
            Container(
              height: 50.h,
              width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(16),
               color: Theme.of(context).primaryColor,
               boxShadow: [
                 BoxShadow(
                   blurRadius: 2,
                   spreadRadius: 2,
                   offset: Offset(0,4),
                   color: Colors.grey.shade400
                 )
               ]
             ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stxt(text: "Pay Membership of ", size: f3, weight: FontWeight.w500, color: Colors.white,),
                  Space(8),
                  Stxt(text: "₹ 200", size: f4, weight: FontWeight.w600, color: Colors.white,),
                  Space(8),
                  IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentMethod()));
                  }, icon: Icon(Icons.send, color: Colors.white, size: 25,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
