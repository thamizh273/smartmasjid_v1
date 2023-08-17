import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/membership/controllers/membership_controller.dart';
import 'package:smartmasjid_v1/app/modules/membership/views/payment_method.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';

import '../../../../widgets/space.dart';

class QuickPay extends StatelessWidget {
   QuickPay({super.key});
  MembershipController c = Get.put(MembershipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tittle: "Quick Pay",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Space(16),
              Container(
                width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 color: Colors.white
               ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Space(8),
                      Stxt(text: "Pay MemberShip", size: f5, color: Theme.of(context).primaryColor,),
                      Space(16),
                      Row(
                        children: [
                          Stxt(text: "I would like to pay for", size: f2),
                        ],
                      ),
                  Space(16),
                  Container(
                    width: 400,
                    child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          child: Text('Own Membership'),
                          value: 'one',
                        ),
                        DropdownMenuItem<String>(
                          child: Text('For Other Membership'),
                          value: 'two',
                        ),
                      ],
                      onChanged: (String? value) {
                        value = c.value;
                      },
                      hint: Text('Select Membership Method'),
                      value: c.value,
                    ),
                  ),
                      Space(8),
                      Row(
                        children: [
                          Text("Mobile Number", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Container(
                        height: 30,
                        child: TextField(
                        ),
                      ),
                      Space(12),
                      Text("OR", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                      Space(12),
                      Row(
                        children: [
                          Text("Membership Id", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Space(16),
              ElevatedButton(
                  onPressed: ()   {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentMethod()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 40),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Color(0xff11323B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4.0,
                  ),
                  child: Text("Pay now", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18, color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
