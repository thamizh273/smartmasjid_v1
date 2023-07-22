import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/controllers/edit_profile_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

import '../../../../widgets/button.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);
  final controller = Get.put(EditProfileController());

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
          Safa_textfield(label: "First Name", fillColor: Color(0xffD9D9D9),controller: controller.firstnamectrl,),
          Safa_textfield(label: "Last Name", fillColor: Color(0xffD9D9D9),controller: controller.lastnamectrl,),
          Safa_textfield(
              readOnly: true,
              // onChanged: (value) {
              //   print(value);
              //
              // },
              controller: controller.dobController,
              hint: "dd/mm/yyyy",
              label: "DOB",
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.chooseDate();
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    size: 25,
                  )),
              fillColor: Color(0xffD9D9D9)),
          Safa_textfield(label: "Mobile Number", fillColor: Color(0xffD9D9D9),controller: controller.mobilenumberctrl,),
          Safa_textfield(label: "Email", fillColor: Color(0xffD9D9D9),controller: controller.emailctrl,),
          5.verticalSpace,
          Stxt(
            text: "Address:",
            size: f2,
            weight: FontWeight.bold,
            color: Get.theme.primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Safa_textfield(
                  length: 5,
                  label: "Flat No.",
                  width: .25,
                  fillColor: Color(0xffD9D9D9)),
              Safa_textfield(
                label: "Address Line 1",
                width: .6,
                hint: '',
                fillColor: Color(0xffD9D9D9),
              ),
            ],
          ),
          Safa_textfield(label: "Address Line 2", fillColor: Color(0xffD9D9D9)),
          Safa_textfield(label: "Pincode", fillColor: Color(0xffD9D9D9)),
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              SButton(
                  text: "Submit", ontap: () {}, color: Get.theme.primaryColor),
            ],
          )
        ],
      ),
    );
  }
}
