import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

import '../../../../widgets/button.dart';

class EditProfileView extends GetView {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        tittle: 'Edit Profile',
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        children: [

          Safa_textfield(
              label: "First Name",
              fillColor: Color(0xffD9D9D9)
          ),
          Safa_textfield(
              label: "Last Name",
            fillColor: Color(0xffD9D9D9)
          ),
          Safa_textfield(
            label: "DOB",suffixIcon: IconButton(onPressed: () {

          }, icon: Icon(Icons.calendar_month_outlined,size: 25,)),fillColor: Color(0xffD9D9D9)
          ),
          Safa_textfield(
            label: "Mobile Number",fillColor: Color(0xffD9D9D9)
          ),
          Safa_textfield(
            label: "Email",fillColor: Color(0xffD9D9D9)
          ),
          5.verticalSpace,
          Stxt(text: "Address:", size: f2,weight: FontWeight.bold,color: Get.theme.primaryColor,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Safa_textfield(
                length: 5,
                label: "Flat No.",width: .25,fillColor: Color(0xffD9D9D9)
              ), Safa_textfield(label: "Street",width: .6,hint: '',fillColor: Color(0xffD9D9D9),),
            ],
          ),
          Safa_textfield(hint: "Line 1",fillColor: Color(0xffD9D9D9)),
          Safa_textfield(hint: "Line 2",fillColor: Color(0xffD9D9D9)),

          SizedBox(height: 25,),
          Column(
            children: [
              SButton(text: "Submit", ontap: () {  },color: Get.theme.primaryColor),
            ],
          )
        ],
      ),
    );
  }
}
