import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smartmasjid_v1/app/modules/home/widgets/appBar.dart';
import 'package:smartmasjid_v1/app/modules/profilePage/controllers/edit_profile_controller.dart';
import 'package:smartmasjid_v1/app/routes/export.dart';
import 'package:smartmasjid_v1/widgets/Stextfield.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/button.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        tittle: 'edit_profile'.tr,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        children: [
          Safa_textfield(
            label: "first_name".tr,
            fillColor: Color(0xffD9D9D9),
            controller: controller.firstnamectrl,
          ),
          Safa_textfield(
            label: "last_name".tr,
            fillColor: Color(0xffD9D9D9),
            controller: controller.lastnamectrl,
          ),
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
          Safa_textfield(
            readOnly: true,
            label: "mobile_number".tr,
            fillColor: Color(0xffD9D9D9),
            controller: controller.mobilenumberctrl,
          ),
          Safa_textfield(
            readOnly: true,
            label: "email".tr,
            fillColor: Color(0xffD9D9D9),
            controller: controller.emailctrl,
          ),
          5.verticalSpace,
          Stxt(
            text: "address:".tr,
            size: f2,
            weight: FontWeight.bold,
            color: Get.theme.primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Safa_textfield(
                  controller: controller.doorNoctrl,
                  length: 5,
                  label: "door_no.".tr,
                  width: .25,
                  fillColor: Color(0xffD9D9D9)),
              Safa_textfield(
                controller: controller.streetctrl,
                label: "street".tr,
                width: .6,
                hint: '',
                fillColor: Color(0xffD9D9D9),
              ),
            ],
          ),
          Safa_textfield(controller: controller.areactrl,
              label: "area".tr,
              fillColor: Color(0xffD9D9D9)),
          Safa_textfield(controller: controller.districctrl,
              label: "district".tr,
              fillColor: Color(0xffD9D9D9)),
          Safa_textfield(controller: controller.statectrl,
              label: "state".tr,
              fillColor: Color(0xffD9D9D9)),
          Safa_textfield(controller: controller.pincodectrl,
              label: "pincode".tr,
              fillColor: Color(0xffD9D9D9)),
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Obx(() {
                return SButton(
                    text: controller.isLoading.value ? "Loading" : "submit".tr,
                    ontap: () {
                      controller.updateProfile();
                      controller.update();
                    },
                    color: Get.theme.primaryColor,
                    txtClr: clr_white);
              }),
            ],
          )
        ],
      ),
    );
  }
}
